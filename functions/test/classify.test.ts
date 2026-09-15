import {describe, expect, it} from "vitest";
import {classifyTicket} from "../src/tickets/classify";

describe("classifyTicket", () => {
  it("menandai darurat untuk kata kunci keselamatan jiwa", () => {
    const result = classifyTicket({category: "keamanan", title: "Tolong", description: "Teman saya bilang ingin mati dan membawa pisau"});
    expect(result.priority).toBe("darurat");
    expect(result.priorityReason).toContain("ingin mati");
  });

  it("menaikkan prioritas kekerasan dan memakai prioritas bawaan kategori", () => {
    expect(classifyTicket({category: "fasilitas", title: "Dipukul kakak kelas", description: "Saya dipukul di dekat kantin"}).priority).toBe("tinggi");
    expect(classifyTicket({category: "keamanan", title: "Barang hilang", description: "Tas saya hilang di kelas"}).priority).toBe("tinggi");
    expect(classifyTicket({category: "fasilitas", title: "Kipas mati", description: "Kipas angin kelas tidak menyala"}).priority).toBe("normal");
  });

  it("menyarankan kategori yang lebih cocok", () => {
    const wrongCategory = classifyTicket({category: "pembelajaran", title: "Toilet kotor", description: "Toilet lantai dua kotor, bau, dan banyak sampah"});
    expect(wrongCategory.suggestedCategory).toBe("kebersihan");
    const rightCategory = classifyTicket({category: "kebersihan", title: "Toilet kotor", description: "Banyak sampah dan bau"});
    expect(rightCategory.suggestedCategory).toBeNull();
  });

  it("tidak salah mencocokkan potongan kata", () => {
    expect(classifyTicket({category: "lainnya", title: "Pukulan drum ekskul", description: "Latihan marching band terlalu keras"}).priority).toBe("normal");
  });
});
