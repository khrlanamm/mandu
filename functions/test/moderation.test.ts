import {describe, expect, it} from "vitest";
import {moderateText} from "../src/aspirations/moderation";

describe("moderateText", () => {
  it("menyamarkan kata kasar tanpa mengubah kata lain", () => {
    expect(moderateText("Petugasnya GOBLOK, antre lama sekali")).toEqual({text: "Petugasnya G*****, antre lama sekali", flagged: true});
    expect(moderateText("Dasar tai!")).toEqual({text: "Dasar t**!", flagged: true});
  });

  it("tidak menandai kata yang hanya mengandung potongan kata kasar", () => {
    expect(moderateText("Tolong perbaiki kran di taman, airnya menetes terus")).toEqual({
      text: "Tolong perbaiki kran di taman, airnya menetes terus",
      flagged: false,
    });
    expect(moderateText("Mencoba menu baru di kantin").flagged).toBe(false);
  });
});
