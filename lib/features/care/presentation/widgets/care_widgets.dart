import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/design/palette.dart';
import '../../../../core/design/tokens.dart';
import '../../../../core/design/widgets/feedback.dart';
import '../../../../core/design/widgets/layout.dart';
import '../../../lapor/presentation/widgets/ticket_widgets.dart';
import '../../domain/care.dart';

extension HelpStatusStyle on HelpStatus {
  ToneColors tone(ManduPalette palette) => switch (this) {
        HelpStatus.menunggu => palette.warning,
        HelpStatus.ditangani => palette.curhat,
        HelpStatus.selesai => palette.success,
        HelpStatus.dibatalkan => palette.neutral,
      };

  IconData get icon => switch (this) {
        HelpStatus.menunggu => Icons.hourglass_top_rounded,
        HelpStatus.ditangani => Icons.volunteer_activism_rounded,
        HelpStatus.selesai => Icons.check_circle_rounded,
        HelpStatus.dibatalkan => Icons.cancel_outlined,
      };
}

extension HelpUrgencyStyle on HelpUrgency {
  ToneColors tone(ManduPalette palette) => switch (this) {
        HelpUrgency.biasa => palette.neutral,
        HelpUrgency.segera => palette.warning,
        HelpUrgency.darurat => palette.danger,
      };
}

extension ConversationStatusStyle on ConversationStatus {
  ToneColors tone(ManduPalette palette) => switch (this) {
        ConversationStatus.menunggu => palette.warning,
        ConversationStatus.aktif => palette.curhat,
        ConversationStatus.selesai => palette.neutral,
      };
}

class HelpRequestCard extends StatelessWidget {
  const HelpRequestCard({super.key, required this.request, required this.onTap, this.staffView = false});

  final HelpRequest request;
  final VoidCallback onTap;
  final bool staffView;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final muted = context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Gaps.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text(request.number, style: context.textStyles.labelMedium)),
                  StatusPill(label: request.status.label, tone: request.status.tone(palette), icon: request.status.icon),
                ],
              ),
              const SizedBox(height: Gaps.sm),
              Text(
                staffView ? '${request.student.name} · ${request.student.kelas ?? "-"}' : request.needLabels.first,
                style: context.textStyles.titleSmall,
              ),
              if (staffView) Text(request.needLabels.join(', '), style: muted, maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: Gaps.sm),
              Wrap(
                spacing: Gaps.sm,
                runSpacing: Gaps.xs,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  StatusPill(label: request.urgency.label, tone: request.urgency.tone(palette), icon: Icons.bolt_rounded),
                  StatusPill(label: request.contactMethod.label, tone: palette.neutral, icon: request.contactMethod.icon),
                  if (request.counselorName != null)
                    StatusPill(label: request.counselorName!, tone: palette.curhat, icon: Icons.person_outline_rounded),
                  if (request.createdAt != null) Text(formatRelative(request.createdAt!), style: muted),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConversationTile extends StatelessWidget {
  const ConversationTile({super.key, required this.conversation, required this.onTap, required this.asCounselor});

  final Conversation conversation;
  final VoidCallback onTap;
  final bool asCounselor;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final unread = asCounselor ? conversation.unreadCounselor : conversation.unreadStudent;
    final title = asCounselor ? conversation.displayName : (conversation.counselorName ?? 'Menunggu konselor');
    final last = conversation.lastMessage;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: Gaps.lg, vertical: Gaps.xs),
        leading: CircleAvatar(
          backgroundColor: palette.curhat.container,
          child: Icon(
            asCounselor && conversation.usesAlias ? Icons.masks_outlined : Icons.forum_rounded,
            color: palette.curhat.main,
          ),
        ),
        title: Row(
          children: [
            Expanded(child: Text(title, style: context.textStyles.titleSmall)),
            StatusPill(label: conversation.status.label, tone: conversation.status.tone(palette)),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (conversation.topic != null) Text('Topik: ${conversation.topic}'),
            if (last != null) Text(last.text, maxLines: 1, overflow: TextOverflow.ellipsis),
            if (conversation.updatedAt != null)
              Text(
                formatRelative(conversation.updatedAt!),
                style: context.textStyles.labelSmall?.copyWith(color: context.colors.onSurfaceVariant),
              ),
          ],
        ),
        trailing: unread > 0 ? Badge(label: Text('$unread')) : null,
      ),
    );
  }
}

/// Kontak bantuan darurat nasional.
class EmergencyContactsCard extends StatelessWidget {
  const EmergencyContactsCard({super.key});

  Future<void> _call(BuildContext context, String number) async {
    final called = await launchUrl(Uri.parse('tel:$number'));
    if (!called && context.mounted) showSnack(context, 'Tidak bisa membuka aplikasi telepon.', error: true);
  }

  @override
  Widget build(BuildContext context) {
    final tone = context.palette.danger;
    return Card(
      color: tone.container,
      child: Padding(
        padding: const EdgeInsets.all(Gaps.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.health_and_safety_rounded, color: tone.main),
                const SizedBox(width: Gaps.sm),
                Expanded(
                  child: Text(
                    'Butuh bantuan segera?',
                    style: context.textStyles.titleSmall?.copyWith(color: tone.onContainer),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Gaps.xs),
            Text(
              'MANDU bukan layanan darurat. Bila kamu atau temanmu dalam bahaya, hubungi nomor berikut atau temui guru terdekat.',
              style: context.textStyles.bodySmall?.copyWith(color: tone.onContainer),
            ),
            const SizedBox(height: Gaps.sm),
            Wrap(
              spacing: Gaps.sm,
              runSpacing: Gaps.sm,
              children: [
                for (final contact in kEmergencyContacts)
                  ActionChip(
                    avatar: Icon(Icons.call_rounded, size: 16, color: tone.main),
                    label: Text('${contact.name} · ${contact.number}'),
                    onPressed: () => _call(context, contact.number),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Gelembung pesan percakapan.
class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message, required this.mine, required this.imageBuilder});

  final ChatMessage message;
  final bool mine;
  final Widget Function(String path) imageBuilder;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    if (message.isSystem) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: Gaps.sm, horizontal: Gaps.xl),
        child: Text(
          message.text,
          textAlign: TextAlign.center,
          style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
        ),
      );
    }
    final background = mine ? palette.curhat.main : context.colors.surface;
    final foreground = mine ? palette.curhat.onMain : context.colors.onSurface;

    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 3, horizontal: Gaps.lg),
          padding: const EdgeInsets.symmetric(horizontal: Gaps.md, vertical: Gaps.sm),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(Radii.lg),
              topRight: const Radius.circular(Radii.lg),
              bottomLeft: Radius.circular(mine ? Radii.lg : Radii.sm),
              bottomRight: Radius.circular(mine ? Radii.sm : Radii.lg),
            ),
            border: mine ? null : Border.all(color: context.colors.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message.imagePath != null) ...[
                ClipRRect(borderRadius: BorderRadius.circular(Radii.md), child: imageBuilder(message.imagePath!)),
                if (message.text.isNotEmpty) const SizedBox(height: Gaps.sm),
              ],
              if (message.text.isNotEmpty)
                Text(message.text, style: context.textStyles.bodyMedium?.copyWith(color: foreground)),
              if (message.createdAt != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    TimeOfDay.fromDateTime(message.createdAt!).format(context),
                    style: context.textStyles.labelSmall?.copyWith(
                      color: mine ? foreground.withValues(alpha: 0.8) : context.colors.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
