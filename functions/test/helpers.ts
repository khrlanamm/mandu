import {getApps, initializeApp} from "firebase-admin/app";
import {getAuth} from "firebase-admin/auth";
import {getFirestore, Timestamp} from "firebase-admin/firestore";
import {readClaims, type Caller, type ManduClaims, type SchoolRole} from "../src/core/claims";

const PROJECT_ID = "demo-mandu";
const firestoreHost = process.env.FIRESTORE_EMULATOR_HOST;
const authHost = process.env.FIREBASE_AUTH_EMULATOR_HOST;
if (!firestoreHost || !authHost) {
  throw new Error("Jalankan tes dengan Emulator Suite: npm run test:emulator");
}

if (getApps().length === 0) initializeApp({projectId: PROJECT_ID, storageBucket: `${PROJECT_ID}.appspot.com`});

export const db = getFirestore();
export const auth = getAuth();

/** Kosongkan Firestore & Auth emulator. */
export async function resetEmulators(): Promise<void> {
  await Promise.all([
    fetch(`http://${firestoreHost}/emulator/v1/projects/${PROJECT_ID}/databases/(default)/documents`, {method: "DELETE"}),
    fetch(`http://${authHost}/emulator/v1/projects/${PROJECT_ID}/accounts`, {method: "DELETE"}),
  ]);
}

export const asCaller = (uid: string, claims: ManduClaims = {}): Caller => ({uid, claims});

export const SUPERADMIN = asCaller("superadmin-1", {sa: true});

/** Caller dengan claims terbaru di Auth emulator, seperti ID token yang baru di-refresh. */
export async function freshCaller(uid: string): Promise<Caller> {
  const record = await auth.getUser(uid);
  return asCaller(uid, readClaims(record.customClaims ?? {}));
}

export function createUser(uid: string, email: string, options: {emailVerified?: boolean; displayName?: string} = {}) {
  return auth.createUser({
    uid,
    email,
    password: "rahasia-123",
    emailVerified: options.emailVerified ?? true,
    displayName: options.displayName ?? uid,
  });
}

/** Tambah anggota aktif langsung ke Firestore dan kembalikan Caller dengan claims yang sesuai. */
export async function addMember(
  schoolId: string,
  uid: string,
  data: {displayName: string; role: SchoolRole; units?: string[]; canVerify?: boolean; kelas?: string},
): Promise<Caller> {
  const now = Timestamp.now();
  await db.doc(`schools/${schoolId}/members/${uid}`).set({
    uid,
    displayName: data.displayName,
    email: `${uid}@contoh.sch.id`,
    role: data.role,
    units: data.units ?? [],
    canVerify: data.canVerify ?? false,
    status: "active",
    joinedVia: "invite",
    kelas: data.kelas ?? null,
    nisn: null,
    reviewedBy: null,
    reviewedAt: null,
    rejectionReason: null,
    createdAt: now,
    updatedAt: now,
  });
  return asCaller(uid, {
    sid: schoolId,
    role: data.role,
    units: data.units ?? [],
    canVerify: data.role === "admin" || (data.canVerify ?? false),
  });
}
