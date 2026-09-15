import {defineConfig} from "vitest/config";

export default defineConfig({
  test: {
    include: ["test/**/*.test.ts"],
    // Semua tes berbagi satu Emulator Suite, jadi dijalankan berurutan.
    fileParallelism: false,
    testTimeout: 20_000,
  },
});
