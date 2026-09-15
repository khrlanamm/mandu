/**
 * Membuat sekolah dan akun uji coba MANDU 2.0 memakai logika Cloud Functions yang sama dengan aplikasi.
 *
 * Emulator (default, password semua akun: mandu123):
 *   firebase emulators:start --project teman-ngadu      # terminal lain, dari root repo
 *   npm run seed:emulator                                 # dari folder functions
 *
 * Produksi (hanya "Sekolah Uji Coba MANDU", tanpa superadmin demo):
 *   GOOGLE_APPLICATION_CREDENTIALS=~/.config/mandu/service-account.json GCLOUD_PROJECT=teman-ngadu \
 *     npx tsx scripts/seed.ts --production --password '<password-kuat-min-12>'
 */
import type {UserRecord} from "firebase-admin/auth";
import {FieldValue, Timestamp} from "firebase-admin/firestore";
import {syncClaims} from "../src/accounts/claims";
import {ensureUserDoc} from "../src/accounts/users";
import {claimConversation, startConversation} from "../src/care/conversations";
import {claimHelp, requestHelp} from "../src/care/help";
import {saveArticle} from "../src/education/articles";
import {reviewAspiration, supportAspiration} from "../src/aspirations/review";
import {submitAspiration, submitPublicAspiration} from "../src/aspirations/submit";
import {readClaims, type Caller} from "../src/core/claims";
import {auth, db} from "../src/core/firebase";
import {nisnEmail} from "../src/core/ids";
import {CONSENT_VERSION} from "../src/domain/catalog";
import {inviteStaff} from "../src/members/invite";
import {joinSchool} from "../src/members/join";
import {reviewMembers} from "../src/members/review";
import {importStudents} from "../src/members/students";
import {createSchool} from "../src/schools/manage";
import {submitTicket} from "../src/tickets/submit";
import {addTicketProgress, rateTicket, resolveTicket, verifyTicket} from "../src/tickets/workflow";

const args = process.argv.slice(2);
const production = args.includes("--production");
const passwordIndex = args.indexOf("--password");
const password = production ? args[passwordIndex + 1] : "mandu123";

function assertSafeTarget(): void {
  const emulatorHosts = [process.env.FIRESTORE_EMULATOR_HOST, process.env.FIREBASE_AUTH_EMULATOR_HOST];
  if (!production && emulatorHosts.some((host) => !host)) {
    throw new Error("Emulator tidak terdeteksi. Jalankan lewat `npm run seed:emulator`, atau pakai --production untuk produksi.");
  }
  if (production && emulatorHosts.some(Boolean)) {
    throw new Error("Mode produksi tidak boleh dijalankan dengan variabel lingkungan emulator.");
  }
  if (production && (passwordIndex < 0 || !password || password.length < 12)) {
    throw new Error("Mode produksi wajib memakai --password dengan minimal 12 karakter.");
  }
}

type Role = "admin" | "pimpinan" | "konselor" | "petugas";
type SummaryRow = {sekolah: string; peran: string; login: string};

const system = {uid: "seed-script", claims: {sa: true}};
const summary: SummaryRow[] = [];

const userStatus = async (uid: string) => (await db().collection("users").doc(uid).get()).get("status") as string | undefined;

async function ensureAccount(email: string, displayName: string, consent: boolean): Promise<UserRecord> {
  let record: UserRecord;
  try {
    const existing = await auth().getUserByEmail(email);
    record = await auth().updateUser(existing.uid, {password, displayName, emailVerified: true, disabled: false});
  } catch (error) {
    if ((error as {code?: string}).code !== "auth/user-not-found") throw error;
    record = await auth().createUser({email, password, displayName, emailVerified: true});
  }
  await ensureUserDoc(record);
  await db().collection("users").doc(record.uid).update(
    consent ?
      {consentVersion: CONSENT_VERSION, consentAt: FieldValue.serverTimestamp()} :
      {consentVersion: null, consentAt: null},
  );
  return record;
}

async function ensureSchool(input: {name: string; level: string; city: string; province: string; code: string}): Promise<string> {
  const code = await db().collection("schoolCodes").doc(input.code).get();
  if (code.exists) return code.get("schoolId") as string;
  return (await createSchool(system, input)).schoolId;
}

async function ensureStaff(
  school: {id: string; name: string},
  email: string,
  displayName: string,
  role: Role,
  units: string[] = [],
  canVerify = false,
): Promise<void> {
  const record = await ensureAccount(email, displayName, true);
  if ((await userStatus(record.uid)) !== "active") {
    await inviteStaff(system, {schoolId: school.id, email, displayName, role, units, canVerify});
  }
  summary.push({sekolah: school.name, peran: `${role}${units.length ? ` (${units.join(", ")})` : ""}`, login: email});
}

async function ensureStudent(
  school: {id: string; name: string; code: string},
  email: string,
  displayName: string,
  kelas: string,
  options: {nisn?: string; approve: boolean; consent: boolean},
): Promise<void> {
  const record = await ensureAccount(email, displayName, options.consent);
  const status = await userStatus(record.uid);
  if (status !== "active" && status !== "pending") {
    await joinSchool({uid: record.uid, claims: {}}, {code: school.code, displayName, kelas, nisn: options.nisn});
  }
  if (options.approve && (await userStatus(record.uid)) === "pending") {
    await reviewMembers(system, {schoolId: school.id, uids: [record.uid], approve: true});
  }
  summary.push({sekolah: school.name, peran: options.approve ? "siswa aktif" : "calon siswa (menunggu persetujuan)", login: email});
}

async function ensureNisnStudent(school: {id: string; name: string; code: string}, nisn: string, name: string, kelas: string): Promise<void> {
  const email = nisnEmail(school.id, nisn);
  let uid: string;
  try {
    uid = (await auth().getUserByEmail(email)).uid;
  } catch {
    const result = await importStudents(system, {schoolId: school.id, students: [{nisn, name, kelas}]});
    if (result.results[0].status !== "created") throw new Error(`Impor NISN ${nisn} gagal: ${result.results[0].message}`);
    uid = (await auth().getUserByEmail(email)).uid;
  }
  await auth().updateUser(uid, {password, disabled: false});
  await db().collection("users").doc(uid).update({mustChangePassword: true, consentVersion: null, consentAt: null});
  summary.push({sekolah: school.name, peran: "siswa akun NISN (wajib ganti password)", login: `kode ${school.code} · NISN ${nisn}`});
}

async function callerFor(email: string): Promise<Caller> {
  const record = await auth().getUserByEmail(email);
  return {uid: record.uid, claims: readClaims(record.customClaims ?? {})};
}

let ticketSequence = 0;
const seedTicketId = () => `seed${Date.now().toString(36)}${ticketSequence++}`.padEnd(20, "0");
const daysAgo = (days: number) => new Date(Date.now() - days * 86_400_000).toISOString().slice(0, 10);

/** Contoh laporan di setiap status, dibuat lewat alur yang sama dengan aplikasi. Dilewati bila sekolah sudah punya laporan. */
async function ensureSampleTickets(schoolId: string, domain: string): Promise<number> {
  const existing = await db().collection("schools").doc(schoolId).collection("tickets").limit(1).get();
  if (!existing.empty) return 0;

  const [admin, bk, sarpras, kurikulum, siswa, siswa2] = await Promise.all(
    ["admin", "bk", "sarpras", "kurikulum", "siswa", "siswa2"].map((name) => callerFor(`${name}@${domain}`)),
  );
  const report = (caller: Caller, input: Record<string, unknown>) =>
    submitTicket(caller, {schoolId, ticketId: seedTicketId(), anonymous: false, attachments: [], ...input});

  const chairs = await report(siswa, {
    category: "fasilitas",
    subcategory: "perabot",
    title: "Tiga kursi kelas XI IPA 1 patah",
    description: "Kaki kursi di barisan belakang patah dan kemarin ada teman yang hampir jatuh.",
    location: "Kelas XI IPA 1",
    incidentDate: daysAgo(4),
  });
  await verifyTicket(admin, {schoolId, ticketId: chairs.ticketId, decision: "forward", message: "Terima kasih, segera kami tangani."});
  await addTicketProgress(sarpras, {schoolId, ticketId: chairs.ticketId, message: "Kursi pengganti sudah diambil dari gudang."});
  await resolveTicket(sarpras, {
    schoolId,
    ticketId: chairs.ticketId,
    note: "Tiga kursi sudah diganti dengan yang baru dan kursi lain di kelas sudah dicek satu per satu.",
  });
  await rateTicket(siswa, {schoolId, ticketId: chairs.ticketId, score: 5, comment: "Cepat ditangani, terima kasih!"});

  const bullying = await report(siswa2, {
    category: "keamanan",
    subcategory: "perundungan_siber",
    anonymous: true,
    title: "Diejek terus di grup WhatsApp kelas",
    description: "Sudah dua minggu beberapa teman mengirim stiker dan foto editan untuk mengejek saya di grup kelas.",
    location: "Grup WhatsApp kelas X-2",
    incidentDate: daysAgo(2),
    details: {role: "korban", frequency: "Terus berulang"},
  });
  await verifyTicket(bk, {schoolId, ticketId: bullying.ticketId, decision: "forward"});
  await addTicketProgress(bk, {
    schoolId,
    ticketId: bullying.ticketId,
    message: "Guru BK sudah berkoordinasi dengan wali kelas X-2 dan menjadwalkan pertemuan dengan pihak terkait.",
  });
  await addTicketProgress(bk, {
    schoolId,
    ticketId: bullying.ticketId,
    visibility: "internal",
    message: "Tiga siswa terlibat sudah teridentifikasi dari tangkapan layar. Pemanggilan orang tua hari Kamis.",
  });

  const toilet = await report(siswa, {
    category: "kebersihan",
    subcategory: "toilet",
    title: "Toilet putra lantai 2 tidak ada air",
    description: "Sejak Senin keran di toilet putra lantai 2 tidak mengalir, toilet jadi bau dan tidak bisa dipakai.",
    location: "Toilet putra lantai 2",
  });
  await db().collection("schools").doc(schoolId).collection("tickets").doc(toilet.ticketId).update({
    "sla.verifyDueAt": Timestamp.fromMillis(Date.now() - 3 * 3_600_000),
  });

  const emptyClass = await report(siswa2, {
    category: "pembelajaran",
    subcategory: "jam_kosong",
    title: "Jam pelajaran Matematika sering kosong",
    description: "Beberapa minggu terakhir pelajaran Matematika sering kosong tanpa tugas pengganti.",
    location: "Kelas X-2",
  });
  await verifyTicket(kurikulum, {
    schoolId,
    ticketId: emptyClass.ticketId,
    decision: "request_info",
    message: "Mohon sebutkan hari atau tanggal jam kosong terjadi agar bisa kami cocokkan dengan jadwal guru.",
  });

  const canteen = await report(siswa, {
    category: "kebersihan",
    subcategory: "kantin",
    title: "Harga jajanan kantin naik",
    description: "Harga gorengan di kantin naik dari seribu menjadi dua ribu rupiah sejak minggu lalu.",
    location: "Kantin sekolah",
  });
  await verifyTicket(admin, {
    schoolId,
    ticketId: canteen.ticketId,
    decision: "reject",
    reason: "bukan_wewenang",
    message: "Harga ditentukan pengelola kantin. Silakan sampaikan lewat Aspirasi agar dibahas bersama OSIS.",
  });

  await report(siswa2, {
    category: "keamanan",
    subcategory: "ancaman_keamanan",
    anonymous: true,
    title: "Kakak kelas membawa pisau lipat",
    description: "Saya melihat kakak kelas membawa pisau lipat di tas dan mengancam akan memakainya sepulang sekolah.",
    location: "Parkiran motor belakang",
  });
  return 6;
}

/** Contoh aspirasi: di papan dengan tanggapan dan dukungan, sedang ditinjau, dan dari tamu. */
async function ensureSampleAspirations(schoolId: string, code: string, domain: string): Promise<number> {
  const existing = await db().collection("schools").doc(schoolId).collection("aspirations").limit(1).get();
  if (!existing.empty) return 0;

  const [admin, siswa, siswa2] = await Promise.all(["admin", "siswa", "siswa2"].map((name) => callerFor(`${name}@${domain}`)));

  const parking = await submitAspiration(siswa, {
    schoolId,
    anonymous: false,
    type: "usulan",
    topic: "fasilitas",
    title: "Tambah tempat parkir sepeda",
    content: "Banyak siswa bersepeda tetapi tempat parkirnya sempit, sepeda sering ditumpuk sampai rusak. Usul area belakang kantin dipakai untuk parkir sepeda.",
  });
  await reviewAspiration(admin, {
    schoolId,
    aspirationId: parking.aspirationId,
    status: "ditindaklanjuti",
    board: "published",
    response: "Terima kasih. Area belakang kantin sudah diukur dan akan dipasang rak sepeda bulan depan.",
  });
  await supportAspiration(siswa2, {schoolId, aspirationId: parking.aspirationId, support: true});
  await supportAspiration(siswa, {schoolId, aspirationId: parking.aspirationId, support: true});

  const club = await submitAspiration(siswa2, {
    schoolId,
    anonymous: true,
    type: "ide",
    topic: "kegiatan",
    title: "Ekstrakurikuler podcast sekolah",
    content: "Bagaimana kalau ada ekskul podcast untuk berbagi cerita inspiratif alumni dan kabar kegiatan sekolah?",
  });
  await reviewAspiration(admin, {schoolId, aspirationId: club.aspirationId, status: "ditinjau"});

  await submitPublicAspiration(null, {
    code,
    type: "kritik",
    topic: "layanan",
    title: "Antrean legalisir di TU terlalu lama",
    content: "Sebagai alumni, saya harus menunggu tiga hari untuk legalisir ijazah. Mohon ada jadwal layanan yang jelas.",
  }, "seed-script");
  return 3;
}

/** Contoh Butuh Bantuan dan Curhat untuk demo dan manual penggunaan. */
async function ensureSampleCare(schoolId: string, domain: string): Promise<number> {
  const existing = await db().collection("schools").doc(schoolId).collection("helpRequests").limit(1).get();
  if (!existing.empty) return 0;

  const [bk, siswa, siswa2] = await Promise.all(["bk", "siswa", "siswa2"].map((name) => callerFor(`${name}@${domain}`)));

  // Permintaan yang sudah diambil konselor dan berlanjut ke percakapan.
  const handled = await requestHelp(siswa2, {
    schoolId,
    needs: ["ingin_bicara", "perasaan"],
    urgency: "segera",
    contactMethod: "chat",
    contactTime: "istirahat",
    note: "Akhir-akhir ini sulit tidur dan tidak fokus belajar.",
  });
  await claimHelp(bk, {schoolId, requestId: handled.requestId});

  // Permintaan baru yang masih menunggu konselor.
  await requestHelp(siswa, {
    schoolId,
    needs: ["teman", "belum_siap"],
    urgency: "biasa",
    contactMethod: "bertemu",
    contactTime: "pulang_sekolah",
  });

  // Curhat dengan nama samaran yang sudah diambil konselor.
  const alias = await startConversation(siswa, {
    schoolId,
    counselorUid: null,
    alias: "Langit",
    topic: "Pertemanan",
    message: "Bu, saya sering merasa dijauhi teman sekelas. Saya tidak tahu harus bagaimana.",
  });
  await claimConversation(bk, {schoolId, conversationId: alias.conversationId});
  return 3;
}

/** Contoh konten Edukasi: artikel global MANDU dan artikel sekolah. */
async function ensureSampleArticles(schoolId: string, domain: string): Promise<number> {
  const existing = await db().collection("articles").limit(1).get();
  if (!existing.empty) return 0;

  await saveArticle(system, {
    title: "Mengenali tanda perundungan pada diri dan teman",
    category: "anti_bullying",
    type: "artikel",
    summary: "Perundungan tidak selalu terlihat. Kenali tandanya dan tahu apa yang bisa kamu lakukan.",
    body: [
      "Perundungan bukan sekadar bercanda. Ia berulang, menyakitkan, dan membuat korban merasa tidak berdaya.",
      "",
      "## Tanda yang perlu diperhatikan",
      "- Menghindari sekolah atau kegiatan tertentu",
      "- Barang sering hilang atau rusak",
      "- Menjadi pendiam, mudah marah, atau sulit tidur",
      "",
      "## Yang bisa kamu lakukan",
      "1. Ceritakan kepada orang dewasa yang kamu percaya.",
      "2. Simpan bukti bila perundungan terjadi di grup atau media sosial.",
      "3. Kirim laporan lewat menu **Lapor** di MANDU. Identitasmu bisa dirahasiakan.",
    ].join("\n"),
    featured: true,
  });

  await saveArticle(system, {
    title: "Cara meminta bantuan saat merasa kewalahan",
    category: "cari_bantuan",
    type: "artikel",
    summary: "Meminta bantuan bukan tanda lemah. Ini langkah sederhana untuk memulainya.",
    body: [
      "Kalau kamu merasa cemas, sedih, atau kewalahan, kamu tidak perlu menghadapinya sendirian.",
      "",
      "1. Pakai menu **Butuh Bantuan** di MANDU; kamu tidak perlu menjelaskan panjang lebar.",
      "2. Pilih cara dihubungi yang paling nyaman: chat, bertemu, atau WhatsApp.",
      "3. Bila keadaan mendesak, hubungi 112 atau temui guru terdekat.",
    ].join("\n"),
  });

  await saveArticle(system, {
    title: "Beasiswa Indonesia Maju jenjang SMA/SMK",
    category: "beasiswa",
    type: "beasiswa",
    summary: "Beasiswa persiapan kuliah untuk siswa berprestasi jenjang SMA/SMK sederajat.",
    scholarship: {
      organizer: "Puslapdik Kemendikdasmen",
      level: "SMA/SMK sederajat",
      deadline: `${new Date().getFullYear()}-12-15`,
      url: "https://beasiswa.kemdikbud.go.id",
    },
  });

  const admin = await callerFor(`admin@${domain}`);
  await saveArticle(admin, {
    schoolId,
    title: "Jadwal layanan BK dan cara membuat janji",
    category: "layanan_bk",
    type: "artikel",
    summary: "Guru BK siap menemanimu. Ini jadwal layanan dan cara membuat janji temu.",
    body: [
      "Ruang BK buka setiap hari sekolah pukul 07.00-15.00 WIB.",
      "",
      "- Jam istirahat: layanan tanpa janji (datang langsung).",
      "- Di luar jam istirahat: buat janji lewat menu **Butuh Bantuan** di MANDU.",
      "- Ingin cerita dulu tanpa bertemu? Gunakan menu **Curhat**, boleh memakai nama samaran.",
    ].join("\n"),
  });
  return 4;
}

async function main(): Promise<void> {
  assertSafeTarget();

  if (!production) {
    const superadmin = await ensureAccount("superadmin@mandu.test", "Superadmin MANDU", true);
    await db().collection("users").doc(superadmin.uid).update({isSuperadmin: true});
    await syncClaims(superadmin.uid);
    summary.push({sekolah: "(semua sekolah)", peran: "superadmin", login: "superadmin@mandu.test"});
  }

  const domain = production ? "ujicoba.mandu.test" : "smandemo.sch.id";
  const code = production ? "UJICOBA" : "DEMO01";
  const name = production ? "Sekolah Uji Coba MANDU" : "SMA Negeri Demo MANDU";
  const school = {id: await ensureSchool({name, level: "SMA", city: "Lamongan", province: "Jawa Timur", code}), name, code};

  await ensureStaff(school, `admin@${domain}`, "Andi Wijaya", "admin", [], true);
  await ensureStaff(school, `kepsek@${domain}`, "Drs. Hartono", "pimpinan");
  await ensureStaff(school, `bk@${domain}`, "Sri Wahyuni, S.Pd.", "konselor", ["bk_ppks"], true);
  await ensureStaff(school, `sarpras@${domain}`, "Joko Susilo", "petugas", ["sarpras"]);
  await ensureStaff(school, `kurikulum@${domain}`, "Ratna Dewi, M.Pd.", "petugas", ["kurikulum"], true);
  await ensureStudent(school, `siswa@${domain}`, "Budi Santoso", "XI IPA 1", {nisn: "0051111111", approve: true, consent: true});
  await ensureStudent(school, `siswa2@${domain}`, "Siti Aminah", "X-2", {nisn: "0052222222", approve: true, consent: true});
  await ensureStudent(school, production ? `calon@${domain}` : "calon.siswa@mandu.test", "Rina Pratiwi", "X-1", {approve: false, consent: false});
  await ensureNisnStudent(school, "0059990001", "Dewi Lestari", "X-2");
  const sampleTickets = await ensureSampleTickets(school.id, domain);
  const sampleAspirations = await ensureSampleAspirations(school.id, code, domain);
  const sampleCare = await ensureSampleCare(school.id, domain);
  const sampleArticles = await ensureSampleArticles(school.id, domain);

  if (!production) {
    const secondName = "SMP Harapan Bangsa";
    const second = {id: await ensureSchool({name: secondName, level: "SMP", city: "Tuban", province: "Jawa Timur", code: "HARAPAN"}), name: secondName};
    await ensureStaff(second, "admin@smpharapan.sch.id", "Wulan Sari", "admin", [], true);
  }

  console.log(`\nData uji coba siap (${production ? "PRODUKSI" : "emulator"}). Password: ${production ? "(sesuai --password)" : password}`);
  console.table(summary);
  console.log(sampleArticles ? `${sampleArticles} contoh konten Edukasi dibuat.` : "Contoh Edukasi sudah ada, dilewati.");
  console.log(sampleCare ? `${sampleCare} contoh permintaan bantuan & curhat dibuat.` : "Contoh bantuan & curhat sudah ada, dilewati.");
  console.log(sampleAspirations ? `${sampleAspirations} contoh aspirasi dibuat.` : "Contoh aspirasi sudah ada, dilewati.");
  console.log(sampleTickets ? `${sampleTickets} contoh laporan dibuat di ${name}.` : `Contoh laporan di ${name} sudah ada, dilewati.`);
}

main().then(
  () => process.exit(0),
  (error) => {
    console.error(error instanceof Error ? error.message : error);
    process.exit(1);
  },
);
