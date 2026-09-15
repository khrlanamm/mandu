import 'package:flutter/material.dart';

import '../../errors.dart';
import '../palette.dart';

void showSnack(BuildContext context, String message, {bool error = false}) {
  final palette = context.palette;
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(message, style: error ? TextStyle(color: palette.danger.onMain) : null),
      backgroundColor: error ? palette.danger.main : null,
    ));
}

Future<bool> confirmAction(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  bool destructive = false,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Batal')),
        FilledButton(
          style: destructive
              ? FilledButton.styleFrom(
                  backgroundColor: context.palette.danger.main,
                  foregroundColor: context.palette.danger.onMain,
                  minimumSize: const Size(64, 44),
                )
              : FilledButton.styleFrom(minimumSize: const Size(64, 44)),
          onPressed: () => Navigator.pop(context, true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}

/// Jalankan aksi dan tampilkan pesan error standar bila gagal. Mengembalikan null bila gagal.
Future<T?> runGuarded<T>(BuildContext context, Future<T> Function() action, {String? successMessage}) async {
  try {
    final result = await action();
    if (successMessage != null && context.mounted) showSnack(context, successMessage);
    return result;
  } catch (error) {
    if (context.mounted) showSnack(context, describeError(error), error: true);
    return null;
  }
}

/// Indikator kecil untuk tombol yang sedang memproses.
class ButtonSpinner extends StatelessWidget {
  const ButtonSpinner({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 22,
      child: CircularProgressIndicator(strokeWidth: 2.5, color: color),
    );
  }
}
