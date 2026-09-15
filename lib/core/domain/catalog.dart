/// Salinan katalog dari functions/src/domain/catalog.ts — ubah keduanya bersamaan.
library;

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

/// Versi kebijakan privasi (CONSENT_VERSION).
const kConsentVersion = '2026-09';

const kSchoolLevels = ['SD', 'SMP', 'MTs', 'SMA', 'SMK', 'MA', 'SLB', 'Lainnya'];

enum TicketPriority {
  normal('Normal'),
  tinggi('Tinggi'),
  darurat('Darurat');

  const TicketPriority(this.label);

  final String label;
}

class ReportSubcategory {
  const ReportSubcategory(this.key, this.label);

  final String key;
  final String label;
}

class ReportCategory {
  const ReportCategory({
    required this.key,
    required this.label,
    required this.description,
    required this.icon,
    required this.defaultUnitId,
    required this.subcategories,
  });

  final String key;
  final String label;
  final String description;
  final IconData icon;
  final String defaultUnitId;
  final List<ReportSubcategory> subcategories;

  /// Laporan keamanan dirahasiakan secara bawaan dan punya isian tambahan.
  bool get isSafety => key == 'keamanan';

  String subcategoryLabel(String key) =>
      subcategories.firstWhere((entry) => entry.key == key, orElse: () => subcategories.last).label;
}

const kReportCategories = [
  ReportCategory(
    key: 'keamanan',
    label: 'Keamanan & Perlindungan',
    description: 'Perundungan, kekerasan, pelecehan, ancaman, dan rasa tidak aman di sekolah.',
    icon: Icons.shield_outlined,
    defaultUnitId: 'bk_ppks',
    subcategories: [
      ReportSubcategory('perundungan', 'Perundungan (bullying)'),
      ReportSubcategory('perundungan_siber', 'Perundungan siber'),
      ReportSubcategory('kekerasan_fisik', 'Kekerasan fisik'),
      ReportSubcategory('kekerasan_verbal', 'Kekerasan verbal / psikis'),
      ReportSubcategory('pelecehan_seksual', 'Pelecehan seksual'),
      ReportSubcategory('diskriminasi', 'Diskriminasi / intoleransi'),
      ReportSubcategory('ancaman_keamanan', 'Ancaman keamanan (pencurian, orang asing)'),
      ReportSubcategory('lainnya', 'Lainnya'),
    ],
  ),
  ReportCategory(
    key: 'fasilitas',
    label: 'Fasilitas & Sarana',
    description: 'Kerusakan bangunan, perabot, listrik, air, dan peralatan belajar.',
    icon: Icons.chair_outlined,
    defaultUnitId: 'sarpras',
    subcategories: [
      ReportSubcategory('bangunan', 'Bangunan & ruang kelas'),
      ReportSubcategory('perabot', 'Meja, kursi, papan tulis'),
      ReportSubcategory('listrik_air', 'Listrik & air'),
      ReportSubcategory('toilet', 'Toilet'),
      ReportSubcategory('laboratorium', 'Laboratorium & perpustakaan'),
      ReportSubcategory('teknologi', 'Komputer, proyektor, internet'),
      ReportSubcategory('lainnya', 'Lainnya'),
    ],
  ),
  ReportCategory(
    key: 'pembelajaran',
    label: 'Pembelajaran',
    description: 'Kegiatan belajar mengajar, jadwal, tugas, dan penilaian.',
    icon: Icons.school_outlined,
    defaultUnitId: 'kurikulum',
    subcategories: [
      ReportSubcategory('jam_kosong', 'Jam kosong / guru tidak hadir'),
      ReportSubcategory('metode', 'Cara mengajar'),
      ReportSubcategory('tugas_materi', 'Tugas & materi'),
      ReportSubcategory('penilaian', 'Penilaian & ujian'),
      ReportSubcategory('jadwal', 'Jadwal pelajaran'),
      ReportSubcategory('lainnya', 'Lainnya'),
    ],
  ),
  ReportCategory(
    key: 'kebersihan',
    label: 'Kebersihan & Lingkungan',
    description: 'Sampah, kebersihan ruang, kantin, dan lingkungan sekolah.',
    icon: Icons.cleaning_services_outlined,
    defaultUnitId: 'sarpras',
    subcategories: [
      ReportSubcategory('sampah', 'Sampah'),
      ReportSubcategory('ruang_kelas', 'Kebersihan ruang kelas'),
      ReportSubcategory('toilet', 'Kebersihan toilet'),
      ReportSubcategory('kantin', 'Kantin & makanan'),
      ReportSubcategory('lingkungan', 'Taman & lingkungan'),
      ReportSubcategory('lainnya', 'Lainnya'),
    ],
  ),
  ReportCategory(
    key: 'administrasi',
    label: 'Layanan Administrasi',
    description: 'Surat-menyurat, data siswa, pembayaran, dan layanan tata usaha.',
    icon: Icons.description_outlined,
    defaultUnitId: 'tata_usaha',
    subcategories: [
      ReportSubcategory('surat', 'Surat & legalisasi'),
      ReportSubcategory('data_siswa', 'Data siswa / rapor'),
      ReportSubcategory('pembayaran', 'Pembayaran'),
      ReportSubcategory('pelayanan', 'Pelayanan petugas'),
      ReportSubcategory('lainnya', 'Lainnya'),
    ],
  ),
  ReportCategory(
    key: 'kesiswaan',
    label: 'Kesiswaan',
    description: 'Ekstrakurikuler, OSIS, tata tertib, dan kegiatan siswa.',
    icon: Icons.groups_2_outlined,
    defaultUnitId: 'kesiswaan',
    subcategories: [
      ReportSubcategory('ekstrakurikuler', 'Ekstrakurikuler'),
      ReportSubcategory('osis', 'OSIS & organisasi'),
      ReportSubcategory('tata_tertib', 'Tata tertib & kedisiplinan'),
      ReportSubcategory('kegiatan', 'Kegiatan & lomba'),
      ReportSubcategory('lainnya', 'Lainnya'),
    ],
  ),
  ReportCategory(
    key: 'lainnya',
    label: 'Lainnya',
    description: 'Persoalan lain yang perlu ditangani sekolah.',
    icon: Icons.more_horiz_rounded,
    defaultUnitId: 'manajemen',
    subcategories: [ReportSubcategory('lainnya', 'Lainnya')],
  ),
];

ReportCategory? reportCategory(String key) {
  for (final category in kReportCategories) {
    if (category.key == key) return category;
  }
  return null;
}

final kCategoryLabels = {for (final category in kReportCategories) category.key: category.label};

/// Batas lampiran (MAX_ATTACHMENTS, MAX_ATTACHMENT_BYTES di functions).
const kMaxAttachments = 5;
const kMaxAttachmentBytes = 10 * 1024 * 1024;

/// Alasan penolakan laporan (REJECT_REASON_LABELS).
enum RejectReason {
  @JsonValue('duplikat')
  duplikat('duplikat', 'Sama dengan laporan lain'),
  @JsonValue('tidak_valid')
  tidakValid('tidak_valid', 'Data tidak dapat diverifikasi'),
  @JsonValue('bukan_wewenang')
  bukanWewenang('bukan_wewenang', 'Bukan wewenang sekolah'),
  @JsonValue('lainnya')
  lainnya('lainnya', 'Alasan lain');

  const RejectReason(this.wire, this.label);

  /// Nilai yang dikirim ke functions.
  final String wire;
  final String label;
}
