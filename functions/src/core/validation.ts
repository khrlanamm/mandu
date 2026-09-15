import {z} from "zod";
import {AppError} from "./errors";

/** Validasi payload callable; pesan error merangkum field yang tidak valid. */
export function parsePayload<T extends z.ZodType>(schema: T, data: unknown): z.infer<T> {
  const result = schema.safeParse(data);
  if (!result.success) {
    const fields = result.error.issues.map((issue) => issue.path.join(".") || "payload").join(", ");
    throw new AppError("invalid-argument", `Data tidak valid: ${fields}.`);
  }
  return result.data;
}
