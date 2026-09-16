/**
 * Migrasi data aplikasi MANDU 4.0.0 (Kotlin) ke struktur MANDU 2.0.
 *
 * Dry-run di emulator (default, tidak menulis apa pun):
 *   FIRESTORE_EMULATOR_HOST=127.0.0.1:8080 FIREBASE_AUTH_EMULATOR_HOST=127.0.0.1:9099 \
 *     GCLOUD_PROJECT=teman-ngadu npx tsx scripts/migrate.ts --school-code SMANDI
 *
 * Menulis di emulator:
 *   ... npx tsx scripts/migrate.ts --school-code SMANDI --apply
 *
 * Produksi (hanya setelah dry-run cocok dan mendapat persetujuan):
 *   GOOGLE_APPLICATION_CREDENTIALS=~/.config/mandu/service-account.json GCLOUD_PROJECT=teman-ngadu \
 *     npx tsx scripts/migrate.ts --school-code SMANDI --apply --production
 *
 * Aman dijalankan berulang: dokumen yang sudah dimigrasi dilewati (ditandai `legacyId`).
 */
import type {UserRecord} from "firebase-admin/auth";
import {FieldValue, Timestamp} from "firebase-admin/firestore";
import {syncClaims} from "../src/accounts/claims";
import {ensureUserDoc} from "../src/accounts/users";
import {auth, db} from "../src/core/firebase";
import {schoolCodeRef, schoolRef} from "../src/core/refs";
import {REPORT_CATEGORIES} from "../src/domain/catalog";
import {
  articleTypeFromLegacy,
  legacyTicketNumber,
  roleFromLegacy,
  statusFromLegacy,
  storagePathFromUrl,
  titleFromDescription,
} from "../src/migration/legacy";
import type {MemberDoc} from "../src/domain/models";
import type {Attachment, TicketDoc, TimelineDoc} from "../src/domain/tickets";
import {createSchool} from "../src/schools/manage";

const args = process.argv.slice(2);
const apply = args.includes("--apply");
const production = args.includes("--production");
const flag = (name: string, fallback: string) => {
  const index = args.indexOf(`--${name}`);
  return index >= 0 && args[index + 1] ? args[index + 1] : fallback;
};

const SCHOOL = {
  name: flag("school-name", "SMA Negeri 1 Sukodadi"),
  code: flag("school-code", "SMANDI"),
  level: flag("school-level", "SMA"),
  city: flag("school-city", "Lamongan"),
  province: flag("school-province", "Jawa Timur"),
};
const SUPERADMIN_EMAILS = ["anam160404@gmail.com", "benevology@gmail.com"];
const SCHOOL_ADMIN_EMAILS = ["admin-sekolah-1@example.com", "admin-sekolah-2@example.com"];

const system = {uid: "migrate-script", claims: {sa: true as const}};
const summary: Record<string, number> = {};
const count = (key: string, by = 1) => {
  summary[key] = (summary[key] ?? 0) + by;
};
const notes: string[] = [];

function assertSafeTarget(): void {
  const emulator = [process.env.FIRESTORE_EMULATOR_HOST, process.env.FIREBASE_AUTH_EMULATOR_HOST];
  if (production && emulator.some(Boolean)) throw new Error("Mode produksi tidak boleh memakai variabel emulator.");
  if (!production && emulator.some((host) => !host)) {
    throw new Error("Tanpa --production, skrip hanya boleh dijalankan terhadap Emulator Suite.");
  }
}

const jakartaYear = (date: Date) => new Intl.DateTimeFormat("en", {timeZone: "Asia/Jakarta", year: "numeric"}).format(date);

async function ensureSchool(): Promise<string> {
  const existing = await schoolCodeRef(SCHOOL.code).get();
  if (existing.exists) return existing.get("schoolId") as string;
  if (!apply) {
    notes.push(`Sekolah "${SCHOOL.name}" (kode ${SCHOOL.code}) akan dibuat.`);
    return "(sekolah-baru)";
  }
  const {schoolId} = await createSchool(system, SCHOOL);
  count("sekolah dibuat");
  return schoolId;
}

async function userByEmail(email: string): Promise<UserRecord | null> {
  try {
    return await auth().getUserByEmail(email);
  } catch {
    return null;
  }
}

/** Anggota sekolah untuk akun lama; dipakai pelapor, admin, dan superadmin. */
async function ensureMember(
  schoolId: string,
  record: UserRecord,
  role: MemberDoc["role"],
  extra: {units?: string[]; canVerify?: boolean} = {},
): Promise<void> {
  if (!apply) {
    count(`anggota ${role} (dry-run)`);
    return;
  }
  const ref = schoolRef(schoolId).collection("members").doc(record.uid);
  if ((await ref.get()).exists) {
    count(`anggota ${role} sudah ada`);
    return;
  }
  const now = Timestamp.now();
  const member: MemberDoc & {uid: string} = {
    uid: record.uid,
    displayName: record.displayName || record.email?.split("@")[0] || "Pengguna MANDU",
    email: record.email ?? null,
    role,
    units: extra.units ?? [],
    canVerify: role === "admin" || (extra.canVerify ?? false),
    status: "active",
    joinedVia: "migration",
    kelas: null,
    nisn: null,
    reviewedBy: system.uid,
    reviewedAt: now,
    rejectionReason: null,
    createdAt: now,
    updatedAt: now,
  };
  await ref.set(member);
  await ensureUserDoc(record);
  await db().collection("users").doc(record.uid).set({schoolId, status: "active", role}, {merge: true});
  await syncClaims(record.uid);
  count(`anggota ${role} dibuat`);
}

/** 44 laporan lama → tiket kategori Keamanan & Perlindungan dengan identitas pelapor dirahasiakan. */
async function migrateReports(schoolId: string): Promise<void> {
  const snapshot = await db().collection("reports").orderBy("timestamp").get();
  count("laporan lama ditemukan", snapshot.size);
  const category = REPORT_CATEGORIES.find((entry) => entry.key === "keamanan")!;
  const subcategory = category.subcategories.find((entry) => entry.key === "perundungan")!;
  let sequence = 0;

  for (const doc of snapshot.docs) {
    const legacy = doc.data() as Record<string, unknown>;
    const ticketRef = schoolRef(schoolId).collection("tickets").doc(doc.id);
    // Dicek juga saat dry-run supaya ringkasan sebelum produksi menggambarkan keadaan sebenarnya.
    if ((await ticketRef.get()).exists) {
      count("tiket sudah dimigrasi");
      continue;
    }
    sequence += 1;

    const createdAt = legacy.timestamp instanceof Timestamp ? legacy.timestamp : Timestamp.now();
    const description = String(legacy.deskripsi ?? "").trim();
    const status = statusFromLegacy(legacy.status as string | undefined);
    const evidencePath = storagePathFromUrl(legacy.urlBukti as string | undefined);
    const attachments: Attachment[] = evidencePath
      ? [{path: evidencePath, name: evidencePath.split("/").pop() ?? "bukti", contentType: "image/jpeg", size: 0}]
      : [];
    const reporter = await userByEmail(String(legacy.userEmail ?? "")).catch(() => null);

    const ticket: TicketDoc & {legacyId: string} = {
      legacyId: doc.id,
      number: legacyTicketNumber(jakartaYear(createdAt.toDate()), sequence),
      schoolId,
      category: category.key,
      categoryLabel: category.label,
      subcategory: subcategory.key,
      subcategoryLabel: subcategory.label,
      title: titleFromDescription(description),
      description,
      location: String(legacy.lokasi ?? "Tidak disebutkan"),
      incidentDate: typeof legacy.tanggalBullying === "string" ? legacy.tanggalBullying : null,
      incidentTime: null,
      details: {
        role: roleFromLegacy(legacy.peran),
        frequency: (legacy.frekuensi as string | undefined) || null,
        involved: null,
      },
      attachments,
      anonymous: true,
      reporter: null,
      contactWhatsapp: (legacy.nomorWhatsapp as string | undefined) || null,
      priority: "tinggi",
      priorityReason: "Laporan perundungan dari aplikasi MANDU versi sebelumnya.",
      suggestedCategory: null,
      possibleDuplicateOf: null,
      status,
      unitId: status === "selesai" ? "bk_ppks" : null,
      unitName: status === "selesai" ? "BK / Tim PPKS" : null,
      infoRequest: null,
      resolution: status === "selesai"
        ? {
          note: "Laporan ini sudah ditangani pada aplikasi MANDU versi sebelumnya.",
          attachments: [],
          resolvedByName: "Tim BK (data lama)",
          resolvedAt: createdAt,
        }
        : null,
      rejection: null,
      rating: null,
      sla: {verifyDueAt: createdAt, resolveDueAt: status === "selesai" ? createdAt : null},
      reminders: {verify: true, resolve: true},
      createdAt,
      updatedAt: createdAt,
      verifiedAt: status === "selesai" ? createdAt : null,
      resolvedAt: status === "selesai" ? createdAt : null,
      closedAt: status === "selesai" ? createdAt : null,
    };

    const timeline: TimelineDoc = {
      type: "dibuat",
      visibility: "public",
      message: "Laporan dipindahkan dari aplikasi MANDU versi sebelumnya.",
      actorRole: "sistem",
      actorName: null,
      attachments: [],
      createdAt,
    };

    if (!apply) {
      count(`tiket akan dibuat (${status})`);
      continue;
    }
    const batch = db().batch();
    batch.set(ticketRef, ticket);
    batch.set(ticketRef.collection("timeline").doc(), timeline);
    if (legacy.userId) {
      batch.set(schoolRef(schoolId).collection("ticketOwners").doc(doc.id), {
        uid: legacy.userId,
        anonymous: true,
        createdAt,
      });
    }
    await batch.commit();
    count(`tiket dibuat (${status})`);

    // Pelapor lama menjadi anggota siswa aktif agar bisa memantau laporannya.
    if (typeof legacy.userId === "string") {
      const record = await auth().getUser(legacy.userId).catch(() => null);
      if (record) await ensureMember(schoolId, record, "siswa");
      else notes.push(`Akun pelapor ${legacy.userId} tidak ditemukan di Auth.`);
    }
    if (reporter) count("pelapor cocok lewat email");
  }
}

/** 50 artikel lama → Edukasi global; wajib menambahkan `published` agar terbaca aturan baru. */
async function migrateArticles(): Promise<void> {
  const snapshot = await db().collection("articles").get();
  count("artikel lama ditemukan", snapshot.size);

  for (const doc of snapshot.docs) {
    const legacy = doc.data() as Record<string, unknown>;
    if (legacy.published === true && legacy.scope === "global") {
      count("artikel sudah dimigrasi");
      continue;
    }
    const body = String(legacy.body ?? legacy.content ?? legacy.isi ?? legacy.deskripsi ?? "").trim();
    const title = String(legacy.title ?? legacy.judul ?? "Artikel MANDU").trim();
    const summaryText = String(legacy.summary ?? legacy.ringkasan ?? body.slice(0, 200)).trim();
    const cover = (legacy.imageUrl ?? legacy.coverUrl ?? legacy.gambar) as string | undefined;
    const link = (legacy.url ?? legacy.link) as string | undefined;
    const unknownFields = Object.keys(legacy).filter(
      (key) => !["id", "title", "judul", "body", "content", "isi", "deskripsi", "summary", "ringkasan", "imageUrl", "coverUrl", "gambar", "timestamp", "url", "link"].includes(key),
    );
    if (unknownFields.length > 0) notes.push(`Artikel ${doc.id} punya field lain: ${unknownFields.join(", ")}`);

    const article = {
      title,
      category: "anti_bullying",
      categoryLabel: "Anti-Perundungan",
      type: articleTypeFromLegacy(body, link),
      summary: summaryText || title,
      body: articleTypeFromLegacy(body, link) === "artikel" ? body : "",
      url: articleTypeFromLegacy(body, link) === "artikel" ? null : (link ?? null),
      coverUrl: cover ?? null,
      scholarship: null,
      featured: false,
      published: true,
      views: (legacy.views as number | undefined) ?? 0,
      scope: "global" as const,
      schoolId: null,
      authorName: "Tim MANDU",
      createdAt: legacy.timestamp instanceof Timestamp ? legacy.timestamp : FieldValue.serverTimestamp(),
      updatedAt: FieldValue.serverTimestamp(),
      publishedAt: legacy.timestamp instanceof Timestamp ? legacy.timestamp : FieldValue.serverTimestamp(),
      legacyId: doc.id,
    };
    if (!apply) {
      count(`artikel akan diperbarui (${article.type})`);
      continue;
    }
    await doc.ref.set(article, {merge: true});
    count(`artikel diperbarui (${article.type})`);
  }
}

async function migratePeople(schoolId: string): Promise<void> {
  for (const email of SUPERADMIN_EMAILS) {
    const record = await userByEmail(email);
    if (!record) {
      notes.push(`Superadmin ${email} belum punya akun; minta login sekali lalu jalankan ulang.`);
      continue;
    }
    if (!apply) {
      count("superadmin (dry-run)");
      continue;
    }
    await ensureUserDoc(record);
    await db().collection("users").doc(record.uid).set({isSuperadmin: true}, {merge: true});
    await syncClaims(record.uid);
    count("superadmin diset");
  }

  for (const email of SCHOOL_ADMIN_EMAILS) {
    const record = await userByEmail(email);
    if (!record) {
      notes.push(`Admin sekolah ${email} belum punya akun; minta login sekali lalu jalankan ulang.`);
      continue;
    }
    await ensureMember(schoolId, record, "admin");
  }
}

async function main(): Promise<void> {
  assertSafeTarget();
  console.log(`\nMigrasi MANDU 2.0 — ${apply ? "MENULIS" : "DRY-RUN"} · target ${production ? "PRODUKSI" : "emulator"}`);
  const schoolId = await ensureSchool();
  await migrateReports(schoolId);
  await migrateArticles();
  await migratePeople(schoolId);

  console.log(`\nSekolah: ${SCHOOL.name} (${SCHOOL.code}) · id ${schoolId}`);
  console.table(Object.entries(summary).map(([item, jumlah]) => ({item, jumlah})));
  if (notes.length > 0) {
    console.log("\nCatatan:");
    for (const note of notes) console.log(` - ${note}`);
  }
  if (!apply) console.log("\nDry-run selesai. Tambahkan --apply untuk benar-benar menulis.");
}

main().then(
  () => process.exit(0),
  (error) => {
    console.error(error instanceof Error ? error.message : error);
    process.exit(1);
  },
);
