import 'package:cloud_firestore/cloud_firestore.dart';

/// Dokumen koleksi `reports`. Nama field sengaja sama dengan Firestore
/// agar kompatibel dengan data dari aplikasi Kotlin sebelumnya.
class Report {
  const Report({
    required this.id,
    required this.userId,
    required this.peran,
    required this.status,
    required this.tanggalBullying,
    required this.lokasi,
    required this.frekuensi,
    required this.deskripsi,
    required this.nomorWhatsapp,
    required this.timestamp,
    this.urlBukti,
  });

  factory Report.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data() ?? const <String, dynamic>{};
    final timestamp = data['timestamp'];
    return Report(
      id: snapshot.id,
      userId: data['userId'] as String? ?? '',
      peran: data['peran'] as String? ?? '',
      status: data['status'] as String? ?? '',
      tanggalBullying: data['tanggalBullying'] as String? ?? '',
      lokasi: data['lokasi'] as String? ?? '',
      frekuensi: data['frekuensi'] as String? ?? '',
      deskripsi: data['deskripsi'] as String? ?? '',
      nomorWhatsapp: data['nomorWhatsapp'] as String? ?? '',
      timestamp: timestamp is Timestamp ? timestamp.toDate() : DateTime.now(),
      urlBukti: data['urlBukti'] as String?,
    );
  }

  static const statusReported = 'terlapor';
  static const statusHandled = 'ditangani';
  static const roleVictim = 'Korban';
  static const roleWitness = 'Saksi';

  /// ID dokumen Firestore.
  final String id;
  final String userId;
  final String peran;
  final String status;
  final String tanggalBullying;
  final String lokasi;
  final String frekuensi;
  final String deskripsi;
  final String nomorWhatsapp;
  final DateTime timestamp;
  final String? urlBukti;

  bool get isReported => status.toLowerCase() == statusReported;
  bool get isHandled => status.toLowerCase() == statusHandled;

  Report copyWith({String? status}) {
    return Report(
      id: id,
      userId: userId,
      peran: peran,
      status: status ?? this.status,
      tanggalBullying: tanggalBullying,
      lokasi: lokasi,
      frekuensi: frekuensi,
      deskripsi: deskripsi,
      nomorWhatsapp: nomorWhatsapp,
      timestamp: timestamp,
      urlBukti: urlBukti,
    );
  }
}

/// Isian formulir LaBu sebelum dikirim.
class ReportDraft {
  const ReportDraft({
    required this.peran,
    required this.tanggalBullying,
    required this.lokasi,
    required this.frekuensi,
    required this.deskripsi,
    required this.nomorWhatsapp,
  });

  final String peran;
  final String tanggalBullying;
  final String lokasi;
  final String frekuensi;
  final String deskripsi;
  final String nomorWhatsapp;
}
