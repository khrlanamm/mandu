import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/notification_repository.dart';

/// Tombol notifikasi dengan jumlah belum dibaca.
class NotificationBell extends ConsumerWidget {
  const NotificationBell({super.key, required this.route});

  final String route;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unread = ref.watch(unreadNotificationCountProvider);
    return IconButton(
      tooltip: unread == 0 ? 'Notifikasi' : 'Notifikasi, $unread belum dibaca',
      onPressed: () => context.push(route),
      icon: Badge(
        isLabelVisible: unread > 0,
        label: Text(unread > 99 ? '99+' : '$unread'),
        child: const Icon(Icons.notifications_none_rounded),
      ),
    );
  }
}
