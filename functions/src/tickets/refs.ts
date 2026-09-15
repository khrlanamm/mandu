import {schoolRef} from "../core/refs";

export const ticketsRef = (schoolId: string) => schoolRef(schoolId).collection("tickets");
export const ticketRef = (schoolId: string, ticketId: string) => ticketsRef(schoolId).doc(ticketId);
export const ticketOwnerRef = (schoolId: string, ticketId: string) => schoolRef(schoolId).collection("ticketOwners").doc(ticketId);
export const ticketCounterRef = (schoolId: string) => schoolRef(schoolId).collection("counters").doc("tickets");

export const attachmentPrefix = (schoolId: string, ticketId: string) => `schools/${schoolId}/tickets/${ticketId}/lampiran/`;
export const followUpPrefix = (schoolId: string, ticketId: string) => `schools/${schoolId}/tickets/${ticketId}/tindak-lanjut/`;
