import {FieldValue, Timestamp, type Transaction} from "firebase-admin/firestore";
import {z} from "zod";
import type {Caller} from "../core/claims";
import {AppError} from "../core/errors";
import {db} from "../core/firebase";
import {schoolRef, unitsRef} from "../core/refs";
import {parsePayload} from "../core/validation";
import {CATEGORY_KEYS, REPORT_CATEGORIES} from "../domain/catalog";
import type {SchoolDoc, UnitDoc} from "../domain/models";
import {
  MAX_ATTACHMENTS,
  MAX_TICKET_ATTACHMENTS,
  REJECT_REASON_LABELS,
  REJECT_REASONS,
  staffTicketRoute,
  studentTicketRoute,
  type TicketDoc,
  type TicketStatus,
  type TimelineDoc,
} from "../domain/tickets";
import {notifyUsers, unitStaffUids, verifierUids} from "../notifications/notify";
import {isVerifier, requireTicketOwner, staffCanHandle, staffName} from "./access";
import {attachmentPrefix, followUpPrefix, ticketOwnerRef, ticketRef} from "./refs";
import {assertAttachmentsUploaded, attachmentSchema} from "./submit";

const ids = {schoolId: z.string().min(1), ticketId: z.string().min(1)};

const addHours = (timestamp: Timestamp, hours: number) => Timestamp.fromMillis(timestamp.toMillis() + hours * 3_600_000);

function timelineEvent(event: Omit<TimelineDoc, "createdAt" | "attachments"> & Partial<Pick<TimelineDoc, "attachments">>): TimelineDoc {
  return {attachments: [], ...event, createdAt: Timestamp.now()};
}

/** Baca laporan dalam transaksi dan pastikan statusnya termasuk [allowed]. */
async function readTicket(tx: Transaction, schoolId: string, ticketId: string, allowed: readonly TicketStatus[]): Promise<TicketDoc> {
  const ticket = (await tx.get(ticketRef(schoolId, ticketId))).data() as TicketDoc | undefined;
  if (!ticket) throw new AppError("not-found", "Laporan tidak ditemukan.");
  if (!allowed.includes(ticket.status)) {
    throw new AppError("failed-precondition", "Status laporan sudah berubah. Muat ulang untuk melihat status terbaru.");
  }
  return ticket;
}

async function ownerUid(schoolId: string, ticketId: string): Promise<string | null> {
  return ((await ticketOwnerRef(schoolId, ticketId).get()).get("uid") as string | undefined) ?? null;
}

async function notifyOwner(schoolId: string, ticketId: string, title: string, body: string): Promise<void> {
  const uid = await ownerUid(schoolId, ticketId);
  if (uid) await notifyUsers([uid], {type: "tiket_diperbarui", title, body, route: studentTicketRoute(ticketId), schoolId, ticketId});
}

async function resolveUnit(schoolId: string, category: string, unitId?: string): Promise<{id: string; name: string}> {
  if (unitId) {
    const unit = (await unitsRef(schoolId).doc(unitId).get()).data() as UnitDoc | undefined;
    if (!unit?.active) throw new AppError("invalid-argument", "Unit tujuan tidak ditemukan atau nonaktif.");
    return {id: unitId, name: unit.name};
  }
  const units = await unitsRef(schoolId).where("categories", "array-contains", category).get();
  const match = units.docs.find((doc) => (doc.data() as UnitDoc).active) ??
    (await unitsRef(schoolId).doc("manajemen").get());
  if (!match.exists) throw new AppError("failed-precondition", "Belum ada unit yang menangani kategori ini. Atur unit di pengaturan sekolah.");
  return {id: match.id, name: (match.data() as UnitDoc).name};
}

const verifySchema = z.discriminatedUnion("decision", [
  z.object({
    ...ids,
    decision: z.literal("forward"),
    category: z.enum(CATEGORY_KEYS as [string, ...string[]]).optional(),
    subcategory: z.string().max(40).optional(),
    unitId: z.string().min(1).optional(),
    priority: z.enum(["normal", "tinggi", "darurat"]).optional(),
    message: z.string().trim().max(500).optional(),
  }),
  z.object({...ids, decision: z.literal("request_info"), message: z.string().trim().min(5, "Tuliskan data yang perlu dilengkapi.").max(500)}),
  z.object({...ids, decision: z.literal("reject"), reason: z.enum(REJECT_REASONS), message: z.string().trim().max(500).optional()}),
]);

/** Tim Verifikasi: teruskan ke unit, minta data tambahan, atau tolak. */
export async function verifyTicket(caller: Caller, data: unknown): Promise<{status: TicketStatus; unitName: string | null}> {
  const input = parsePayload(verifySchema, data);
  const {schoolId, ticketId} = input;
  if (!isVerifier(caller, schoolId)) throw new AppError("permission-denied", "Hanya Tim Verifikasi yang dapat memverifikasi laporan.");
  const actorName = await staffName(caller, schoolId);
  const actorRole = caller.claims.role!;

  if (input.decision === "forward") {
    const current = (await ticketRef(schoolId, ticketId).get()).data() as TicketDoc | undefined;
    if (!current) throw new AppError("not-found", "Laporan tidak ditemukan.");
    const categoryKey = input.category ?? current.category;
    const category = REPORT_CATEGORIES.find((entry) => entry.key === categoryKey)!;
    const subcategoryKey = input.subcategory ?? (categoryKey === current.category ? current.subcategory : "lainnya");
    const subcategory = category.subcategories.find((entry) => entry.key === subcategoryKey) ?? category.subcategories[category.subcategories.length - 1];
    const unit = await resolveUnit(schoolId, categoryKey, input.unitId);
    const school = (await schoolRef(schoolId).get()).data() as SchoolDoc;

    await db().runTransaction(async (tx) => {
      await readTicket(tx, schoolId, ticketId, ["menunggu_verifikasi", "perlu_dilengkapi"]);
      const now = Timestamp.now();
      tx.update(ticketRef(schoolId, ticketId), {
        status: "diteruskan",
        category: category.key,
        categoryLabel: category.label,
        subcategory: subcategory.key,
        subcategoryLabel: subcategory.label,
        ...(input.priority ? {priority: input.priority} : {}),
        unitId: unit.id,
        unitName: unit.name,
        infoRequest: null,
        verifiedAt: now,
        updatedAt: now,
        "sla.resolveDueAt": addHours(now, school.slaHours.tindakLanjut),
      });
      tx.create(ticketRef(schoolId, ticketId).collection("timeline").doc(), timelineEvent({
        type: "diteruskan",
        visibility: "public",
        message: [`Laporan diverifikasi dan diteruskan ke ${unit.name}.`, input.message].filter(Boolean).join(" "),
        actorRole,
        actorName,
      }));
    });

    await Promise.all([
      notifyOwner(schoolId, ticketId, `Laporan ${current.number} diverifikasi`, `Laporanmu sedang ditangani ${unit.name}.`),
      unitStaffUids(schoolId, unit.id).then((uids) => notifyUsers(uids, {
        type: "tiket_unit",
        title: `Laporan untuk ${unit.name} · ${current.number}`,
        body: `${category.label}: ${current.title}`,
        route: staffTicketRoute(ticketId),
        schoolId,
        ticketId,
        urgent: (input.priority ?? current.priority) === "darurat",
      })),
    ]);
    return {status: "diteruskan", unitName: unit.name};
  }

  if (input.decision === "request_info") {
    const ticket = await db().runTransaction(async (tx) => {
      const current = await readTicket(tx, schoolId, ticketId, ["menunggu_verifikasi"]);
      const now = Timestamp.now();
      tx.update(ticketRef(schoolId, ticketId), {
        status: "perlu_dilengkapi",
        infoRequest: {message: input.message, requestedAt: now},
        updatedAt: now,
      });
      tx.create(ticketRef(schoolId, ticketId).collection("timeline").doc(), timelineEvent({
        type: "diminta_melengkapi",
        visibility: "public",
        message: input.message,
        actorRole,
        actorName,
      }));
      return current;
    });
    await notifyOwner(schoolId, ticketId, `Lengkapi laporan ${ticket.number}`, input.message);
    return {status: "perlu_dilengkapi", unitName: null};
  }

  const ticket = await db().runTransaction(async (tx) => {
    const current = await readTicket(tx, schoolId, ticketId, ["menunggu_verifikasi", "perlu_dilengkapi"]);
    const now = Timestamp.now();
    tx.update(ticketRef(schoolId, ticketId), {
      status: "ditolak",
      rejection: {reason: input.reason, note: input.message || null},
      infoRequest: null,
      closedAt: now,
      updatedAt: now,
    });
    tx.create(ticketRef(schoolId, ticketId).collection("timeline").doc(), timelineEvent({
      type: "ditolak",
      visibility: "public",
      message: [`Laporan tidak dapat ditindaklanjuti: ${REJECT_REASON_LABELS[input.reason]}.`, input.message].filter(Boolean).join(" "),
      actorRole,
      actorName,
    }));
    return current;
  });
  await notifyOwner(schoolId, ticketId, `Laporan ${ticket.number} tidak dilanjutkan`, REJECT_REASON_LABELS[input.reason]);
  return {status: "ditolak", unitName: null};
}

const supplySchema = z.object({
  ...ids,
  message: z.string().trim().min(5, "Tuliskan data tambahan minimal 5 karakter.").max(2000),
  attachments: z.array(attachmentSchema).max(MAX_ATTACHMENTS).default([]),
});

/** Pelapor melengkapi data yang diminta verifikator. */
export async function supplyTicketInfo(caller: Caller, data: unknown): Promise<{status: TicketStatus}> {
  const input = parsePayload(supplySchema, data);
  const {schoolId, ticketId} = input;
  await requireTicketOwner(caller, schoolId, ticketId);
  await assertAttachmentsUploaded(input.attachments, attachmentPrefix(schoolId, ticketId));
  const school = (await schoolRef(schoolId).get()).data() as SchoolDoc;

  const ticket = await db().runTransaction(async (tx) => {
    const current = await readTicket(tx, schoolId, ticketId, ["perlu_dilengkapi"]);
    if (current.attachments.length + input.attachments.length > MAX_TICKET_ATTACHMENTS) {
      throw new AppError("invalid-argument", `Satu laporan maksimal ${MAX_TICKET_ATTACHMENTS} lampiran.`);
    }
    const now = Timestamp.now();
    tx.update(ticketRef(schoolId, ticketId), {
      status: "menunggu_verifikasi",
      infoRequest: null,
      attachments: [...current.attachments, ...input.attachments],
      updatedAt: now,
      "sla.verifyDueAt": addHours(now, school.slaHours.verifikasi),
      "reminders.verify": false,
    });
    tx.create(ticketRef(schoolId, ticketId).collection("timeline").doc(), timelineEvent({
      type: "dilengkapi",
      visibility: "public",
      message: input.message,
      actorRole: "pelapor",
      actorName: current.reporter?.name ?? null,
      attachments: input.attachments,
    }));
    return current;
  });

  await notifyUsers(await verifierUids(schoolId), {
    type: "tiket_dilengkapi",
    title: `Laporan ${ticket.number} sudah dilengkapi`,
    body: input.message.slice(0, 120),
    route: staffTicketRoute(ticketId),
    schoolId,
    ticketId,
  });
  return {status: "menunggu_verifikasi"};
}

/** Pelapor membatalkan laporan yang belum diteruskan ke unit. */
export async function cancelTicket(caller: Caller, data: unknown): Promise<{status: TicketStatus}> {
  const {schoolId, ticketId} = parsePayload(z.object(ids), data);
  await requireTicketOwner(caller, schoolId, ticketId);
  await db().runTransaction(async (tx) => {
    await readTicket(tx, schoolId, ticketId, ["menunggu_verifikasi", "perlu_dilengkapi"]);
    const now = Timestamp.now();
    tx.update(ticketRef(schoolId, ticketId), {status: "dibatalkan", infoRequest: null, closedAt: now, updatedAt: now});
    tx.create(ticketRef(schoolId, ticketId).collection("timeline").doc(), timelineEvent({
      type: "dibatalkan",
      visibility: "public",
      message: "Laporan dibatalkan oleh pelapor.",
      actorRole: "pelapor",
      actorName: null,
    }));
  });
  return {status: "dibatalkan"};
}

const progressSchema = z.object({
  ...ids,
  message: z.string().trim().min(3, "Tuliskan perkembangan penanganan.").max(2000),
  visibility: z.enum(["public", "internal"]).default("public"),
  attachments: z.array(attachmentSchema).max(MAX_ATTACHMENTS).default([]),
});

/** Unit penangan menambah progres (publik) atau catatan internal. */
export async function addTicketProgress(caller: Caller, data: unknown): Promise<{status: TicketStatus}> {
  const input = parsePayload(progressSchema, data);
  const {schoolId, ticketId} = input;
  await assertAttachmentsUploaded(input.attachments, followUpPrefix(schoolId, ticketId));
  const actorName = await staffName(caller, schoolId);

  const {ticket, status} = await db().runTransaction(async (tx) => {
    const internal = input.visibility === "internal";
    const current = await readTicket(
      tx, schoolId, ticketId,
      internal ? ["menunggu_verifikasi", "perlu_dilengkapi", "diteruskan", "diproses", "selesai"] : ["diteruskan", "diproses"],
    );
    const allowed = staffCanHandle(caller, schoolId, current) || (internal && isVerifier(caller, schoolId));
    if (!allowed) throw new AppError("permission-denied", "Kamu tidak menangani laporan ini.");

    const now = Timestamp.now();
    const nextStatus: TicketStatus = !internal && current.status === "diteruskan" ? "diproses" : current.status;
    tx.update(ticketRef(schoolId, ticketId), {status: nextStatus, updatedAt: now});
    tx.create(ticketRef(schoolId, ticketId).collection("timeline").doc(), timelineEvent({
      type: internal ? "catatan_internal" : "progres",
      visibility: input.visibility,
      message: input.message,
      actorRole: caller.claims.role!,
      actorName,
      attachments: input.attachments,
    }));
    return {ticket: current, status: nextStatus};
  });

  if (input.visibility === "public") {
    await notifyOwner(schoolId, ticketId, `Perkembangan laporan ${ticket.number}`, input.message.slice(0, 120));
  }
  return {status};
}

const resolveSchema = z.object({
  ...ids,
  note: z.string().trim().min(10, "Jelaskan tindak lanjut minimal 10 karakter.").max(2000),
  attachments: z.array(attachmentSchema).max(MAX_ATTACHMENTS).default([]),
});

/** Unit penangan menyelesaikan laporan dengan catatan dan dokumentasi. */
export async function resolveTicket(caller: Caller, data: unknown): Promise<{status: TicketStatus}> {
  const input = parsePayload(resolveSchema, data);
  const {schoolId, ticketId} = input;
  await assertAttachmentsUploaded(input.attachments, followUpPrefix(schoolId, ticketId));
  const actorName = await staffName(caller, schoolId);

  const ticket = await db().runTransaction(async (tx) => {
    const current = await readTicket(tx, schoolId, ticketId, ["diteruskan", "diproses"]);
    if (!staffCanHandle(caller, schoolId, current)) throw new AppError("permission-denied", "Kamu tidak menangani laporan ini.");
    const now = Timestamp.now();
    tx.update(ticketRef(schoolId, ticketId), {
      status: "selesai",
      resolution: {note: input.note, attachments: input.attachments, resolvedByName: actorName, resolvedAt: now},
      resolvedAt: now,
      updatedAt: now,
    });
    tx.create(ticketRef(schoolId, ticketId).collection("timeline").doc(), timelineEvent({
      type: "selesai",
      visibility: "public",
      message: input.note,
      actorRole: caller.claims.role!,
      actorName,
      attachments: input.attachments,
    }));
    return current;
  });

  await notifyOwner(schoolId, ticketId, `Laporan ${ticket.number} selesai`, "Lihat hasil tindak lanjut dan beri penilaian layanan.");
  return {status: "selesai"};
}

const reassignSchema = z.object({...ids, unitId: z.string().min(1), message: z.string().trim().max(500).optional()});

/** Tim Verifikasi mengalihkan laporan ke unit lain. */
export async function reassignTicket(caller: Caller, data: unknown): Promise<{unitName: string}> {
  const input = parsePayload(reassignSchema, data);
  const {schoolId, ticketId} = input;
  if (!isVerifier(caller, schoolId)) throw new AppError("permission-denied", "Hanya Tim Verifikasi yang dapat mengalihkan laporan.");
  const current = (await ticketRef(schoolId, ticketId).get()).data() as TicketDoc | undefined;
  if (!current) throw new AppError("not-found", "Laporan tidak ditemukan.");
  const unit = await resolveUnit(schoolId, current.category, input.unitId);
  const actorName = await staffName(caller, schoolId);

  await db().runTransaction(async (tx) => {
    const ticket = await readTicket(tx, schoolId, ticketId, ["diteruskan", "diproses"]);
    if (ticket.unitId === unit.id) throw new AppError("failed-precondition", "Laporan sudah berada di unit tersebut.");
    const now = Timestamp.now();
    tx.update(ticketRef(schoolId, ticketId), {unitId: unit.id, unitName: unit.name, status: "diteruskan", updatedAt: now});
    tx.create(ticketRef(schoolId, ticketId).collection("timeline").doc(), timelineEvent({
      type: "dialihkan",
      visibility: "public",
      message: [`Laporan dialihkan ke ${unit.name}.`, input.message].filter(Boolean).join(" "),
      actorRole: caller.claims.role!,
      actorName,
    }));
  });

  await notifyUsers(await unitStaffUids(schoolId, unit.id), {
    type: "tiket_unit",
    title: `Laporan dialihkan ke ${unit.name} · ${current.number}`,
    body: `${current.categoryLabel}: ${current.title}`,
    route: staffTicketRoute(ticketId),
    schoolId,
    ticketId,
  });
  return {unitName: unit.name};
}

const rateSchema = z.object({
  ...ids,
  score: z.number().int().min(1).max(5),
  comment: z.string().trim().max(500).optional(),
});

/** Pelapor menilai layanan setelah laporan selesai. */
export async function rateTicket(caller: Caller, data: unknown): Promise<{ok: true}> {
  const input = parsePayload(rateSchema, data);
  const {schoolId, ticketId} = input;
  await requireTicketOwner(caller, schoolId, ticketId);
  await db().runTransaction(async (tx) => {
    const ticket = await readTicket(tx, schoolId, ticketId, ["selesai"]);
    if (ticket.rating) throw new AppError("failed-precondition", "Laporan ini sudah dinilai.");
    const now = Timestamp.now();
    tx.update(ticketRef(schoolId, ticketId), {
      rating: {score: input.score, comment: input.comment || null, ratedAt: now},
      closedAt: now,
      updatedAt: FieldValue.serverTimestamp(),
    });
    tx.create(ticketRef(schoolId, ticketId).collection("timeline").doc(), timelineEvent({
      type: "dinilai",
      visibility: "public",
      message: `Pelapor memberi nilai ${input.score}/5.${input.comment ? ` "${input.comment}"` : ""}`,
      actorRole: "pelapor",
      actorName: null,
    }));
  });
  return {ok: true};
}
