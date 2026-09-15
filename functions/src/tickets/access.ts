import type {Caller} from "../core/claims";
import {AppError} from "../core/errors";
import {memberRef} from "../core/refs";
import type {MemberDoc} from "../domain/models";
import type {TicketDoc, TicketOwnerDoc} from "../domain/tickets";
import {ticketOwnerRef, ticketRef} from "./refs";

export const isVerifier = (caller: Caller, schoolId: string) =>
  caller.claims.sid === schoolId && (caller.claims.role === "admin" || caller.claims.canVerify === true);

const inUnit = (caller: Caller, ticket: Pick<TicketDoc, "unitId">) =>
  (caller.claims.role === "konselor" || caller.claims.role === "petugas") &&
  !!ticket.unitId &&
  (caller.claims.units ?? []).includes(ticket.unitId);

/** Staf yang boleh melihat laporan (sama dengan rules Firestore). */
export function staffCanView(caller: Caller, schoolId: string, ticket: Pick<TicketDoc, "unitId">): boolean {
  if (caller.claims.sid !== schoolId) return false;
  const role = caller.claims.role;
  return role === "admin" || role === "pimpinan" || caller.claims.canVerify === true || inUnit(caller, ticket);
}

/** Staf yang boleh menindaklanjuti (update progres, selesaikan). Pimpinan hanya membaca. */
export function staffCanHandle(caller: Caller, schoolId: string, ticket: Pick<TicketDoc, "unitId">): boolean {
  if (caller.claims.sid !== schoolId) return false;
  return caller.claims.role === "admin" || inUnit(caller, ticket);
}

export async function loadTicket(schoolId: string, ticketId: string): Promise<TicketDoc> {
  const ticket = (await ticketRef(schoolId, ticketId).get()).data() as TicketDoc | undefined;
  if (!ticket) throw new AppError("not-found", "Laporan tidak ditemukan.");
  return ticket;
}

/** Pemilik laporan. Error "not-found" agar keberadaan laporan orang lain tidak bocor. */
export async function requireTicketOwner(caller: Caller, schoolId: string, ticketId: string): Promise<void> {
  const owner = (await ticketOwnerRef(schoolId, ticketId).get()).data() as TicketOwnerDoc | undefined;
  if (!owner || owner.uid !== caller.uid || caller.claims.sid !== schoolId) {
    throw new AppError("not-found", "Laporan tidak ditemukan.");
  }
}

export async function staffName(caller: Caller, schoolId: string): Promise<string> {
  const member = (await memberRef(schoolId, caller.uid).get()).data() as MemberDoc | undefined;
  return member?.displayName ?? "Petugas sekolah";
}
