import 'package:flutter/material.dart';

import '../../../core/design/widgets/states.dart';

/// Tab yang isinya dibangun di tahap berikutnya.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.title, required this.icon, required this.message});

  const PlaceholderScreen.activity({super.key})
      : title = 'Aktivitas',
        icon = Icons.receipt_long_rounded,
        message = 'Laporan, aspirasi, dan permintaan bantuanmu akan tampil di sini.';

  const PlaceholderScreen.notifications({super.key})
      : title = 'Notifikasi',
        icon = Icons.notifications_none_rounded,
        message = 'Kabar terbaru tentang laporan dan aspirasimu akan muncul di sini.';

  const PlaceholderScreen.tasks({super.key})
      : title = 'Tugas',
        icon = Icons.task_alt_rounded,
        message = 'Laporan yang perlu kamu tangani akan muncul di sini.';

  final String title;
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: EmptyState(icon: icon, title: 'Belum ada apa-apa', message: message),
    );
  }
}
