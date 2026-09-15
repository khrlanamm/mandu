import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/domain/catalog.dart';

class ReportCategoryScreen extends StatelessWidget {
  const ReportCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tone = context.palette.lapor;
    return Scaffold(
      appBar: AppBar(title: const Text('Lapor')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Gaps.xl, Gaps.sm, Gaps.xl, Gaps.xl),
        children: [
          ContentWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Apa yang ingin kamu laporkan?', style: context.textStyles.headlineSmall),
                const SizedBox(height: Gaps.xs),
                Text(
                  'Tim Verifikasi sekolah memeriksa laporanmu, lalu meneruskannya ke unit yang tepat. Kamu akan mendapat kabar di setiap tahap.',
                  style: context.textStyles.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
                ),
                const SizedBox(height: Gaps.xl),
                for (final category in kReportCategories) ...[
                  Card(
                    clipBehavior: Clip.antiAlias,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: Gaps.lg, vertical: Gaps.sm),
                      leading: DecoratedBox(
                        decoration: BoxDecoration(color: tone.container, borderRadius: BorderRadius.circular(Radii.md)),
                        child: Padding(padding: const EdgeInsets.all(Gaps.sm), child: Icon(category.icon, color: tone.main)),
                      ),
                      title: Text(category.label),
                      subtitle: Text(category.description),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => context.push(Routes.studentReportForm(category.key)),
                    ),
                  ),
                  const SizedBox(height: Gaps.md),
                ],
                const SizedBox(height: Gaps.sm),
                InfoBanner(
                  icon: Icons.health_and_safety_outlined,
                  title: 'Ada yang dalam bahaya sekarang?',
                  message: 'Segera hubungi guru terdekat atau 112. Laporan MANDU tetap bisa kamu kirim setelahnya.',
                  tone: context.palette.danger,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
