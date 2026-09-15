import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../core/constants.dart';
import '../models/report.dart';

class ReportRepository {
  ReportRepository({
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
    FirebaseFunctions? functions,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _storage = storage ?? FirebaseStorage.instance,
        _functions =
            functions ?? FirebaseFunctions.instanceFor(region: AppConstants.functionsRegion),
        _auth = auth ?? FirebaseAuth.instance;

  static final instance = ReportRepository();

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseFunctions _functions;
  final FirebaseAuth _auth;

  CollectionReference<Map<String, dynamic>> get _reports => _firestore.collection('reports');

  /// Admin melihat semua laporan; pengguna biasa hanya laporannya sendiri.
  Future<List<Report>> fetchHistory({required String userId, required bool isAdmin}) async {
    Query<Map<String, dynamic>> query = _reports;
    if (!isAdmin) query = query.where('userId', isEqualTo: userId);
    final snapshot = await query.orderBy('timestamp', descending: true).get();
    return snapshot.docs.map(Report.fromSnapshot).toList();
  }

  /// Unggah bukti (opsional), simpan laporan, lalu minta Cloud Function
  /// `sendReportNotification` mengirim notifikasi ke admin.
  Future<void> submitReport(ReportDraft draft, {File? proof}) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw StateError('Gagal mengidentifikasi pengguna.');

    final doc = _reports.doc();
    final proofUrl = proof == null ? null : await _uploadProof(doc.id, proof);

    await doc.set({
      'id': doc.id,
      'userId': userId,
      'peran': draft.peran,
      'tanggalBullying': draft.tanggalBullying,
      'lokasi': draft.lokasi,
      'frekuensi': draft.frekuensi,
      'deskripsi': draft.deskripsi,
      'nomorWhatsapp': draft.nomorWhatsapp,
      'urlBukti': proofUrl,
      'timestamp': FieldValue.serverTimestamp(),
      'status': Report.statusReported,
    });

    try {
      await _functions
          .httpsCallable(
            'sendReportNotification',
            options: HttpsCallableOptions(timeout: const Duration(seconds: 20)),
          )
          .call({
        'peran': draft.peran,
        'deskripsi': draft.deskripsi,
        'lokasi': draft.lokasi,
        'tanggalBullying': draft.tanggalBullying,
        'urlBukti': proofUrl,
      });
    } catch (e) {
      // Laporan sudah tersimpan; gagal kirim notifikasi tidak menggagalkan laporan.
      debugPrint('Pemanggilan sendReportNotification gagal: $e');
    }
  }

  Future<void> updateStatus(String reportId, String status) {
    return _reports.doc(reportId).update({'status': status});
  }

  Future<void> deleteReport(String reportId) => _reports.doc(reportId).delete();

  Future<String> _uploadProof(String reportId, File proof) async {
    final extension = proof.path.split('.').last.toLowerCase();
    final contentType = switch (extension) {
      'png' => 'image/png',
      'webp' => 'image/webp',
      'gif' => 'image/gif',
      'heic' => 'image/heic',
      _ => 'image/jpeg',
    };
    final fileExtension = contentType == 'image/jpeg' ? 'jpg' : extension;

    final ref = _storage.ref('laporan_bukti/bukti_$reportId.$fileExtension');
    await ref.putFile(proof, SettableMetadata(contentType: contentType));
    return ref.getDownloadURL();
  }
}
