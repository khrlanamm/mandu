import 'package:flutter/material.dart';

import '../../data/models/report.dart';
import '../theme/app_colors.dart';

class LabelChip extends StatelessWidget {
  const LabelChip({
    super.key,
    required this.label,
    required this.color,
    this.fontSize = 10,
  });

  final String label;
  final Color color;
  final double fontSize;

  /// TERLAPOR / DITANGANI. Status yang tidak dikenal tidak ditampilkan.
  static Widget status(String status, {double fontSize = 10}) {
    return switch (status.toLowerCase()) {
      Report.statusReported =>
        LabelChip(label: 'TERLAPOR', color: AppColors.statusReported, fontSize: fontSize),
      Report.statusHandled =>
        LabelChip(label: 'DITANGANI', color: AppColors.statusHandled, fontSize: fontSize),
      _ => const SizedBox.shrink(),
    };
  }

  /// KORBAN / SAKSI. Peran yang tidak dikenal tidak ditampilkan.
  static Widget role(String role, {double fontSize = 10}) {
    return switch (role.toLowerCase()) {
      'korban' => LabelChip(label: 'KORBAN', color: AppColors.roleVictim, fontSize: fontSize),
      'saksi' => LabelChip(label: 'SAKSI', color: AppColors.roleWitness, fontSize: fontSize),
      _ => const SizedBox.shrink(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
