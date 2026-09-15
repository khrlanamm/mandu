import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/design/palette.dart';
import '../../../../core/design/tokens.dart';
import '../../../../core/design/widgets/feedback.dart';

/// Tampilkan rahasia sekali pakai (password awal, tautan atur password) dengan tombol salin.
Future<void> showSecretDialog(
  BuildContext context, {
  required String title,
  required String secret,
  required String note,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(note),
          const SizedBox(height: Gaps.lg),
          DecoratedBox(
            decoration: BoxDecoration(
              color: dialogContext.colors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(Radii.md),
            ),
            child: Padding(
              padding: const EdgeInsets.all(Gaps.md),
              child: SelectableText(
                secret,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, letterSpacing: 0.8),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton.icon(
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: secret));
            if (dialogContext.mounted) showSnack(dialogContext, 'Disalin ke papan klip.');
          },
          icon: const Icon(Icons.copy_rounded),
          label: const Text('Salin'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(dialogContext),
          style: FilledButton.styleFrom(minimumSize: const Size(64, 44)),
          child: const Text('Selesai'),
        ),
      ],
    ),
  );
}
