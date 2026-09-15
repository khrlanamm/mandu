import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../assets.dart';
import 'formatters.dart';

void showSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

String describeError(Object error) =>
    error is FirebaseException ? (error.message ?? error.code) : error.toString();

Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Ya',
  String cancelLabel = 'Tidak',
  bool destructive = false,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      icon: Image.asset(AppAssets.appLogo, width: 48, height: 48),
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(cancelLabel),
        ),
        FilledButton(
          style: destructive
              ? FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error)
              : null,
          onPressed: () => Navigator.pop(context, true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}

Future<void> openWhatsApp(BuildContext context, String number) async {
  var opened = false;
  try {
    opened = await launchUrl(whatsAppUri(number), mode: LaunchMode.externalApplication);
  } catch (e) {
    debugPrint('Gagal membuka WhatsApp: $e');
  }
  if (!opened && context.mounted) {
    showSnack(context, 'WhatsApp tidak dapat dibuka.');
  }
}
