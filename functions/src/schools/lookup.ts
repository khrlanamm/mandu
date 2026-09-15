import {z} from "zod";
import {AppError} from "../core/errors";
import {SCHOOL_CODE_PATTERN} from "../core/ids";
import {schoolCodeRef, schoolRef} from "../core/refs";
import {parsePayload} from "../core/validation";
import type {SchoolCodeDoc, SchoolDoc, ServiceToggles} from "../domain/models";

export interface PublicSchool {
  schoolId: string;
  code: string;
  name: string;
  level: string;
  city: string;
  province: string;
  logoUrl: string | null;
  services: ServiceToggles;
  publicAspiration: boolean;
}

const schema = z.object({
  code: z.string().trim().toUpperCase().regex(SCHOOL_CODE_PATTERN, "Kode sekolah tidak valid."),
});

/** Informasi publik sekolah dari kodenya (untuk gabung, login NISN, dan aspirasi publik). */
export async function lookupSchool(data: unknown): Promise<PublicSchool> {
  const {code} = parsePayload(schema, data);
  const codeDoc = (await schoolCodeRef(code).get()).data() as SchoolCodeDoc | undefined;
  const school = codeDoc ? (await schoolRef(codeDoc.schoolId).get()).data() as SchoolDoc | undefined : undefined;
  if (!codeDoc || !school || !school.active) {
    throw new AppError("not-found", "Kode sekolah tidak ditemukan. Periksa kembali kode dari sekolahmu.");
  }
  return {
    schoolId: codeDoc.schoolId,
    code: school.code,
    name: school.name,
    level: school.level,
    city: school.city,
    province: school.province,
    logoUrl: school.logoUrl,
    services: school.services,
    publicAspiration: school.publicAspiration,
  };
}
