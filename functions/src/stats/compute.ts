import {Timestamp} from "firebase-admin/firestore";
import {z} from "zod";
import type {Caller} from "../core/claims";
import {AppError} from "../core/errors";
import {db} from "../core/firebase";
import {schoolRef} from "../core/refs";
import {parsePayload} from "../core/validation";
import {ASPIRATION_STATUSES, type AspirationDoc} from "../domain/aspirations";
import type {ConversationDoc, HelpRequestDoc} from "../domain/care";
import {REPORT_CATEGORIES} from "../domain/catalog";
import type {MemberDoc, SchoolDoc, UnitDoc} from "../domain/models";
import {TICKET_STATUSES, type TicketDoc} from "../domain/tickets";
import {isVerifier} from "../tickets/access";

const HOUR = 3_600_000;

export interface UnitPerformance {
  unitId: string;
  unitName: string;
  total: number;
  selesai: number;
  avgResolveHours: number | null;
  onTimePercent: number | null;
}

export interface SchoolStats {
  months: number;
  from: string;
  tickets: {
    total: number;
    byStatus: Record<string, number>;
    byCategory: Record<string, number>;
    byPriority: Record<string, number>;
    overdue: number;
    avgVerifyHours: number | null;
    avgResolveHours: number | null;
    avgRating: number | null;
    ratingCount: number;
    topLocations: {location: string; count: number}[];
    monthly: {month: string; total: number; selesai: number}[];
    units: UnitPerformance[];
  };
  aspirations: {total: number; byStatus: Record<string, number>; byTopic: Record<string, number>; published: number; supports: number};
  care: {helpTotal: number; helpByStatus: Record<string, number>; conversations: number; conversationsActive: number};
  members: {total: number; byRole: Record<string, number>};
  updatedAt: string;
}

const monthKey = (date: Date) => new Intl.DateTimeFormat("sv-SE", {timeZone: "Asia/Jakarta", year: "numeric", month: "2-digit"}).format(date).slice(0, 7);

const average = (values: number[]) => (values.length === 0 ? null : Math.round((values.reduce((sum, value) => sum + value, 0) / values.length) * 10) / 10);

const tally = (values: string[], keys?: readonly string[]): Record<string, number> => {
  const counts: Record<string, number> = {};
  for (const key of keys ?? []) counts[key] = 0;
  for (const value of values) counts[value] = (counts[value] ?? 0) + 1;
  return counts;
};

const millisOf = (value: unknown): number | null => (value instanceof Timestamp ? value.toMillis() : null);

/** Statistik sekolah untuk dashboard admin & pimpinan. */
export async function computeSchoolStats(schoolId: string, months: number): Promise<SchoolStats> {
  const now = new Date();
  const from = new Date(now.getFullYear(), now.getMonth() - (months - 1), 1);
  const since = Timestamp.fromDate(from);

  const [ticketSnapshot, aspirationSnapshot, helpSnapshot, conversationSnapshot, memberSnapshot, unitSnapshot] = await Promise.all([
    schoolRef(schoolId).collection("tickets").where("createdAt", ">=", since).get(),
    schoolRef(schoolId).collection("aspirations").where("createdAt", ">=", since).get(),
    schoolRef(schoolId).collection("helpRequests").where("createdAt", ">=", since).get(),
    schoolRef(schoolId).collection("conversations").where("createdAt", ">=", since).get(),
    schoolRef(schoolId).collection("members").where("status", "==", "active").get(),
    schoolRef(schoolId).collection("units").get(),
  ]);

  const tickets = ticketSnapshot.docs.map((doc) => doc.data() as TicketDoc);
  const nowMillis = Date.now();
  const verifyHours: number[] = [];
  const resolveHours: number[] = [];
  const ratings: number[] = [];
  const locations: Record<string, number> = {};
  const monthly = new Map<string, {month: string; total: number; selesai: number}>();
  for (let index = months - 1; index >= 0; index--) {
    const month = monthKey(new Date(now.getFullYear(), now.getMonth() - index, 15));
    monthly.set(month, {month, total: 0, selesai: 0});
  }

  const unitStats = new Map<string, UnitPerformance & {resolveHours: number[]; onTime: number; resolvedCount: number}>();
  for (const doc of unitSnapshot.docs) {
    const unit = doc.data() as UnitDoc;
    unitStats.set(doc.id, {
      unitId: doc.id,
      unitName: unit.name,
      total: 0,
      selesai: 0,
      avgResolveHours: null,
      onTimePercent: null,
      resolveHours: [],
      onTime: 0,
      resolvedCount: 0,
    });
  }

  for (const ticket of tickets) {
    const createdAt = millisOf(ticket.createdAt);
    const verifiedAt = millisOf(ticket.verifiedAt);
    const resolvedAt = millisOf(ticket.resolvedAt);
    if (createdAt && verifiedAt) verifyHours.push((verifiedAt - createdAt) / HOUR);
    if (createdAt && resolvedAt) resolveHours.push((resolvedAt - createdAt) / HOUR);
    if (ticket.rating) ratings.push(ticket.rating.score);
    const location = ticket.location.trim();
    if (location) locations[location] = (locations[location] ?? 0) + 1;

    if (createdAt) {
      const bucket = monthly.get(monthKey(new Date(createdAt)));
      if (bucket) {
        bucket.total += 1;
        if (ticket.status === "selesai") bucket.selesai += 1;
      }
    }

    const unit = ticket.unitId ? unitStats.get(ticket.unitId) : undefined;
    if (unit) {
      unit.total += 1;
      if (ticket.status === "selesai") {
        unit.selesai += 1;
        unit.resolvedCount += 1;
        if (createdAt && resolvedAt) unit.resolveHours.push((resolvedAt - createdAt) / HOUR);
        const due = ticket.sla?.resolveDueAt instanceof Timestamp ? ticket.sla.resolveDueAt.toMillis() : null;
        if (due && resolvedAt && resolvedAt <= due) unit.onTime += 1;
      }
    }
  }

  const overdue = tickets.filter((ticket) => {
    if (ticket.status === "selesai" || ticket.status === "ditolak" || ticket.status === "dibatalkan") return false;
    const due = ticket.status === "menunggu_verifikasi" ? ticket.sla?.verifyDueAt : ticket.sla?.resolveDueAt;
    return due instanceof Timestamp && due.toMillis() < nowMillis;
  }).length;

  const aspirations = aspirationSnapshot.docs.map((doc) => doc.data() as AspirationDoc);
  const helpRequests = helpSnapshot.docs.map((doc) => doc.data() as HelpRequestDoc);
  const conversations = conversationSnapshot.docs.map((doc) => doc.data() as ConversationDoc);
  const members = memberSnapshot.docs.map((doc) => doc.data() as MemberDoc);

  return {
    months,
    from: from.toISOString().slice(0, 10),
    tickets: {
      total: tickets.length,
      byStatus: tally(tickets.map((ticket) => ticket.status), TICKET_STATUSES),
      byCategory: tally(tickets.map((ticket) => ticket.category), REPORT_CATEGORIES.map((category) => category.key)),
      byPriority: tally(tickets.map((ticket) => ticket.priority), ["normal", "tinggi", "darurat"]),
      overdue,
      avgVerifyHours: average(verifyHours),
      avgResolveHours: average(resolveHours),
      avgRating: average(ratings),
      ratingCount: ratings.length,
      topLocations: Object.entries(locations)
        .map(([location, count]) => ({location, count}))
        .sort((a, b) => b.count - a.count)
        .slice(0, 5),
      monthly: [...monthly.values()],
      units: [...unitStats.values()]
        .map(({resolveHours: hours, onTime, resolvedCount, ...unit}) => ({
          ...unit,
          avgResolveHours: average(hours),
          onTimePercent: resolvedCount === 0 ? null : Math.round((onTime / resolvedCount) * 100),
        }))
        .sort((a, b) => b.total - a.total),
    },
    aspirations: {
      total: aspirations.length,
      byStatus: tally(aspirations.map((aspiration) => aspiration.status), ASPIRATION_STATUSES),
      byTopic: tally(aspirations.map((aspiration) => aspiration.topic)),
      published: aspirations.filter((aspiration) => aspiration.board === "published").length,
      supports: aspirations.reduce((sum, aspiration) => sum + (aspiration.supportCount ?? 0), 0),
    },
    care: {
      helpTotal: helpRequests.length,
      helpByStatus: tally(helpRequests.map((request) => request.status), ["menunggu", "ditangani", "selesai", "dibatalkan"]),
      conversations: conversations.length,
      conversationsActive: conversations.filter((conversation) => conversation.status !== "selesai").length,
    },
    members: {
      total: members.length,
      byRole: tally(members.map((member) => member.role), ["admin", "pimpinan", "konselor", "petugas", "siswa"]),
    },
    updatedAt: new Date().toISOString(),
  };
}

const schoolStatsSchema = z.object({schoolId: z.string().min(1), months: z.number().int().min(1).max(12).default(6)});

/** Dashboard sekolah: admin, pimpinan, dan Tim Verifikasi. */
export async function schoolStats(caller: Caller, data: unknown): Promise<SchoolStats> {
  const {schoolId, months} = parsePayload(schoolStatsSchema, data);
  const allowed = caller.claims.sa ||
    (caller.claims.sid === schoolId && (caller.claims.role === "admin" || caller.claims.role === "pimpinan")) ||
    isVerifier(caller, schoolId);
  if (!allowed) throw new AppError("permission-denied", "Hanya admin, pimpinan, atau Tim Verifikasi yang dapat melihat dashboard.");
  return computeSchoolStats(schoolId, months);
}

export interface PlatformStats {
  schools: {schoolId: string; name: string; city: string; active: boolean; members: number; tickets: number; aspirations: number; open: number}[];
  totals: {schools: number; activeSchools: number; members: number; tickets: number; aspirations: number};
  updatedAt: string;
}

/** Dashboard superadmin: volume lintas sekolah tanpa isi laporan. */
export async function platformStats(caller: Caller): Promise<PlatformStats> {
  if (!caller.claims.sa) throw new AppError("permission-denied", "Hanya superadmin yang dapat melihat dashboard platform.");
  const schools = await db().collection("schools").get();

  const rows = await Promise.all(schools.docs.map(async (doc) => {
    const school = doc.data() as SchoolDoc;
    const tickets = doc.ref.collection("tickets");
    const [members, ticketCount, openCount, aspirationCount] = await Promise.all([
      doc.ref.collection("members").where("status", "==", "active").count().get(),
      tickets.count().get(),
      tickets.where("status", "in", ["menunggu_verifikasi", "perlu_dilengkapi", "diteruskan", "diproses"]).count().get(),
      doc.ref.collection("aspirations").count().get(),
    ]);
    return {
      schoolId: doc.id,
      name: school.name,
      city: school.city,
      active: school.active,
      members: members.data().count,
      tickets: ticketCount.data().count,
      open: openCount.data().count,
      aspirations: aspirationCount.data().count,
    };
  }));

  return {
    schools: rows.sort((a, b) => b.tickets - a.tickets),
    totals: {
      schools: rows.length,
      activeSchools: rows.filter((row) => row.active).length,
      members: rows.reduce((sum, row) => sum + row.members, 0),
      tickets: rows.reduce((sum, row) => sum + row.tickets, 0),
      aspirations: rows.reduce((sum, row) => sum + row.aspirations, 0),
    },
    updatedAt: new Date().toISOString(),
  };
}
