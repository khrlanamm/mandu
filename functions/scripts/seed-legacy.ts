/**
 * Membuat data tiruan aplikasi MANDU 4.0.0 (koleksi `reports`, `articles`, `admins`) di emulator,
 * supaya migrasi ke MANDU 2.0 bisa di-dry-run tanpa menyentuh produksi.
 *
 *   FIRESTORE_EMULATOR_HOST=127.0.0.1:8080 FIREBASE_AUTH_EMULATOR_HOST=127.0.0.1:9099 \
 *     GCLOUD_PROJECT=teman-ngadu npx tsx scripts/seed-legacy.ts
 *
 * Bentuk dokumen mengikuti aturan `validNewReport` pada rules aplikasi lama.
 */
import {Timestamp} from "firebase-admin/firestore";
import {auth, db} from "../src/core/firebase";

if (!process.env.FIRESTORE_EMULATOR_HOST || !process.env.FIREBASE_AUTH_EMULATOR_HOST) {
  throw new Error("Skrip ini hanya untuk Emulator Suite.");
}

const daysAgo = (days: number) => Timestamp.fromMillis(Date.now() - days * 86_400_000);

const LEGACY_USERS = [
  {email: "pelapor1.lama@gmail.com", name: "Rizky Ananda"},
  {email: "pelapor2.lama@gmail.com", name: "Nabila Putri"},
];

const REPORTS = [
  {
    peran: "korban",
    tanggalBullying: "2025-08-12",
    lokasi: "Kelas X-3",
    frekuensi: "Sering",
    deskripsi: "Saya sering diejek soal fisik oleh kakak kelas setiap jam istirahat. Sudah berlangsung sejak awal semester.",
    nomorWhatsapp: "081234567890",
    urlBukti: "https://firebasestorage.googleapis.com/v0/b/teman-ngadu.appspot.com/o/laporan_bukti%2Fbukti1.jpg?alt=media&token=abc",
    status: "terlapor",
    hari: 40,
  },
  {
    peran: "saksi",
    tanggalBullying: "2025-09-02",
    lokasi: "Lapangan belakang",
    frekuensi: "Beberapa kali",
    deskripsi: "Teman saya didorong dan barangnya dibuang saat jam olahraga.",
    nomorWhatsapp: "",
    urlBukti: "",
    status: "ditangani",
    hari: 25,
  },
  {
    peran: "korban",
    tanggalBullying: "2025-09-20",
    lokasi: "Grup WhatsApp kelas",
    frekuensi: "Sering",
    deskripsi: "Foto saya diedit dan disebarkan di grup kelas sampai saya malu masuk sekolah.",
    nomorWhatsapp: "089900112233",
    urlBukti: "https://firebasestorage.googleapis.com/v0/b/teman-ngadu.appspot.com/o/laporan_bukti%2Fbukti3.png?alt=media&token=def",
    status: "ditangani",
    hari: 10,
  },
];

const ARTICLES = [
  {
    judul: "Apa itu bullying?",
    isi: "Bullying adalah perilaku agresif yang dilakukan berulang dengan maksud menyakiti orang lain, baik secara fisik, verbal, maupun sosial. Kenali bentuknya agar bisa mencegah.",
    imageUrl: "https://firebasestorage.googleapis.com/v0/b/teman-ngadu.appspot.com/o/FCMImages%2Fbullying.jpg?alt=media&token=ghi",
  },
  {
    judul: "Tips menghadapi perundungan di sekolah",
    isi: "Jangan membalas dengan kekerasan. Simpan bukti, ceritakan kepada guru BK atau orang tua, dan cari teman yang mendukungmu.",
  },
  {judul: "Kenali layanan bantuan", isi: "", link: "https://www.kemenpppa.go.id/"},
];

async function main(): Promise<void> {
  const uids: string[] = [];
  for (const user of LEGACY_USERS) {
    const record = await auth().getUserByEmail(user.email).catch(() =>
      auth().createUser({email: user.email, password: "lama123456", displayName: user.name, emailVerified: true}));
    uids.push(record.uid);
  }

  const batch = db().batch();
  REPORTS.forEach((report, index) => {
    const {hari, ...fields} = report;
    const ref = db().collection("reports").doc(`legacy-${index + 1}`);
    batch.set(ref, {...fields, id: index + 1, userId: uids[index % uids.length], timestamp: daysAgo(hari)});
  });
  ARTICLES.forEach((article, index) => {
    batch.set(db().collection("articles").doc(`legacy-artikel-${index + 1}`), {
      ...article,
      id: index + 1,
      timestamp: daysAgo(60 - index * 5),
    });
  });
  batch.set(db().collection("admins").doc(uids[0]), {fcmToken: "token-lama"});
  await batch.commit();

  console.log(`Data lama siap: ${REPORTS.length} laporan, ${ARTICLES.length} artikel, ${LEGACY_USERS.length} akun pelapor.`);
}

main().then(
  () => process.exit(0),
  (error) => {
    console.error(error instanceof Error ? error.message : error);
    process.exit(1);
  },
);
