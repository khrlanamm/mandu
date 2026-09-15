import 'package:flutter/material.dart';

import '../design/palette.dart';

/// Lima pintu layanan MANDU 2.0.
enum ManduService {
  lapor(
    label: 'Lapor',
    tagline: 'Masalah yang perlu ditangani sekolah',
    icon: Icons.campaign_rounded,
  ),
  curhat(
    label: 'Curhat',
    tagline: 'Cerita pribadi, didengar Guru BK',
    icon: Icons.forum_rounded,
  ),
  aspirasi(
    label: 'Aspirasi',
    tagline: 'Saran, ide, usulan, dan kritik',
    icon: Icons.lightbulb_rounded,
  ),
  bantuan(
    label: 'Butuh Bantuan',
    tagline: 'Minta bantuan tanpa harus menjelaskan',
    icon: Icons.volunteer_activism_rounded,
  ),
  edukasi(
    label: 'Edukasi',
    tagline: 'Informasi, tips, dan beasiswa',
    icon: Icons.menu_book_rounded,
  );

  const ManduService({required this.label, required this.tagline, required this.icon});

  final String label;
  final String tagline;
  final IconData icon;

  ToneColors tone(ManduPalette palette) => switch (this) {
        ManduService.lapor => palette.lapor,
        ManduService.curhat => palette.curhat,
        ManduService.aspirasi => palette.aspirasi,
        ManduService.bantuan => palette.bantuan,
        ManduService.edukasi => palette.edukasi,
      };
}
