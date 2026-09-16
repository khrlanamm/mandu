/**
 * Menghapus data percobaan aplikasi MANDU 4.0.0 dari Firebase sebelum MANDU 2.0 dipakai produksi.
 *
 * Dry-run (default, tidak menghapus apa pun) — menampilkan jumlah yang akan dihapus:
 *   GOOGLE_APPLICATION_CREDENTIALS=~/.config/mandu/service-account.json GCLOUD_PROJECT=teman-ngadu \
 *     npx tsx scripts/cleanup-legacy.ts --production
 *
 * Menghapus sungguhan (setelah angka dry-run dilihat dan disetujui):
 *   ... npx tsx scripts/cleanup-legacy.ts --production --apply
 *
 * Opsi:
 *   --keep-articles         jangan hapus koleksi `articles` (mis. isinya masih ingin dipakai)
 *   --keep <email,email>    akun Auth yang tidak boleh dihapus (selain yang otomatis dikecualikan)
 *   --no-auth               jangan sentuh akun Auth sama sekali
 *   --no-storage            jangan hapus berkas Storage aplikasi lama
 *
 * Yang dihapus: koleksi `reports`, `admins`, `articles`, `users`, serta berkas Storage
 * `laporan_bukti/` dan `FCMImages/`. Koleksi MANDU 2.0 (`schools`, `schoolCodes`, `invitations`,
 * `platform`, `rateLimits`) tidak disentuh.
 */
import {auth, db, storage} from "../src/core/firebase";

const args = process.argv.slice(2);
const apply = args.includes("--apply");
const production = args.includes("--production");
const keepArticles = args.includes("--keep-articles");
const touchAuth = !args.includes("--no-auth");
const touchStorage = !args.includes("--no-storage");
const keepIndex = args.indexOf("--keep");
const keepEmails = new Set(
  (keepIndex >= 0 && args[keepIndex + 1] ? args[keepIndex + 1].split(",") : []).map((email) => email.trim().toLowerCase()),
);

const LEGACY_COLLECTIONS = ["reports", "admins", "users"];
const LEGACY_STORAGE_PREFIXES = ["laporan_bukti/", "FCMImages/"];

function assertSafeTarget(): void {
  const emulator = [process.env.FIRESTORE_EMULATOR_HOST, process.env.FIREBASE_AUTH_EMULATOR_HOST];
  if (production && emulator.some(Boolean)) throw new Error("Mode produksi tidak boleh memakai variabel emulator.");
  if (!production && emulator.some((host) => !host)) {
    throw new Error("Tanpa --production, skrip hanya boleh dijalankan terhadap Emulator Suite.");
  }
}

async function deleteCollection(name: string): Promise<number> {
  const snapshot = await db().collection(name).get();
  if (!apply || snapshot.empty) return snapshot.size;
  for (let index = 0; index < snapshot.docs.length; index += 400) {
    const batch = db().batch();
    for (const doc of snapshot.docs.slice(index, index + 400)) batch.delete(doc.ref);
    await batch.commit();
  }
  return snapshot.size;
}

async function deleteAuthUsers(): Promise<{dihapus: number; dipertahankan: number}> {
  let dihapus = 0;
  let dipertahankan = 0;
  let pageToken: string | undefined;
  do {
    const page = await auth().listUsers(1000, pageToken);
    const hapus = page.users.filter((user) => !keepEmails.has((user.email ?? "").toLowerCase()));
    dipertahankan += page.users.length - hapus.length;
    dihapus += hapus.length;
    if (apply && hapus.length > 0) {
      for (let index = 0; index < hapus.length; index += 900) {
        await auth().deleteUsers(hapus.slice(index, index + 900).map((user) => user.uid));
      }
    }
    pageToken = page.pageToken;
  } while (pageToken);
  return {dihapus, dipertahankan};
}

/** Bucket default project (Admin SDK tidak menebaknya bila app diinisialisasi tanpa storageBucket). */
const bucketName = process.env.STORAGE_BUCKET ?? "teman-ngadu.firebasestorage.app";

async function deleteStoragePrefix(prefix: string): Promise<number> {
  const bucket = storage().bucket(bucketName);
  const [files] = await bucket.getFiles({prefix});
  if (apply && files.length > 0) await bucket.deleteFiles({prefix});
  return files.length;
}

async function main(): Promise<void> {
  assertSafeTarget();
  console.log(`\nPembersihan data aplikasi 4.0.0 — ${apply ? "MENGHAPUS" : "DRY-RUN"} · target ${production ? "PRODUKSI" : "emulator"}`);
  const rows: {bagian: string; jumlah: number | string}[] = [];

  for (const name of [...LEGACY_COLLECTIONS, ...(keepArticles ? [] : ["articles"])]) {
    rows.push({bagian: `koleksi ${name}`, jumlah: await deleteCollection(name)});
  }
  if (keepArticles) rows.push({bagian: "koleksi articles", jumlah: "dipertahankan"});

  if (touchStorage) {
    for (const prefix of LEGACY_STORAGE_PREFIXES) {
      rows.push({bagian: `berkas Storage ${prefix}`, jumlah: await deleteStoragePrefix(prefix)});
    }
  } else {
    rows.push({bagian: "berkas Storage", jumlah: "dilewati"});
  }

  if (touchAuth) {
    const {dihapus, dipertahankan} = await deleteAuthUsers();
    rows.push({bagian: "akun Auth dihapus", jumlah: dihapus});
    rows.push({bagian: "akun Auth dipertahankan", jumlah: dipertahankan});
  } else {
    rows.push({bagian: "akun Auth", jumlah: "dilewati"});
  }

  console.table(rows);
  if (!apply) console.log("\nDry-run selesai. Tambahkan --apply untuk benar-benar menghapus.");
  else console.log("\nPembersihan selesai. Jalankan seed produksi untuk mengisi sekolah demo.");
}

main().then(
  () => process.exit(0),
  (error) => {
    console.error(error instanceof Error ? error.message : error);
    process.exit(1);
  },
);
