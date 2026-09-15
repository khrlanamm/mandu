import {randomInt} from "node:crypto";

const CODE_ALPHABET = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
const LOWER_ALPHABET = "abcdefghjkmnpqrstuvwxyz23456789";

function randomString(alphabet: string, length: number): string {
  let result = "";
  for (let i = 0; i < length; i++) result += alphabet[randomInt(alphabet.length)];
  return result;
}

/** Kode sekolah: huruf besar & angka tanpa karakter yang mudah tertukar (0/O, 1/I). */
export const randomSchoolCode = (length = 6) => randomString(CODE_ALPHABET, length);

/** Password awal akun NISN: mudah dibacakan dan diketik siswa. */
export const randomPassword = (length = 10) => randomString(LOWER_ALPHABET, length);

export function slugify(input: string, maxLength = 36): string {
  return input
    .normalize("NFKD")
    .replace(/[̀-ͯ]/g, "")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .slice(0, maxLength)
    .replace(/-+$/g, "");
}

/** ID dokumen sekolah yang stabil dan aman dipakai di alamat email sintetis. */
export const newSchoolId = (name: string) => `${slugify(name) || "sekolah"}-${randomString(LOWER_ALPHABET, 4)}`;

export const SCHOOL_CODE_PATTERN = /^[A-Z0-9]{4,12}$/;
export const NISN_PATTERN = /^\d{4,20}$/;

/** Akun NISN memakai email sintetis yang tidak pernah dikirimi surat. */
export const NISN_EMAIL_DOMAIN = "nisn.teman-ngadu.web.app";
export const nisnEmail = (schoolId: string, nisn: string) => `${schoolId}.${nisn}@${NISN_EMAIL_DOMAIN}`;
export const isNisnEmail = (email?: string | null) => !!email && normalizeEmail(email).endsWith(`@${NISN_EMAIL_DOMAIN}`);

export const normalizeEmail = (email: string) => email.trim().toLowerCase();
export const emailDomain = (email: string) => normalizeEmail(email).split("@")[1] ?? "";

/** Domain email umum tidak boleh dipakai untuk persetujuan otomatis. */
export const PUBLIC_EMAIL_DOMAINS = new Set([
  "gmail.com", "googlemail.com", "yahoo.com", "yahoo.co.id", "outlook.com", "hotmail.com",
  "live.com", "icloud.com", "me.com", "proton.me", "protonmail.com", "ymail.com", "aol.com",
]);
