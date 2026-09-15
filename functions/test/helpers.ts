import {getApps, initializeApp} from "firebase-admin/app";
import {getAuth} from "firebase-admin/auth";
import {getFirestore} from "firebase-admin/firestore";
import {readClaims, type Caller, type ManduClaims} from "../src/core/claims";

const PROJECT_ID = "demo-mandu";
const firestoreHost = process.env.FIRESTORE_EMULATOR_HOST;
const authHost = process.env.FIREBASE_AUTH_EMULATOR_HOST;
if (!firestoreHost || !authHost) {
  throw new Error("Jalankan tes dengan Emulator Suite: npm run test:emulator");
}

if (getApps().length === 0) initializeApp({projectId: PROJECT_ID});

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
