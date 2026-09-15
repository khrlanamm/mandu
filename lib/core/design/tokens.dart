import 'package:flutter/painting.dart';

/// Warna identitas MANDU 2.0 (dari simbol "Suara Siswa").
abstract final class ManduColors {
  static const blue = Color(0xFF2563EB);
  static const blueDeep = Color(0xFF1E3A8A);
  static const navy = Color(0xFF0E1B3D);
  static const sky = Color(0xFF38BDF8);
  static const yellow = Color(0xFFF59E0B);
}

abstract final class Gaps {
  static const double xs = 4, sm = 8, md = 12, lg = 16, xl = 24, xxl = 32, xxxl = 48;
}

abstract final class Radii {
  static const double sm = 8, md = 12, lg = 16, xl = 24;
}

/// Lebar maksimum konten pada tablet dan web.
const double kContentMaxWidth = 720;

/// Lebar minimum untuk tata letak lebar (NavigationRail).
const double kWideLayoutBreakpoint = 840;
