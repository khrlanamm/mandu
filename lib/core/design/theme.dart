import 'package:flutter/material.dart';

import 'palette.dart';
import 'tokens.dart';

abstract final class ManduTheme {
  static const fontFamily = 'PlusJakartaSans';

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final background = isDark ? const Color(0xFF0B1020) : const Color(0xFFF4F6FB);

    final scheme = ColorScheme.fromSeed(seedColor: ManduColors.blue, brightness: brightness).copyWith(
      primary: isDark ? const Color(0xFF7FA8FF) : ManduColors.blue,
      onPrimary: isDark ? const Color(0xFF071333) : Colors.white,
      primaryContainer: isDark ? const Color(0xFF1C2F63) : const Color(0xFFDCE7FF),
      onPrimaryContainer: isDark ? const Color(0xFFDCE7FF) : ManduColors.blueDeep,
      secondary: isDark ? const Color(0xFFFBBF24) : ManduColors.yellow,
      onSecondary: const Color(0xFF1F1300),
      secondaryContainer: isDark ? const Color(0xFF4A3408) : const Color(0xFFFEF3C7),
      onSecondaryContainer: isDark ? const Color(0xFFFDE68A) : const Color(0xFF78350F),
      surface: isDark ? const Color(0xFF10172C) : Colors.white,
      onSurface: isDark ? const Color(0xFFE7ECF6) : ManduColors.navy,
      onSurfaceVariant: isDark ? const Color(0xFF9AA6C2) : const Color(0xFF5B6784),
      surfaceContainerLowest: isDark ? background : Colors.white,
      surfaceContainerLow: isDark ? const Color(0xFF121A30) : const Color(0xFFF7F9FC),
      surfaceContainer: isDark ? const Color(0xFF172039) : const Color(0xFFF1F4F9),
      surfaceContainerHigh: isDark ? const Color(0xFF1D2744) : const Color(0xFFE9EEF6),
      surfaceContainerHighest: isDark ? const Color(0xFF243050) : const Color(0xFFE1E7F1),
      outline: isDark ? const Color(0xFF3A4666) : const Color(0xFFC9D2E1),
      outlineVariant: isDark ? const Color(0xFF273252) : const Color(0xFFE1E7F0),
      error: isDark ? const Color(0xFFFF8A80) : const Color(0xFFD92D20),
      onError: isDark ? const Color(0xFF410002) : Colors.white,
    );

    final base = ThemeData(useMaterial3: true, colorScheme: scheme, fontFamily: fontFamily);
    final text = base.textTheme
        .copyWith(
          displaySmall: const TextStyle(fontSize: 32, height: 1.15, fontWeight: FontWeight.w800, letterSpacing: -0.6),
          headlineMedium: const TextStyle(fontSize: 26, height: 1.2, fontWeight: FontWeight.w800, letterSpacing: -0.4),
          headlineSmall: const TextStyle(fontSize: 22, height: 1.25, fontWeight: FontWeight.w700, letterSpacing: -0.2),
          titleLarge: const TextStyle(fontSize: 19, height: 1.3, fontWeight: FontWeight.w700),
          titleMedium: const TextStyle(fontSize: 16, height: 1.35, fontWeight: FontWeight.w700),
          titleSmall: const TextStyle(fontSize: 14, height: 1.35, fontWeight: FontWeight.w700),
          bodyLarge: const TextStyle(fontSize: 16, height: 1.5),
          bodyMedium: const TextStyle(fontSize: 14.5, height: 1.5),
          bodySmall: const TextStyle(fontSize: 13, height: 1.45),
          labelLarge: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700),
          labelMedium: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          labelSmall: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, letterSpacing: 0.3),
        )
        .apply(fontFamily: fontFamily, bodyColor: scheme.onSurface, displayColor: scheme.onSurface);

    final fieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(Radii.md),
      borderSide: BorderSide(color: scheme.outline),
    );
    final buttonShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.md));

    return base.copyWith(
      textTheme: text,
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: text.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.lg),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(minimumSize: const Size(64, 52), textStyle: text.labelLarge, shape: buttonShape),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 52),
          textStyle: text.labelLarge,
          shape: buttonShape,
          side: BorderSide(color: scheme.outline),
        ),
      ),
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(textStyle: text.labelLarge, shape: buttonShape)),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: Gaps.lg, vertical: Gaps.lg),
        border: fieldBorder,
        enabledBorder: fieldBorder,
        focusedBorder: fieldBorder.copyWith(borderSide: BorderSide(color: scheme.primary, width: 2)),
        errorBorder: fieldBorder.copyWith(borderSide: BorderSide(color: scheme.error)),
        focusedErrorBorder: fieldBorder.copyWith(borderSide: BorderSide(color: scheme.error, width: 2)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primaryContainer,
        height: 68,
        labelTextStyle: WidgetStatePropertyAll(text.labelMedium),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primaryContainer,
        selectedLabelTextStyle: text.labelMedium?.copyWith(color: scheme.onSurface),
        unselectedLabelTextStyle: text.labelMedium?.copyWith(color: scheme.onSurfaceVariant),
      ),
      chipTheme: ChipThemeData(
        shape: const StadiumBorder(),
        side: BorderSide(color: scheme.outlineVariant),
        labelStyle: text.labelMedium,
      ),
      dividerTheme: DividerThemeData(color: scheme.outlineVariant, space: 1, thickness: 1),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.md)),
        titleTextStyle: text.titleSmall,
        subtitleTextStyle: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.md)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        showDragHandle: true,
        backgroundColor: scheme.surface,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(Radii.xl))),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.xl)),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {TargetPlatform.android: PredictiveBackPageTransitionsBuilder()},
      ),
      extensions: [isDark ? ManduPalette.dark : ManduPalette.light],
    );
  }
}
