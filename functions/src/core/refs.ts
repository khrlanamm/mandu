import {db} from "./firebase";

export const userRef = (uid: string) => db().collection("users").doc(uid);
export const schoolRef = (schoolId: string) => db().collection("schools").doc(schoolId);
export const memberRef = (schoolId: string, uid: string) => schoolRef(schoolId).collection("members").doc(uid);
export const unitsRef = (schoolId: string) => schoolRef(schoolId).collection("units");
export const schoolCodeRef = (code: string) => db().collection("schoolCodes").doc(code);
export const invitationsRef = () => db().collection("invitations");
export const platformConfigRef = () => db().collection("platform").doc("config");
