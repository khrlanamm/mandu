import {Timestamp} from "firebase-admin/firestore";
import {z} from "zod";
import type {Caller} from "../core/claims";
import {AppError} from "../core/errors";
import {db, storage} from "../core/firebase";
import {memberRef, schoolRef} from "../core/refs";
import {parsePayload} from "../core/validation";
import {CATEGORY_KEYS, REPORT_CATEGORIES, type Priority} from "../domain/catalog";
import type {MemberDoc, SchoolDoc} from "../domain/models";
import {
  MAX_ATTACHMENT_BYTES,
  MAX_ATTACHMENTS,
  staffTicketRoute,
  type Attachment,
  type TicketDoc,
  type TimelineDoc,
} from "../domain/tickets";
import {notifyUsers, roleUids, verifierUids} from "../notifications/notify";
import {classifyTicket, normalizeLocation} from "./classify";
import {attachmentPrefix, ticketCounterRef, ticketOwnerRef, ticketRef, ticketsRef} from "./refs";

export const attachmentSchema = z.object({
  path: z.string().min(1).max(512),
  name: z.string().trim().min(1).max(200),
  contentType: z.string().regex(/^(image\/[a-z0-9.+-]+|application\/pdf)$/, "Lampiran harus berupa gambar atau PDF."),
  size: z.number().int().positive().max(MAX_ATTACHMENT_BYTES, "Ukuran lampiran maksimal 10 MB."),
});

const submitSchema = z.object({
  schoolId: z.string().min(1),
  ticketId: z.string().regex(/^[A-Za-z0-9]{16,40}$/, "ID laporan tidak valid."),
  category: z.enum(CATEGORY_KEYS as [string, ...string[]]),
  subcategory: z.string().min(1).max(40),
  title: z.string().trim().min(5, "Judul minimal 5 karakter.").max(120),
  description: z.string().trim().min(10, "Ceritakan kejadian minimal 10 karakter.").max(5000),
  location: z.string().trim().min(2, "Isi lokasi kejadian.").max(200),
  incidentDate: z.string().regex(/^\d{4}-\d{2}-\d{2}$/).nullable().optional(),
  incidentTime: z.string().regex(/^\d{2}:\d{2}$/).nullable().optional(),
  anonymous: z.boolean(),
  contactWhatsapp: z.string().trim().regex(/^\+?\d{9,15}$/, "Nomor WhatsApp tidak valid.").nullable().optional(),
  details: z.object({
    role: z.enum(["korban", "saksi"]).nullable().optional(),
    frequency: z.string().trim().max(50).nullable().optional(),
    involved: z.string().trim().max(300).nullable().optional(),
  }).optional(),
  attachments: z.array(attachmentSchema).max(MAX_ATTACHMENTS, `Maksimal ${MAX_ATTACHMENTS} lampiran.`).default([]),
});

/** Pastikan lampiran sudah diunggah ke folder laporan ini di Storage. */
export async function assertAttachmentsUploaded(attachments: Attachment[], prefix: string): Promise<void> {
  for (const attachment of attachments) {
    if (!attachment.path.startsWith(prefix) || attachment.path.includes("..")) {
      throw new AppError("invalid-argument", "Lokasi lampiran tidak valid.");
    }
    const [exists] = await storage().bucket().file(attachment.path).exists();
    if (!exists) throw new AppError("failed-precondition", "Lampiran belum selesai diunggah. Coba lagi.");
  }
}

const jakartaYear = (date: Date) => new Intl.DateTimeFormat("en", {timeZone: "Asia/Jakarta", year: "numeric"}).format(date);

const addHours = (timestamp: Timestamp, hours: number) => Timestamp.fromMillis(timestamp.toMillis() + hours * 3_600_000);

async function findPossibleDuplicate(schoolId: string, category: string, location: string, now: Timestamp): Promise<string | null> {
  const since = Timestamp.fromMillis(now.toMillis() - 7 * 24 * 3_600_000);
  const snapshot = await ticketsRef(schoolId).where("category", "==", category).where("createdAt", ">=", since).limit(50).get();
  const target = normalizeLocation(location);
  const match = snapshot.docs.find((doc) => {
    const ticket = doc.data() as TicketDoc;
    return ticket.status !== "ditolak" && ticket.status !== "dibatalkan" && normalizeLocation(ticket.location) === target;
  });
  return match?.id ?? null;
}

export interface SubmitResult {
  ticketId: string;
  number: string;
  priority: Priority;
}

/** Siswa mengirim laporan. Nomor tiket dibuat berurutan per sekolah per tahun. */
export async function submitTicket(caller: Caller, data: unknown): Promise<SubmitResult> {
  const input = parsePayload(submitSchema, data);
  const {schoolId, ticketId} = input;
  if (caller.claims.sid !== schoolId || caller.claims.role !== "siswa") {
    throw new AppError("permission-denied", "Hanya siswa aktif sekolah ini yang dapat mengirim laporan.");
  }

  const [school, member] = await Promise.all([
    schoolRef(schoolId).get().then((snapshot) => snapshot.data() as SchoolDoc | undefined),
    memberRef(schoolId, caller.uid).get().then((snapshot) => snapshot.data() as MemberDoc | undefined),
  ]);
  if (!school?.active || !school.services.lapor) {
    throw new AppError("failed-precondition", "Layanan Lapor sedang dinonaktifkan oleh sekolah.");
  }
  if (member?.status !== "active") throw new AppError("permission-denied", "Keanggotaanmu di sekolah ini belum aktif.");

  const category = REPORT_CATEGORIES.find((entry) => entry.key === input.category)!;
  const subcategory = category.subcategories.find((entry) => entry.key === input.subcategory);
  if (!subcategory) throw new AppError("invalid-argument", "Subkategori tidak sesuai kategori.");

  await assertAttachmentsUploaded(input.attachments, attachmentPrefix(schoolId, ticketId));

  const now = Timestamp.now();
  const classification = classifyTicket(input);
  const possibleDuplicateOf = await findPossibleDuplicate(schoolId, input.category, input.location, now);
  const verifyHours = classification.priority === "darurat" ? school.slaHours.darurat : school.slaHours.verifikasi;

  const number = await db().runTransaction(async (tx) => {
    const [counter, existing] = await Promise.all([tx.get(ticketCounterRef(schoolId)), tx.get(ticketRef(schoolId, ticketId))]);
    if (existing.exists) throw new AppError("already-exists", "Laporan ini sudah terkirim.");

    const year = jakartaYear(now.toDate());
    const sequence = ((counter.get(year) as number | undefined) ?? 0) + 1;
    const ticketNumber = `MND-${year}-${String(sequence).padStart(4, "0")}`;

    const ticket: TicketDoc = {
      number: ticketNumber,
      schoolId,
      category: category.key,
      categoryLabel: category.label,
      subcategory: subcategory.key,
      subcategoryLabel: subcategory.label,
      title: input.title,
      description: input.description,
      location: input.location,
      incidentDate: input.incidentDate ?? null,
      incidentTime: input.incidentTime ?? null,
      details: {
        role: input.details?.role ?? null,
        frequency: input.details?.frequency || null,
        involved: input.details?.involved || null,
      },
      attachments: input.attachments,
      anonymous: input.anonymous,
      reporter: input.anonymous ? null : {name: member.displayName, kelas: member.kelas},
      contactWhatsapp: input.contactWhatsapp || null,
      priority: classification.priority,
      priorityReason: classification.priorityReason,
      suggestedCategory: classification.suggestedCategory,
      possibleDuplicateOf,
      status: "menunggu_verifikasi",
      unitId: null,
      unitName: null,
      infoRequest: null,
      resolution: null,
      rejection: null,
      rating: null,
      sla: {verifyDueAt: addHours(now, verifyHours), resolveDueAt: null},
      reminders: {verify: false, resolve: false},
      createdAt: now,
      updatedAt: now,
      verifiedAt: null,
      resolvedAt: null,
      closedAt: null,
    };
    const created: TimelineDoc = {
      type: "dibuat",
      visibility: "public",
      message: "Laporan diterima dan menunggu verifikasi.",
      actorRole: "pelapor",
      actorName: input.anonymous ? null : member.displayName,
      attachments: [],
      createdAt: now,
    };

    tx.set(ticketCounterRef(schoolId), {[year]: sequence}, {merge: true});
    tx.create(ticketRef(schoolId, ticketId), ticket);
    tx.create(ticketOwnerRef(schoolId, ticketId), {uid: caller.uid, anonymous: input.anonymous, createdAt: now});
    tx.create(ticketRef(schoolId, ticketId).collection("timeline").doc(), created);
    return ticketNumber;
  });

  const urgent = classification.priority === "darurat";
  const recipients = new Set(await verifierUids(schoolId));
  if (urgent) (await roleUids(schoolId, ["admin", "konselor"])).forEach((uid) => recipients.add(uid));
  await notifyUsers(recipients, {
    type: "tiket_baru",
    title: urgent ? `DARURAT · ${number}` : `Laporan baru · ${number}`,
    body: `${category.label}: ${input.title}`,
    route: staffTicketRoute(ticketId),
    schoolId,
    ticketId,
    urgent,
  });

  return {ticketId, number, priority: classification.priority};
}
