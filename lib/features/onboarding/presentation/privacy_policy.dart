import 'package:flutter/material.dart';

import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';

const _sections = <(String, List<String>)>[
  (
    'Data yang disimpan',
    [
      'Nama, email atau NISN, sekolah, dan kelas.',
      'Isi laporan, curhat, aspirasi, dan permintaan bantuan beserta lampirannya.',
      'Token notifikasi perangkat agar kamu menerima kabar terbaru.',
    ],
  ),
  (
    'Siapa yang bisa melihat',
    [
      'Laporan hanya dibaca petugas sekolah yang berwenang. Kamu bisa merahasiakan identitasmu.',
      'Curhat dan Butuh Bantuan hanya dibaca konselor yang menanganinya.',
      'Aspirasi tanpa login tidak menyimpan identitas pengirim.',
      'Pengelola platform (superadmin) tidak dapat membaca isi curhat.',
    ],
  ),
  (
    'Pengguna di bawah 18 tahun',
    ['Pastikan orang tua atau wali mengetahui bahwa kamu menggunakan MANDU.'],
  ),
  (
    'Hakmu',
    [
      'Melihat dan memperbarui data akunmu.',
      'Meminta penghapusan akun kapan saja melalui admin sekolah atau menu Akun.',
    ],
  ),
  (
    'Keadaan darurat',
    ['MANDU bukan layanan darurat. Jika kamu atau orang lain dalam bahaya, hubungi 112 atau orang dewasa terdekat.'],
  ),
];

/// Ringkasan Kebijakan Privasi MANDU (versi kConsentVersion).
class PrivacyPolicySections extends StatelessWidget {
  const PrivacyPolicySections({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (title, points) in _sections) ...[
          Text(title, style: context.textStyles.titleSmall),
          const SizedBox(height: Gaps.xs),
          for (final point in points)
            Padding(
              padding: const EdgeInsets.only(bottom: Gaps.xs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, right: Gaps.sm),
                    child: Icon(Icons.circle, size: 6, color: context.colors.primary),
                  ),
                  Expanded(child: Text(point, style: context.textStyles.bodyMedium)),
                ],
              ),
            ),
          const SizedBox(height: Gaps.md),
        ],
      ],
    );
  }
}
