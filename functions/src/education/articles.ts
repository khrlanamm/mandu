import {FieldValue, Timestamp} from "firebase-admin/firestore";
import {z} from "zod";
import type {Caller} from "../core/claims";
import {AppError} from "../core/errors";
import {db} from "../core/firebase";
import {memberRef, schoolRef} from "../core/refs";
import {parsePayload} from "../core/validation";
import {
  ARTICLE_CATEGORIES,
  ARTICLE_CATEGORY_KEYS,
  ARTICLE_TYPES,
  type ArticleDoc,
} from "../domain/education";
import type {MemberDoc} from "../domain/models";

export const articlesRef = (schoolId: string | null) =>
  schoolId ? schoolRef(schoolId).collection("articles") : db().collection("articles");

const httpsUrl = z.string().trim().url("Tautan harus berupa URL yang valid.").refine((value) => value.startsWith("https://"), {
  message: "Tautan harus memakai https.",
});

const saveSchema = z.object({
  articleId: z.string().min(1).optional(),
  /** null = artikel global (superadmin). */
  schoolId: z.string().min(1).nullable().optional(),
  title: z.string().trim().min(5, "Judul minimal 5 karakter.").max(140),
  category: z.enum(ARTICLE_CATEGORY_KEYS as [string, ...string[]]),
  type: z.enum(ARTICLE_TYPES),
  summary: z.string().trim().min(10, "Ringkasan minimal 10 karakter.").max(300),
  body: z.string().trim().max(20000).default(""),
  url: httpsUrl.nullable().optional(),
  coverUrl: httpsUrl.nullable().optional(),
  scholarship: z.object({
    organizer: z.string().trim().min(2).max(120),
    level: z.string().trim().min(2).max(60),
    deadline: z.string().regex(/^\d{4}-\d{2}-\d{2}$/, "Tenggat memakai format tahun-bulan-tanggal."),
    url: httpsUrl,
  }).nullable().optional(),
  featured: z.boolean().default(false),
  published: z.boolean().default(true),
}).superRefine((input, context) => {
  if (input.type === "artikel" && input.body.length < 30) {
    context.addIssue({code: "custom", path: ["body"], message: "Isi artikel minimal 30 karakter."});
  }
  if (input.type === "tautan" && !input.url) {
    context.addIssue({code: "custom", path: ["url"], message: "Isi tautan artikel."});
  }
  if (input.type === "beasiswa" && !input.scholarship) {
    context.addIssue({code: "custom", path: ["scholarship"], message: "Lengkapi informasi beasiswa."});
  }
});

/** Penulis konten: superadmin untuk konten global, admin/konselor untuk konten sekolah. */
async function requireAuthor(caller: Caller, schoolId: string | null): Promise<string> {
  if (!schoolId) {
    if (!caller.claims.sa) throw new AppError("permission-denied", "Hanya superadmin yang dapat mengelola Edukasi global.");
    return "Tim MANDU";
  }
  const allowed = caller.claims.sa ||
    (caller.claims.sid === schoolId && (caller.claims.role === "admin" || caller.claims.role === "konselor"));
  if (!allowed) throw new AppError("permission-denied", "Hanya admin sekolah atau konselor yang dapat mengelola Edukasi sekolah.");
  const member = (await memberRef(schoolId, caller.uid).get()).data() as MemberDoc | undefined;
  return member?.displayName ?? "Sekolah";
}

export async function saveArticle(caller: Caller, data: unknown): Promise<{articleId: string}> {
  const input = parsePayload(saveSchema, data);
  const schoolId = input.schoolId ?? null;
  const authorName = await requireAuthor(caller, schoolId);
  const collection = articlesRef(schoolId);
  const ref = input.articleId ? collection.doc(input.articleId) : collection.doc();
  const existing = input.articleId ? (await ref.get()).data() as ArticleDoc | undefined : undefined;
  if (input.articleId && !existing) throw new AppError("not-found", "Artikel tidak ditemukan.");

  const now = Timestamp.now();
  const article: ArticleDoc = {
    title: input.title,
    category: input.category,
    categoryLabel: ARTICLE_CATEGORIES.find((category) => category.key === input.category)!.label,
    type: input.type,
    summary: input.summary,
    body: input.type === "artikel" ? input.body : "",
    url: input.type === "artikel" ? null : (input.type === "beasiswa" ? input.scholarship!.url : input.url!),
    coverUrl: input.coverUrl ?? null,
    scholarship: input.type === "beasiswa" ? input.scholarship! : null,
    featured: input.featured,
    published: input.published,
    views: existing?.views ?? 0,
    scope: schoolId ? "school" : "global",
    schoolId,
    authorName: existing?.authorName ?? authorName,
    createdAt: existing?.createdAt ?? now,
    updatedAt: now,
    publishedAt: input.published ? (existing?.publishedAt ?? now) : null,
  };
  await ref.set(article);
  return {articleId: ref.id};
}

const targetSchema = z.object({articleId: z.string().min(1), schoolId: z.string().min(1).nullable().optional()});

export async function deleteArticle(caller: Caller, data: unknown): Promise<{ok: true}> {
  const {articleId, schoolId} = parsePayload(targetSchema, data);
  await requireAuthor(caller, schoolId ?? null);
  await articlesRef(schoolId ?? null).doc(articleId).delete();
  return {ok: true};
}

/** Tambah hitungan dibaca. Dipanggil aplikasi saat artikel dibuka. */
export async function markArticleRead(caller: Caller, data: unknown): Promise<{ok: true}> {
  const {articleId, schoolId} = parsePayload(targetSchema, data);
  if (schoolId && caller.claims.sid !== schoolId && !caller.claims.sa) {
    throw new AppError("permission-denied", "Artikel ini bukan milik sekolahmu.");
  }
  await articlesRef(schoolId ?? null).doc(articleId).update({views: FieldValue.increment(1)}).catch(() => undefined);
  return {ok: true};
}
