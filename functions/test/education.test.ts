import {beforeEach, describe, expect, it} from "vitest";
import {deleteArticle, markArticleRead, saveArticle} from "../src/education/articles";
import {createSchool} from "../src/schools/manage";
import {SUPERADMIN, addMember, db, resetEmulators} from "./helpers";

async function setupSchool() {
  const {schoolId} = await createSchool(SUPERADMIN, {name: "SMA Belajar", level: "SMA", city: "Lamongan", province: "Jawa Timur", code: "BELAJAR"});
  return {
    schoolId,
    admin: await addMember(schoolId, "admin", {displayName: "Andi Admin", role: "admin"}),
    bk: await addMember(schoolId, "bk", {displayName: "Sri Wahyuni", role: "konselor", units: ["bk_ppks"]}),
    sarpras: await addMember(schoolId, "sarpras", {displayName: "Joko Sarpras", role: "petugas", units: ["sarpras"]}),
    siswa: await addMember(schoolId, "siswa", {displayName: "Budi Santoso", role: "siswa", kelas: "XI IPA 1"}),
  };
}

const article = (overrides: Record<string, unknown> = {}) => ({
  title: "Mengenali tanda perundungan",
  category: "anti_bullying",
  type: "artikel",
  summary: "Kenali tanda perundungan pada dirimu dan temanmu, serta langkah pertama yang bisa dilakukan.",
  body: "Perundungan bukan sekadar bercanda. Bila kamu merasa takut, sedih, atau menghindari sekolah, ceritakan kepada orang dewasa yang kamu percaya.",
  ...overrides,
});

const globalArticle = async (id: string) => (await db.doc(`articles/${id}`).get()).data()!;

describe("Edukasi", () => {
  beforeEach(resetEmulators);

  it("superadmin mengelola artikel global; staf sekolah tidak", async () => {
    const school = await setupSchool();
    const {articleId} = await saveArticle(SUPERADMIN, article());
    expect(await globalArticle(articleId)).toMatchObject({
      scope: "global",
      schoolId: null,
      categoryLabel: "Anti-Perundungan",
      published: true,
      views: 0,
      authorName: "Tim MANDU",
    });
    await expect(saveArticle(school.admin, article())).rejects.toMatchObject({code: "permission-denied"});

    await saveArticle(SUPERADMIN, article({articleId, title: "Mengenali tanda perundungan (revisi)", featured: true}));
    const updated = await globalArticle(articleId);
    expect(updated).toMatchObject({title: "Mengenali tanda perundungan (revisi)", featured: true});
    expect(updated.createdAt.toMillis()).toBe((await globalArticle(articleId)).createdAt.toMillis());
  });

  it("admin dan konselor menulis artikel sekolah, peran lain ditolak", async () => {
    const school = await setupSchool();
    const {schoolId} = school;
    const byAdmin = await saveArticle(school.admin, article({schoolId, title: "Jadwal layanan BK", category: "layanan_bk"}));
    expect((await db.doc(`schools/${schoolId}/articles/${byAdmin.articleId}`).get()).data())
      .toMatchObject({scope: "school", schoolId, authorName: "Andi Admin"});

    await expect(saveArticle(school.bk, article({schoolId, category: "kesehatan_mental"}))).resolves.toBeTruthy();
    await expect(saveArticle(school.sarpras, article({schoolId}))).rejects.toMatchObject({code: "permission-denied"});
    await expect(saveArticle(school.siswa, article({schoolId}))).rejects.toMatchObject({code: "permission-denied"});
  });

  it("memeriksa kelengkapan sesuai jenis konten", async () => {
    await expect(saveArticle(SUPERADMIN, article({body: "Terlalu pendek"}))).rejects.toMatchObject({code: "invalid-argument"});
    await expect(saveArticle(SUPERADMIN, article({type: "tautan", body: ""}))).rejects.toMatchObject({code: "invalid-argument"});
    await expect(saveArticle(SUPERADMIN, article({type: "tautan", body: "", url: "http://tidakaman.example"})))
      .rejects.toMatchObject({code: "invalid-argument"});
    await expect(saveArticle(SUPERADMIN, article({type: "beasiswa", body: ""}))).rejects.toMatchObject({code: "invalid-argument"});

    const link = await saveArticle(SUPERADMIN, article({type: "tautan", body: "", url: "https://kemdikbud.go.id/panduan"}));
    expect(await globalArticle(link.articleId)).toMatchObject({type: "tautan", body: "", url: "https://kemdikbud.go.id/panduan"});

    const scholarship = await saveArticle(SUPERADMIN, article({
      type: "beasiswa",
      body: "",
      category: "beasiswa",
      scholarship: {organizer: "Kemendikbud", level: "SMA", deadline: "2026-11-30", url: "https://beasiswa.example.com"},
    }));
    expect(await globalArticle(scholarship.articleId)).toMatchObject({
      type: "beasiswa",
      url: "https://beasiswa.example.com",
      scholarship: {organizer: "Kemendikbud", deadline: "2026-11-30"},
    });
  });

  it("hitungan dibaca bertambah dan artikel bisa dihapus", async () => {
    const school = await setupSchool();
    const {articleId} = await saveArticle(SUPERADMIN, article());
    await markArticleRead(school.siswa, {articleId});
    await markArticleRead(school.siswa, {articleId});
    expect((await globalArticle(articleId)).views).toBe(2);

    const schoolArticle = await saveArticle(school.admin, article({schoolId: school.schoolId}));
    await expect(markArticleRead(SUPERADMIN, {articleId: schoolArticle.articleId, schoolId: school.schoolId})).resolves.toBeTruthy();
    await expect(deleteArticle(school.siswa, {articleId: schoolArticle.articleId, schoolId: school.schoolId}))
      .rejects.toMatchObject({code: "permission-denied"});
    await deleteArticle(school.admin, {articleId: schoolArticle.articleId, schoolId: school.schoolId});
    expect((await db.doc(`schools/${school.schoolId}/articles/${schoolArticle.articleId}`).get()).exists).toBe(false);
  });
});
