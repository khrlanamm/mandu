import {FieldValue} from "firebase-admin/firestore";
import {z} from "zod";
import type {Caller} from "../core/claims";
import {AppError} from "../core/errors";
import {requireSchoolAdminOrSuperadmin} from "../core/permissions";
import {db} from "../core/firebase";
import {newSchoolId, PUBLIC_EMAIL_DOMAINS, randomSchoolCode, SCHOOL_CODE_PATTERN} from "../core/ids";
import {schoolCodeRef, schoolRef, unitsRef} from "../core/refs";
import {parsePayload} from "../core/validation";
import {DEFAULT_SERVICES, DEFAULT_SLA_HOURS, DEFAULT_UNITS, SCHOOL_LEVELS} from "../domain/catalog";
import type {SchoolDoc, UnitDoc} from "../domain/models";

const domainSchema = z
  .string()
  .trim()
  .toLowerCase()
  .regex(/^(?!-)[a-z0-9-]+(\.[a-z0-9-]+)+$/, "Domain email tidak valid.")
  .refine((domain) => !PUBLIC_EMAIL_DOMAINS.has(domain), "Domain email umum (mis. gmail.com) tidak bisa dipakai.");

const codeSchema = z.string().trim().toUpperCase().regex(SCHOOL_CODE_PATTERN, "Kode sekolah 4–12 huruf/angka.");

const createSchema = z.object({
  name: z.string().trim().min(3).max(100),
  level: z.enum(SCHOOL_LEVELS),
  city: z.string().trim().min(2).max(60),
  province: z.string().trim().min(2).max(60),
  npsn: z.string().trim().regex(/^\d{8}$/, "NPSN terdiri dari 8 angka.").optional(),
  address: z.string().trim().max(200).optional(),
  code: codeSchema.optional(),
  allowedDomains: z.array(domainSchema).max(5).optional(),
});

/** Superadmin membuat sekolah baru beserta unit bawaan dan kode sekolah unik. */
export async function createSchool(caller: Caller, data: unknown): Promise<{schoolId: string; code: string}> {
  const input = parsePayload(createSchema, data);
  const schoolId = newSchoolId(input.name);

  for (let attempt = 0; attempt < 5; attempt++) {
    const code = input.code ?? randomSchoolCode();
    const created = await db().runTransaction(async (tx) => {
      if ((await tx.get(schoolCodeRef(code))).exists) return false;

      const now = FieldValue.serverTimestamp();
      const school: SchoolDoc = {
        name: input.name,
        code,
        npsn: input.npsn ?? null,
        level: input.level,
        address: input.address ?? null,
        city: input.city,
        province: input.province,
        logoUrl: null,
        allowedDomains: [...new Set(input.allowedDomains ?? [])],
        active: true,
        services: {...DEFAULT_SERVICES},
        publicAspiration: true,
        aspirationBoard: true,
        slaHours: {...DEFAULT_SLA_HOURS},
        createdBy: caller.uid,
        createdAt: now,
        updatedAt: now,
      };
      tx.create(schoolCodeRef(code), {schoolId, createdAt: now});
      tx.create(schoolRef(schoolId), school);
      for (const unit of DEFAULT_UNITS) {
        const unitDoc: UnitDoc = {
          name: unit.name,
          description: unit.description,
          categories: [...unit.categories],
          active: true,
          createdAt: now,
          updatedAt: now,
        };
        tx.create(unitsRef(schoolId).doc(unit.id), unitDoc);
      }
      return true;
    });

    if (created) return {schoolId, code};
    if (input.code) throw new AppError("already-exists", "Kode sekolah sudah dipakai sekolah lain.");
  }
  throw new AppError("aborted", "Gagal membuat kode sekolah unik. Coba lagi.");
}

const updateSchema = z.object({
  schoolId: z.string().min(1),
  name: z.string().trim().min(3).max(100).optional(),
  level: z.enum(SCHOOL_LEVELS).optional(),
  city: z.string().trim().min(2).max(60).optional(),
  province: z.string().trim().min(2).max(60).optional(),
  npsn: z.string().trim().regex(/^\d{8}$/).nullable().optional(),
  address: z.string().trim().max(200).nullable().optional(),
  logoUrl: z.url({protocol: /^https$/}).nullable().optional(),
  allowedDomains: z.array(domainSchema).max(5).optional(),
  services: z.object({
    lapor: z.boolean(),
    curhat: z.boolean(),
    aspirasi: z.boolean(),
    bantuan: z.boolean(),
    edukasi: z.boolean(),
  }).optional(),
  publicAspiration: z.boolean().optional(),
  aspirationBoard: z.boolean().optional(),
  slaHours: z.object({
    verifikasi: z.number().int().min(1).max(168),
    tindakLanjut: z.number().int().min(1).max(720),
    darurat: z.number().int().min(1).max(24),
  }).optional(),
  /** Hanya superadmin. */
  active: z.boolean().optional(),
});

/** Admin sekolah/superadmin mengubah profil dan pengaturan sekolah. */
export async function updateSchool(caller: Caller, data: unknown): Promise<{ok: true}> {
  const {schoolId, active, ...changes} = parsePayload(updateSchema, data);
  requireSchoolAdminOrSuperadmin(caller, schoolId);
  if (active !== undefined && !caller.claims.sa) {
    throw new AppError("permission-denied", "Hanya superadmin yang dapat menonaktifkan sekolah.");
  }

  const ref = schoolRef(schoolId);
  const snapshot = await ref.get();
  if (!snapshot.exists) throw new AppError("not-found", "Sekolah tidak ditemukan.");

  const updates: Record<string, unknown> = {updatedAt: FieldValue.serverTimestamp()};
  for (const [key, value] of Object.entries(changes)) {
    if (value !== undefined) updates[key] = key === "allowedDomains" ? [...new Set(value as string[])] : value;
  }
  if (active !== undefined) updates.active = active;
  await ref.update(updates);

  if (changes.name && changes.name !== snapshot.get("name")) {
    await propagateSchoolName(schoolId, changes.name);
  }
  return {ok: true};
}

/** Nama sekolah juga disalin di profil anggota agar layar "menunggu persetujuan" bisa menampilkannya. */
async function propagateSchoolName(schoolId: string, schoolName: string): Promise<void> {
  const users = await db().collection("users").where("schoolId", "==", schoolId).get();
  const writer = db().bulkWriter();
  users.docs.forEach((doc) => writer.update(doc.ref, {schoolName}));
  const invitations = await db().collection("invitations").where("schoolId", "==", schoolId).where("status", "==", "pending").get();
  invitations.docs.forEach((doc) => writer.update(doc.ref, {schoolName}));
  await writer.close();
}

const changeCodeSchema = z.object({schoolId: z.string().min(1), code: codeSchema.optional()});

/** Ganti kode sekolah (mis. bocor ke luar sekolah). Akun NISN tidak terpengaruh. */
export async function changeSchoolCode(caller: Caller, data: unknown): Promise<{code: string}> {
  const input = parsePayload(changeCodeSchema, data);
  requireSchoolAdminOrSuperadmin(caller, input.schoolId);

  for (let attempt = 0; attempt < 5; attempt++) {
    const code = input.code ?? randomSchoolCode();
    const changed = await db().runTransaction(async (tx) => {
      const ref = schoolRef(input.schoolId);
      const [school, taken] = await Promise.all([tx.get(ref), tx.get(schoolCodeRef(code))]);
      if (!school.exists) throw new AppError("not-found", "Sekolah tidak ditemukan.");
      if (taken.exists) return false;
      const now = FieldValue.serverTimestamp();
      tx.delete(schoolCodeRef(school.get("code")));
      tx.create(schoolCodeRef(code), {schoolId: input.schoolId, createdAt: now});
      tx.update(ref, {code, updatedAt: now});
      return true;
    });
    if (changed) return {code};
    if (input.code) throw new AppError("already-exists", "Kode sekolah sudah dipakai sekolah lain.");
  }
  throw new AppError("aborted", "Gagal membuat kode sekolah unik. Coba lagi.");
}
