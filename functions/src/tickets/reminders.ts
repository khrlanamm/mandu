import {Timestamp} from "firebase-admin/firestore";
import * as logger from "firebase-functions/logger";
import {db} from "../core/firebase";
import {staffTicketRoute, type TicketDoc, type TimelineDoc} from "../domain/tickets";
import {notifyUsers, roleUids, unitStaffUids, verifierUids} from "../notifications/notify";

/**
 * Pengingat SLA: laporan yang melewati batas verifikasi atau tindak lanjut.
 * Setiap laporan hanya diingatkan sekali per tahap.
 */
export async function runSlaReminders(now: Timestamp = Timestamp.now()): Promise<{verify: number; resolve: number}> {
  const tickets = db().collectionGroup("tickets");
  const [verifyDue, resolveDue] = await Promise.all([
    tickets.where("status", "==", "menunggu_verifikasi").where("reminders.verify", "==", false).where("sla.verifyDueAt", "<=", now).limit(200).get(),
    tickets.where("status", "in", ["diteruskan", "diproses"]).where("reminders.resolve", "==", false).where("sla.resolveDueAt", "<=", now).limit(200).get(),
  ]);

  for (const doc of verifyDue.docs) {
    const ticket = doc.data() as TicketDoc;
    await doc.ref.update({"reminders.verify": true});
    await doc.ref.collection("timeline").add({
      type: "pengingat", visibility: "internal", message: "Batas waktu verifikasi terlewati.",
      actorRole: "sistem", actorName: null, attachments: [], createdAt: now,
    } satisfies TimelineDoc);
    await notifyUsers(await verifierUids(ticket.schoolId), {
      type: "sla_terlambat",
      title: `Segera verifikasi ${ticket.number}`,
      body: `Laporan "${ticket.title}" melewati batas waktu verifikasi.`,
      route: staffTicketRoute(doc.id),
      schoolId: ticket.schoolId,
      ticketId: doc.id,
      urgent: ticket.priority === "darurat",
    });
  }

  for (const doc of resolveDue.docs) {
    const ticket = doc.data() as TicketDoc;
    await doc.ref.update({"reminders.resolve": true});
    await doc.ref.collection("timeline").add({
      type: "pengingat", visibility: "internal", message: "Batas waktu tindak lanjut terlewati.",
      actorRole: "sistem", actorName: null, attachments: [], createdAt: now,
    } satisfies TimelineDoc);
    const recipients = new Set(await roleUids(ticket.schoolId, ["admin"]));
    if (ticket.unitId) (await unitStaffUids(ticket.schoolId, ticket.unitId)).forEach((uid) => recipients.add(uid));
    await notifyUsers(recipients, {
      type: "sla_terlambat",
      title: `Tindak lanjut ${ticket.number} terlambat`,
      body: `Laporan untuk ${ticket.unitName ?? "unit"} melewati batas waktu tindak lanjut.`,
      route: staffTicketRoute(doc.id),
      schoolId: ticket.schoolId,
      ticketId: doc.id,
    });
  }

  if (verifyDue.size + resolveDue.size > 0) {
    logger.info(`Pengingat SLA: ${verifyDue.size} verifikasi, ${resolveDue.size} tindak lanjut.`);
  }
  return {verify: verifyDue.size, resolve: resolveDue.size};
}
