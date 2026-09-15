import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../app/env.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../schools/domain/school.dart';

String schoolLink(String code) => '${Env.webBaseUrl}/s/$code';

/// QR dan kode sekolah untuk dibagikan ke siswa (gabung, login NISN, aspirasi tanpa login).
Future<void> showSchoolCodeSheet(BuildContext context, School school) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => _SchoolCodeSheet(school: school),
  );
}

class _SchoolCodeSheet extends StatelessWidget {
  const _SchoolCodeSheet({required this.school});

  final School school;

  @override
  Widget build(BuildContext context) {
    final link = schoolLink(school.code);
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(Gaps.xl, 0, Gaps.xl, Gaps.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(school.name, textAlign: TextAlign.center, style: context.textStyles.titleLarge),
            const SizedBox(height: Gaps.xs),
            Text(
              'Siswa memindai QR ini untuk bergabung, masuk dengan NISN, atau mengirim aspirasi.',
              textAlign: TextAlign.center,
              style: context.textStyles.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
            ),
            const SizedBox(height: Gaps.xl),
            Center(
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(Radii.lg)),
                child: Padding(
                  padding: const EdgeInsets.all(Gaps.lg),
                  child: QrImageView(data: link, size: 220, backgroundColor: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: Gaps.lg),
            SelectableText(
              school.code,
              textAlign: TextAlign.center,
              style: context.textStyles.headlineMedium?.copyWith(letterSpacing: 6),
            ),
            const SizedBox(height: Gaps.xl),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: school.code));
                      if (context.mounted) showSnack(context, 'Kode sekolah disalin.');
                    },
                    icon: const Icon(Icons.copy_rounded),
                    label: const Text('Salin kode'),
                  ),
                ),
                const SizedBox(width: Gaps.md),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => SharePlus.instance.share(ShareParams(
                      subject: 'Kode MANDU ${school.name}',
                      text: 'Gabung ke MANDU ${school.name} dengan kode ${school.code}.\n$link',
                    )),
                    icon: const Icon(Icons.share_rounded),
                    label: const Text('Bagikan'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
