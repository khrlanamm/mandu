import 'package:flutter/material.dart';

/// Satu nada warna: warna utama dan pasangan container-nya.
@immutable
class ToneColors {
  const ToneColors({required this.main, required this.onMain, required this.container, required this.onContainer});

  final Color main;
  final Color onMain;
  final Color container;
  final Color onContainer;
}

/// Warna 5 pintu layanan dan warna status, untuk tema terang dan gelap.
@immutable
class ManduPalette extends ThemeExtension<ManduPalette> {
  const ManduPalette({
    required this.lapor,
    required this.curhat,
    required this.aspirasi,
    required this.bantuan,
    required this.edukasi,
    required this.success,
    required this.warning,
    required this.danger,
    required this.info,
    required this.neutral,
  });

  final ToneColors lapor;
  final ToneColors curhat;
  final ToneColors aspirasi;
  final ToneColors bantuan;
  final ToneColors edukasi;
  final ToneColors success;
  final ToneColors warning;
  final ToneColors danger;
  final ToneColors info;
  final ToneColors neutral;

  static const light = ManduPalette(
    lapor: ToneColors(main: Color(0xFFE5484D), onMain: Colors.white, container: Color(0xFFFFE5E5), onContainer: Color(0xFF8C1D23)),
    curhat: ToneColors(main: Color(0xFF0E9F8E), onMain: Colors.white, container: Color(0xFFD7F5F0), onContainer: Color(0xFF065F55)),
    aspirasi: ToneColors(main: Color(0xFFE8930C), onMain: Colors.white, container: Color(0xFFFFF0D1), onContainer: Color(0xFF7A4A02)),
    bantuan: ToneColors(main: Color(0xFF7C5CFC), onMain: Colors.white, container: Color(0xFFECE6FF), onContainer: Color(0xFF3F2A9E)),
    edukasi: ToneColors(main: Color(0xFF2F6FED), onMain: Colors.white, container: Color(0xFFE0EAFF), onContainer: Color(0xFF173B8F)),
    success: ToneColors(main: Color(0xFF1E9E5A), onMain: Colors.white, container: Color(0xFFDDF5E7), onContainer: Color(0xFF0E5B33)),
    warning: ToneColors(main: Color(0xFFD97706), onMain: Colors.white, container: Color(0xFFFEF0D7), onContainer: Color(0xFF7A3F02)),
    danger: ToneColors(main: Color(0xFFD92D20), onMain: Colors.white, container: Color(0xFFFDE3E1), onContainer: Color(0xFF8A1A12)),
    info: ToneColors(main: Color(0xFF2563EB), onMain: Colors.white, container: Color(0xFFDCE7FF), onContainer: Color(0xFF1E3A8A)),
    neutral: ToneColors(main: Color(0xFF64708C), onMain: Colors.white, container: Color(0xFFE9EDF4), onContainer: Color(0xFF3A4560)),
  );

  static const dark = ManduPalette(
    lapor: ToneColors(main: Color(0xFFFF6B6F), onMain: Color(0xFF3A0508), container: Color(0xFF4A1519), onContainer: Color(0xFFFFD6D6)),
    curhat: ToneColors(main: Color(0xFF3DD6C3), onMain: Color(0xFF00302A), container: Color(0xFF0D3E38), onContainer: Color(0xFFC4F5EE)),
    aspirasi: ToneColors(main: Color(0xFFFFB547), onMain: Color(0xFF3A2400), container: Color(0xFF4A3107), onContainer: Color(0xFFFFE3B5)),
    bantuan: ToneColors(main: Color(0xFFA48BFF), onMain: Color(0xFF1C0F5C), container: Color(0xFF2E2266), onContainer: Color(0xFFE4DCFF)),
    edukasi: ToneColors(main: Color(0xFF7FA8FF), onMain: Color(0xFF071A4A), container: Color(0xFF1C2F63), onContainer: Color(0xFFDCE7FF)),
    success: ToneColors(main: Color(0xFF4ED18A), onMain: Color(0xFF002E15), container: Color(0xFF113D26), onContainer: Color(0xFFC9F2DA)),
    warning: ToneColors(main: Color(0xFFFFB547), onMain: Color(0xFF3A2400), container: Color(0xFF4A3107), onContainer: Color(0xFFFFE3B5)),
    danger: ToneColors(main: Color(0xFFFF8A80), onMain: Color(0xFF410002), container: Color(0xFF5C1712), onContainer: Color(0xFFFFDAD6)),
    info: ToneColors(main: Color(0xFF7FA8FF), onMain: Color(0xFF071A4A), container: Color(0xFF1C2F63), onContainer: Color(0xFFDCE7FF)),
    neutral: ToneColors(main: Color(0xFF9AA6C2), onMain: Color(0xFF151C2E), container: Color(0xFF243050), onContainer: Color(0xFFD9DFEC)),
  );

  @override
  ManduPalette copyWith() => this;

  @override
  ManduPalette lerp(ManduPalette? other, double t) => other == null || t < 0.5 ? this : other;
}

extension ManduThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textStyles => Theme.of(this).textTheme;
  ManduPalette get palette => Theme.of(this).extension<ManduPalette>() ?? ManduPalette.light;
}
