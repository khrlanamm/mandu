/** Kata kasar umum (bahasa Indonesia & daerah) yang disamarkan pada aspirasi. */
const BLOCKED_WORDS = [
  "anjing", "anjir", "anjrit", "asu", "babi", "bajingan", "bangsat", "bego", "brengsek", "cok", "goblok", "goblog",
  "idiot", "jancok", "jancuk", "kampret", "keparat", "kontol", "lonte", "memek", "ngentot", "pantek", "pelacur",
  "sialan", "taik", "tai", "tolol",
];

const pattern = new RegExp(`(?<![\\p{L}\\p{N}])(${BLOCKED_WORDS.join("|")})(?![\\p{L}\\p{N}])`, "giu");

export interface ModeratedText {
  text: string;
  flagged: boolean;
}

/** Samarkan kata kasar (huruf pertama tetap terlihat) dan tandai teksnya. */
export function moderateText(input: string): ModeratedText {
  let flagged = false;
  const text = input.replace(pattern, (word: string) => {
    flagged = true;
    return word[0] + "*".repeat(word.length - 1);
  });
  return {text, flagged};
}
