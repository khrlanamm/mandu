import {setGlobalOptions} from "firebase-functions/v2";

setGlobalOptions({region: "us-central1", maxInstances: 10});

// Dipakai aplikasi 4.0.0 sampai migrasi MANDU 2.0 selesai (lihat rencana tahap 7).
export {sendReportNotification} from "./legacy/sendReportNotification";
