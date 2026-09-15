import {Timestamp} from "firebase-admin/firestore";
import type {CallableRequest} from "firebase-functions/v2/https";
import {z} from "zod";
import {readClaims, type Caller} from "../core/claims";
import {AppError} from "../core/errors";
import {db} from "../core/firebase";
import {SCHOOL_CODE_PATTERN} from "../core/ids";
import {consumeRateLimit, rateLimitKey} from "../core/rateLimit";
import {memberRef, schoolCodeRef, schoolRef} from "../core/refs";
import {parsePayload} from "../core/validation";
import {
  ASPIRATION_TOPIC_KEYS,
  ASPIRATION_TOPICS,
  ASPIRATION_TYPE_LABELS,
  ASPIRATION_TYPES,
  staffAspirationRoute,
  type AspirationDoc,
} from "../domain/aspirations";
import type {MemberDoc, SchoolCodeDoc, SchoolDoc} from "../domain/models";
import {notifyUsers, verifierUids} from "../notifications/notify";
import {moderateText} from "./moderation";

const HOUR = 3_600_000;

const content = {
  type: z.enum(ASPIRATION_TYPES),
  topic: z.enum(ASPIRATION_TOPIC_KEYS as [string, ...string[]]),
  title: z.string().trim().min(5, "Judul minimal 5 karakter.").max(120),
  content: z.string().trim().min(10, "Tuliskan aspirasi minimal 10 karakter.").max(3000),
};

const submitSchema = z.object({schoolId: z.string().min(1), anonymous: z.boolean(), ...content});
const publicSchema = z.object({
  code: z.string().trim().toUpperCase().regex(SCHOOL_CODE_PATTERN, "Kode sekolah tidak valid."),
  ...content,
});

export const aspirationsRef = (schoolId: string) => schoolRef(schoolId).collection("aspirations");
export const aspirationOwnerRef = (schoolId: string, id: string) => schoolRef(schoolId).collection("aspirationOwners").doc(id);
const counterRef = (schoolId: string) => schoolRef(schoolId).collection("counters").doc("aspirations");

const jakartaYear = (date: Date) => new Intl.DateTimeFormat("en", {timeZone: "Asia/Jakarta", year: "numeric"}).format(date);

/** Caller opsional untuk callable yang boleh dipanggil tanpa login. */
export const optionalCaller = (request: CallableRequest): Caller | null =>
  request.auth ? {uid: request.auth.uid, claims: readClaims(request.auth.token)} : null;

export interface SubmitAspirationResult {
  aspirationId: string;
  number: string;
  flagged: boolean;
}

interface Sender {
  source: AspirationDoc["source"];
  uid: string | null;
  anonymous: boolean;
  identity: {name: string; kelas: string | null} | null;
}

async function createAspiration(
  schoolId: string,
  input: z.infer<typeof publicSchema> | z.infer<typeof submitSchema>,
  sender: Sender,
): Promise<SubmitAspirationResult> {
  const title = moderateText(input.title);
  const body = moderateText(input.content);
  const flagged = title.flagged || body.flagged;
  const ref = aspirationsRef(schoolId).doc();
  const now = Timestamp.now();

  const number = await db().runTransaction(async (tx) => {
    const counter = await tx.get(counterRef(schoolId));
    const year = jakartaYear(now.toDate());
    const sequence = ((counter.get(year) as number | undefined) ?? 0) + 1;
    const aspirationNumber = `ASP-${year}-${String(sequence).padStart(4, "0")}`;

    const doc: AspirationDoc = {
      number: aspirationNumber,
      schoolId,
      type: input.type,
      typeLabel: ASPIRATION_TYPE_LABELS[input.type],
      topic: input.topic,
      topicLabel: ASPIRATION_TOPICS.find((topic) => topic.key === input.topic)!.label,
      title: title.text,
      content: body.text,
      source: sender.source,
      anonymous: sender.anonymous,
      flagged,
      status: "diterima",
      response: null,
      board: "none",
      publishedAt: null,
      supportCount: 0,
      createdAt: now,
      updatedAt: now,
    };
    tx.set(counterRef(schoolId), {[year]: sequence}, {merge: true});
    tx.create(ref, doc);
    if (sender.uid) tx.create(aspirationOwnerRef(schoolId, ref.id), {uid: sender.uid, createdAt: now});
    if (sender.identity) tx.create(ref.collection("private").doc("identity"), sender.identity);
    return aspirationNumber;
  });

  await notifyUsers(await verifierUids(schoolId), {
    type: "aspirasi_baru",
    title: `Aspirasi baru · ${number}`,
    body: `${ASPIRATION_TYPE_LABELS[input.type]}: ${title.text}`,
    route: staffAspirationRoute(ref.id),
    schoolId,
  });
  return {aspirationId: ref.id, number, flagged};
}

/** Siswa aktif mengirim aspirasi dari aplikasi. */
export async function submitAspiration(caller: Caller, data: unknown): Promise<SubmitAspirationResult> {
  const input = parsePayload(submitSchema, data);
  if (caller.claims.sid !== input.schoolId || caller.claims.role !== "siswa") {
    throw new AppError("permission-denied", "Hanya siswa aktif sekolah ini yang dapat mengirim aspirasi dari aplikasi.");
  }
  const [school, member] = await Promise.all([
    schoolRef(input.schoolId).get().then((snapshot) => snapshot.data() as SchoolDoc | undefined),
    memberRef(input.schoolId, caller.uid).get().then((snapshot) => snapshot.data() as MemberDoc | undefined),
  ]);
  if (!school?.active || !school.services.aspirasi) {
    throw new AppError("failed-precondition", "Layanan Aspirasi sedang dinonaktifkan oleh sekolah.");
  }
  if (member?.status !== "active") throw new AppError("permission-denied", "Keanggotaanmu di sekolah ini belum aktif.");

  await consumeRateLimit(rateLimitKey("aspirasi-siswa", caller.uid), 10, 24 * HOUR, "Kamu sudah mengirim 10 aspirasi hari ini. Coba lagi besok.");
  return createAspiration(input.schoolId, input, {
    source: "siswa",
    uid: caller.uid,
    anonymous: input.anonymous,
    identity: input.anonymous ? null : {name: member.displayName, kelas: member.kelas},
  });
}

export interface PublicAspirationResult {
  number: string;
  schoolName: string;
  flagged: boolean;
}

/** Tamu (tanpa login atau login anonim) mengirim aspirasi lewat kode/QR sekolah. Tanpa identitas dan pelacakan. */
export async function submitPublicAspiration(caller: Caller | null, data: unknown, ip: string | undefined): Promise<PublicAspirationResult> {
  const input = parsePayload(publicSchema, data);
  const codeDoc = (await schoolCodeRef(input.code).get()).data() as SchoolCodeDoc | undefined;
  const school = codeDoc ? (await schoolRef(codeDoc.schoolId).get()).data() as SchoolDoc | undefined : undefined;
  if (!codeDoc || !school?.active) throw new AppError("not-found", "Kode sekolah tidak ditemukan.");
  if (!school.services.aspirasi || !school.publicAspiration) {
    throw new AppError("failed-precondition", "Sekolah ini belum membuka aspirasi tanpa login.");
  }

  const tooMany = "Terlalu banyak aspirasi dari perangkat ini. Coba lagi dalam satu jam.";
  if (ip) await consumeRateLimit(rateLimitKey("aspirasi-ip", ip), 10, HOUR, tooMany);
  if (caller) await consumeRateLimit(rateLimitKey("aspirasi-tamu", caller.uid), 3, HOUR, tooMany);

  const result = await createAspiration(codeDoc.schoolId, input, {source: "tamu", uid: null, anonymous: true, identity: null});
  return {number: result.number, schoolName: school.name, flagged: result.flagged};
}
