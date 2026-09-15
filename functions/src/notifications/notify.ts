import {createHash} from "node:crypto";
import {FieldValue, type QueryDocumentSnapshot} from "firebase-admin/firestore";
import * as logger from "firebase-functions/logger";
import {z} from "zod";
import type {Caller} from "../core/claims";
import {db, messaging} from "../core/firebase";
import {schoolRef, userRef} from "../core/refs";
import {parsePayload} from "../core/validation";
import type {MemberDoc} from "../domain/models";

export interface NotificationInput {
  /** mis. tiket_baru, tiket_diperbarui, pesan_curhat */
  type: string;
  title: string;
  body: string;
  /** Rute aplikasi yang dibuka saat notifikasi diketuk. */
  route: string;
  schoolId: string;
  ticketId?: string;
  urgent?: boolean;
  /** false: hanya push, tidak disimpan di kotak notifikasi (mis. pesan curhat). */
  inbox?: boolean;
}

const INVALID_TOKEN_CODES = new Set([
  "messaging/registration-token-not-registered",
  "messaging/invalid-registration-token",
  "messaging/invalid-argument",
]);

/** Simpan notifikasi di kotak masuk pengguna lalu kirim push ke perangkat terdaftar. */
export async function notifyUsers(uids: Iterable<string>, input: NotificationInput): Promise<void> {
  const recipients = [...new Set(uids)].filter(Boolean);
  if (recipients.length === 0) return;

  if (input.inbox !== false) await writeInbox(recipients, input);

  try {
    await sendPush(recipients, input);
  } catch (error) {
    logger.warn("Push notifikasi gagal dikirim", error);
  }
}

async function writeInbox(recipients: string[], input: NotificationInput): Promise<void> {
  const batch = db().batch();
  const now = FieldValue.serverTimestamp();
  for (const uid of recipients) {
    batch.set(userRef(uid).collection("notifications").doc(), {
      type: input.type,
      title: input.title,
      body: input.body,
      route: input.route,
      schoolId: input.schoolId,
      ticketId: input.ticketId ?? null,
      urgent: input.urgent ?? false,
      read: false,
      createdAt: now,
    });
  }
  await batch.commit();
}

async function sendPush(uids: string[], input: NotificationInput): Promise<void> {
  const snapshots = await Promise.all(uids.map((uid) => userRef(uid).collection("devices").get()));
  const devices: QueryDocumentSnapshot[] = snapshots.flatMap((snapshot) => snapshot.docs);
  const tokens = devices.map((device) => device.get("token") as string);
  if (tokens.length === 0) return;

  const response = await messaging().sendEachForMulticast({
    tokens,
    notification: {title: input.title, body: input.body},
    data: {route: input.route, type: input.type, ticketId: input.ticketId ?? ""},
    android: {
      priority: input.urgent ? "high" : "normal",
      notification: {channelId: input.urgent ? "mandu_urgent" : "mandu_updates"},
    },
  });
  await Promise.all(response.responses.map((result, index) =>
    !result.success && INVALID_TOKEN_CODES.has(result.error?.code ?? "") ? devices[index].ref.delete() : null,
  ));
}

async function activeMembers(schoolId: string): Promise<(MemberDoc & {uid: string})[]> {
  const snapshot = await schoolRef(schoolId).collection("members").where("status", "==", "active").get();
  return snapshot.docs.map((doc) => doc.data() as MemberDoc & {uid: string});
}

/** Admin dan anggota Tim Verifikasi. */
export async function verifierUids(schoolId: string): Promise<string[]> {
  return (await activeMembers(schoolId)).filter((member) => member.role === "admin" || member.canVerify).map((member) => member.uid);
}

/** Petugas/konselor aktif di unit tertentu. */
export async function unitStaffUids(schoolId: string, unitId: string): Promise<string[]> {
  const snapshot = await schoolRef(schoolId).collection("members").where("units", "array-contains", unitId).get();
  return snapshot.docs
    .map((doc) => doc.data() as MemberDoc)
    .filter((member) => member.status === "active" && (member.role === "petugas" || member.role === "konselor"))
    .map((member) => member.uid);
}

export async function roleUids(schoolId: string, roles: readonly string[]): Promise<string[]> {
  return (await activeMembers(schoolId)).filter((member) => roles.includes(member.role)).map((member) => member.uid);
}

const deviceSchema = z.object({
  token: z.string().min(20).max(4096),
  platform: z.enum(["android", "ios", "web"]),
});

const deviceId = (token: string) => createHash("sha256").update(token).digest("hex").slice(0, 40);

/** Aplikasi mendaftarkan token FCM perangkat untuk pengguna yang sedang masuk. */
export async function registerDevice(caller: Caller, data: unknown): Promise<{ok: true}> {
  const {token, platform} = parsePayload(deviceSchema, data);
  await userRef(caller.uid).collection("devices").doc(deviceId(token)).set({
    token,
    platform,
    updatedAt: FieldValue.serverTimestamp(),
  });
  return {ok: true};
}

export async function unregisterDevice(caller: Caller, data: unknown): Promise<{ok: true}> {
  const {token} = parsePayload(deviceSchema.pick({token: true}), data);
  await userRef(caller.uid).collection("devices").doc(deviceId(token)).delete();
  return {ok: true};
}
