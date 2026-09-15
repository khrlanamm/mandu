import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../auth/application/session_controller.dart';
import '../../lapor/presentation/widgets/ticket_widgets.dart';
import '../data/notification_repository.dart';
import '../domain/app_notification.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(currentAccountProvider.select((account) => account?.uid));
    final inbox = ref.watch(inboxProvider);
    final unread = inbox.value?.where((notification) => !notification.read).toList() ?? const [];
    final repository = ref.read(notificationRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        actions: [
          if (unread.isNotEmpty && uid != null)
            TextButton(
              onPressed: () => runGuarded(context, () => repository.markAllRead(uid, unread.map((item) => item.id))),
              child: const Text('Tandai semua dibaca'),
            ),
        ],
      ),
      body: AsyncValueView(
        value: inbox,
        onRetry: () => ref.invalidate(inboxProvider),
        data: (notifications) {
          if (notifications.isEmpty) {
            return const EmptyState(
              icon: Icons.notifications_none_rounded,
              title: 'Belum ada notifikasi',
              message: 'Kabar tentang laporan, tugas, dan pengingat akan muncul di sini.',
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: Gaps.sm),
            itemCount: notifications.length,
            separatorBuilder: (_, _) => const Divider(height: 1, indent: 72),
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return ContentWidth(
                child: Dismissible(
                  key: ValueKey(notification.id),
                  direction: DismissDirection.endToStart,
                  background: ColoredBox(
                    color: context.palette.danger.container,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: Gaps.xl),
                        child: Icon(Icons.delete_outline_rounded, color: context.palette.danger.main),
                      ),
                    ),
                  ),
                  onDismissed: (_) {
                    if (uid != null) repository.delete(uid, notification.id);
                  },
                  child: _NotificationTile(
                    notification: notification,
                    onTap: () {
                      if (uid != null && !notification.read) repository.markRead(uid, notification.id);
                      if (notification.route.startsWith('/')) context.push(notification.route);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification, required this.onTap});

  final AppNotification notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final tone = notification.urgent
        ? palette.danger
        : switch (notification.type) {
            'tiket_baru' || 'tiket_unit' => palette.lapor,
            'tiket_pengingat' => palette.warning,
            _ => palette.info,
          };
    final icon = notification.urgent
        ? Icons.warning_amber_rounded
        : switch (notification.type) {
            'tiket_baru' => Icons.campaign_rounded,
            'tiket_unit' => Icons.assignment_ind_rounded,
            'tiket_pengingat' => Icons.alarm_rounded,
            'tiket_dilengkapi' => Icons.edit_note_rounded,
            _ => Icons.update_rounded,
          };

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: Gaps.lg, vertical: Gaps.xs),
      leading: CircleAvatar(backgroundColor: tone.container, child: Icon(icon, color: tone.main, size: 22)),
      title: Text(
        notification.title,
        style: context.textStyles.titleSmall?.copyWith(fontWeight: notification.read ? FontWeight.w500 : FontWeight.w700),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(notification.body, maxLines: 2, overflow: TextOverflow.ellipsis),
          if (notification.createdAt != null)
            Text(
              formatRelative(notification.createdAt!),
              style: context.textStyles.labelSmall?.copyWith(color: context.colors.onSurfaceVariant),
            ),
        ],
      ),
      trailing: notification.read
          ? null
          : Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: context.colors.primary, shape: BoxShape.circle),
            ),
    );
  }
}
