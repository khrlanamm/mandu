import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../../core/errors.dart';
import '../../../core/files/pending_attachment.dart';
import '../../auth/application/session_controller.dart';
import '../../lapor/presentation/widgets/ticket_widgets.dart';
import '../data/care_repository.dart';
import '../domain/care.dart';
import 'widgets/care_widgets.dart';

enum _ChatMenu { reveal, caseNotes, meeting, emergency, close }

/// Layar percakapan Curhat, dipakai siswa dan konselor.
class ConversationScreen extends ConsumerStatefulWidget {
  const ConversationScreen({super.key, required this.conversationId, required this.asCounselor});

  final String conversationId;
  final bool asCounselor;

  @override
  ConsumerState<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends ConsumerState<ConversationScreen> {
  final _input = TextEditingController();
  bool _sending = false;
  bool _readMarked = false;

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  CareRepository get _repository => ref.read(careRepositoryProvider);

  void _markRead(Conversation conversation) {
    final unread = widget.asCounselor ? conversation.unreadCounselor : conversation.unreadStudent;
    if (unread == 0 || _readMarked) return;
    _readMarked = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _repository
          .markRead(schoolId: conversation.schoolId, conversationId: conversation.id, asStudent: !widget.asCounselor)
          .catchError((Object _) {});
    });
  }

  Future<void> _send(Conversation conversation, String uid) async {
    final text = _input.text.trim();
    if (text.isEmpty || _sending) return;
    setState(() => _sending = true);
    _input.clear();
    try {
      await _repository.sendMessage(
        schoolId: conversation.schoolId,
        conversationId: conversation.id,
        uid: uid,
        role: widget.asCounselor ? MessageRole.konselor : MessageRole.siswa,
        text: text,
      );
      _readMarked = false;
    } catch (error) {
      if (mounted) {
        _input.text = text;
        showSnack(context, describeError(error), error: true);
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _sendImage(Conversation conversation, String uid) async {
    try {
      final picked = await pickAttachmentFiles(remaining: 1);
      if (picked.isEmpty) return;
      final file = picked.first;
      if (!file.isImage) {
        if (mounted) showSnack(context, 'Hanya gambar yang bisa dikirim di percakapan.', error: true);
        return;
      }
      setState(() => _sending = true);
      final path = await _repository.uploadChatImage(
        schoolId: conversation.schoolId,
        conversationId: conversation.id,
        file: file,
      );
      await _repository.sendMessage(
        schoolId: conversation.schoolId,
        conversationId: conversation.id,
        uid: uid,
        role: widget.asCounselor ? MessageRole.konselor : MessageRole.siswa,
        imagePath: path,
      );
    } catch (error) {
      if (mounted) showSnack(context, describeError(error), error: true);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _handleMenu(_ChatMenu action, Conversation conversation) async {
    switch (action) {
      case _ChatMenu.reveal:
        final confirmed = await confirmAction(
          context,
          title: 'Buka identitasmu?',
          message: 'Guru BK akan melihat nama asli dan kelasmu. Tindakan ini tidak bisa dibatalkan.',
          confirmLabel: 'Buka identitas',
        );
        if (confirmed && mounted) {
          await runGuarded(
            context,
            () => _repository.revealIdentity(schoolId: conversation.schoolId, conversationId: conversation.id),
            successMessage: 'Identitasmu dibuka untuk guru BK.',
          );
        }
      case _ChatMenu.close:
        final confirmed = await confirmAction(
          context,
          title: 'Tutup percakapan?',
          message: 'Percakapan tidak bisa dilanjutkan setelah ditutup, tetapi riwayatnya tetap tersimpan.',
          confirmLabel: 'Tutup',
          destructive: true,
        );
        if (confirmed && mounted) {
          await runGuarded(
            context,
            () => _repository.closeConversation(schoolId: conversation.schoolId, conversationId: conversation.id),
            successMessage: 'Percakapan ditutup.',
          );
        }
      case _ChatMenu.caseNotes:
        await showActionSheet(context, (_) => _CaseNotesSheet(conversation: conversation));
      case _ChatMenu.meeting:
        await showActionSheet(context, (_) => _MeetingSheet(conversation: conversation));
      case _ChatMenu.emergency:
        await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Kontak bantuan darurat'),
            content: const EmergencyContactsCard(),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup'))],
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final account = ref.watch(currentAccountProvider);
    final schoolId = account?.schoolId;
    if (account == null || schoolId == null) return const Scaffold(body: LoadingView());

    return Scaffold(
      appBar: AppBar(
        leading: context.canPop()
            ? null
            : IconButton(
                tooltip: 'Tutup',
                icon: const Icon(Icons.close_rounded),
                onPressed: () => context.go(widget.asCounselor ? Routes.staffCare : Routes.studentCurhat),
              ),
        title: _Title(schoolId: schoolId, conversationId: widget.conversationId, asCounselor: widget.asCounselor),
        actions: [
          Consumer(
            builder: (context, ref, _) {
              final conversation = ref.watch(conversationProvider(schoolId, widget.conversationId)).value;
              if (conversation == null) return const SizedBox.shrink();
              final isAssigned = conversation.counselorUid == account.uid;
              return PopupMenuButton<_ChatMenu>(
                tooltip: 'Menu percakapan',
                onSelected: (action) => _handleMenu(action, conversation),
                itemBuilder: (context) => [
                  if (!widget.asCounselor && conversation.usesAlias && !conversation.identityRevealed)
                    const PopupMenuItem(
                      value: _ChatMenu.reveal,
                      child: ListTile(leading: Icon(Icons.badge_outlined), title: Text('Buka identitasku')),
                    ),
                  if (widget.asCounselor && isAssigned) ...[
                    const PopupMenuItem(
                      value: _ChatMenu.caseNotes,
                      child: ListTile(leading: Icon(Icons.assignment_outlined), title: Text('Catatan kasus')),
                    ),
                    if (conversation.isOpen)
                      const PopupMenuItem(
                        value: _ChatMenu.meeting,
                        child: ListTile(leading: Icon(Icons.event_available_outlined), title: Text('Usulkan jadwal temu')),
                      ),
                  ],
                  if (!widget.asCounselor)
                    const PopupMenuItem(
                      value: _ChatMenu.emergency,
                      child: ListTile(leading: Icon(Icons.health_and_safety_outlined), title: Text('Kontak darurat')),
                    ),
                  if (conversation.isOpen && (isAssigned || conversation.studentUid == account.uid))
                    const PopupMenuItem(
                      value: _ChatMenu.close,
                      child: ListTile(leading: Icon(Icons.done_all_rounded), title: Text('Tutup percakapan')),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: AsyncValueView(
        value: ref.watch(conversationProvider(schoolId, widget.conversationId)),
        onRetry: () => ref.invalidate(conversationProvider(schoolId, widget.conversationId)),
        data: (conversation) {
          if (conversation == null) {
            return const EmptyState(icon: Icons.search_off_rounded, title: 'Percakapan tidak ditemukan');
          }
          _markRead(conversation);
          final messages = ref.watch(conversationMessagesProvider(schoolId, widget.conversationId));
          final canWrite = conversation.isOpen &&
              (widget.asCounselor ? conversation.counselorUid == account.uid : conversation.studentUid == account.uid);

          return Column(
            children: [
              if (conversation.usesAlias && widget.asCounselor && !conversation.identityRevealed)
                _Banner(
                  icon: Icons.masks_outlined,
                  message: 'Siswa memakai nama samaran. Identitas akan terlihat bila siswa membukanya sendiri.',
                  tone: context.palette.neutral,
                ),
              if (conversation.status == ConversationStatus.menunggu)
                _Banner(
                  icon: Icons.hourglass_top_rounded,
                  message: widget.asCounselor
                      ? 'Percakapan ini belum diambil konselor mana pun.'
                      : 'Menunggu guru BK bergabung. Kamu tetap bisa menulis di sini.',
                  tone: context.palette.warning,
                  action: widget.asCounselor
                      ? FilledButton(
                          onPressed: () => runGuarded(
                            context,
                            () => _repository.claimConversation(
                              schoolId: conversation.schoolId,
                              conversationId: conversation.id,
                            ),
                            successMessage: 'Percakapan diambil.',
                          ),
                          child: const Text('Ambil'),
                        )
                      : null,
                ),
              if (conversation.meeting != null) _MeetingCard(conversation: conversation, asCounselor: widget.asCounselor),
              Expanded(
                child: AsyncValueView(
                  value: messages,
                  data: (items) => ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(vertical: Gaps.md),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final message = items[items.length - 1 - index];
                      return MessageBubble(
                        message: message,
                        mine: message.senderUid == account.uid,
                        imageBuilder: (path) => _ChatImage(path: path),
                      );
                    },
                  ),
                ),
              ),
              if (canWrite)
                _Composer(
                  controller: _input,
                  busy: _sending,
                  onSend: () => _send(conversation, account.uid),
                  onAttach: () => _sendImage(conversation, account.uid),
                )
              else
                _ClosedBar(conversation: conversation, asCounselor: widget.asCounselor),
            ],
          );
        },
      ),
    );
  }
}

class _Title extends ConsumerWidget {
  const _Title({required this.schoolId, required this.conversationId, required this.asCounselor});

  final String schoolId;
  final String conversationId;
  final bool asCounselor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversation = ref.watch(conversationProvider(schoolId, conversationId)).value;
    final title = conversation == null
        ? 'Curhat'
        : asCounselor
            ? conversation.displayName
            : conversation.counselorName ?? 'Menunggu guru BK';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: context.textStyles.titleMedium),
        if (conversation != null)
          Text(
            [conversation.status.label, ?conversation.topic].join(' · '),
            style: context.textStyles.labelSmall?.copyWith(color: context.colors.onSurfaceVariant),
          ),
      ],
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.icon, required this.message, required this.tone, this.action});

  final IconData icon;
  final String message;
  final ToneColors tone;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: tone.container,
      padding: const EdgeInsets.symmetric(horizontal: Gaps.lg, vertical: Gaps.sm),
      child: Row(
        children: [
          Icon(icon, size: 18, color: tone.main),
          const SizedBox(width: Gaps.sm),
          Expanded(child: Text(message, style: context.textStyles.bodySmall?.copyWith(color: tone.onContainer))),
          ?action,
        ],
      ),
    );
  }
}

class _MeetingCard extends ConsumerWidget {
  const _MeetingCard({required this.conversation, required this.asCounselor});

  final Conversation conversation;
  final bool asCounselor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meeting = conversation.meeting!;
    final palette = context.palette;
    final when = meeting.at == null ? '-' : DateFormat('EEEE, d MMM yyyy · HH.mm', 'id_ID').format(meeting.at!);
    final tone = switch (meeting.status) {
      'disetujui' => palette.success,
      'ditolak' => palette.neutral,
      _ => palette.info,
    };
    return Container(
      width: double.infinity,
      color: tone.container,
      padding: const EdgeInsets.all(Gaps.md),
      child: Row(
        children: [
          Icon(Icons.event_available_rounded, color: tone.main),
          const SizedBox(width: Gaps.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Jadwal temu ${meeting.status}', style: context.textStyles.titleSmall?.copyWith(color: tone.onContainer)),
                Text('$when WIB · ${meeting.place}', style: context.textStyles.bodySmall?.copyWith(color: tone.onContainer)),
              ],
            ),
          ),
          if (!asCounselor && meeting.status == 'diusulkan') ...[
            TextButton(
              onPressed: () => runGuarded(
                context,
                () => ref.read(careRepositoryProvider).respondMeeting(
                      schoolId: conversation.schoolId,
                      conversationId: conversation.id,
                      accept: false,
                    ),
              ),
              child: const Text('Belum bisa'),
            ),
            FilledButton(
              onPressed: () => runGuarded(
                context,
                () => ref.read(careRepositoryProvider).respondMeeting(
                      schoolId: conversation.schoolId,
                      conversationId: conversation.id,
                      accept: true,
                    ),
                successMessage: 'Jadwal disetujui.',
              ),
              child: const Text('Bisa'),
            ),
          ],
        ],
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({required this.controller, required this.busy, required this.onSend, required this.onAttach});

  final TextEditingController controller;
  final bool busy;
  final VoidCallback onSend;
  final VoidCallback onAttach;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.surface,
          border: Border(top: BorderSide(color: context.colors.outlineVariant)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Gaps.sm, Gaps.sm, Gaps.sm, Gaps.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                tooltip: 'Kirim gambar',
                onPressed: busy ? null : onAttach,
                icon: const Icon(Icons.image_outlined),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  enabled: !busy,
                  minLines: 1,
                  maxLines: 5,
                  maxLength: 4000,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    hintText: 'Tulis pesan...',
                    counterText: '',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: Gaps.lg, vertical: Gaps.md),
                  ),
                  onSubmitted: (_) => onSend(),
                ),
              ),
              const SizedBox(width: Gaps.xs),
              IconButton.filled(
                tooltip: 'Kirim',
                onPressed: busy ? null : onSend,
                icon: busy
                    ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.send_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClosedBar extends StatelessWidget {
  const _ClosedBar({required this.conversation, required this.asCounselor});

  final Conversation conversation;
  final bool asCounselor;

  @override
  Widget build(BuildContext context) {
    final message = conversation.status == ConversationStatus.selesai
        ? 'Percakapan sudah ditutup.'
        : asCounselor
            ? 'Ambil percakapan ini untuk bisa membalas.'
            : 'Kamu tidak dapat menulis di percakapan ini.';
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(Gaps.lg),
        child: Row(
          children: [
            Expanded(
              child: Text(
                message,
                style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
              ),
            ),
            if (!asCounselor && conversation.status == ConversationStatus.selesai)
              FilledButton.tonal(
                onPressed: () => context.go(Routes.studentCurhatStart),
                child: const Text('Curhat baru'),
              ),
          ],
        ),
      ),
    );
  }
}

class _ChatImage extends ConsumerWidget {
  const _ChatImage({required this.path});

  final String path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = ref.watch(chatImageUrlProvider(path)).value;
    if (url == null) {
      return Container(
        width: 200,
        height: 150,
        color: context.colors.surfaceContainerHigh,
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 260, maxWidth: 320),
      child: Image.network(url, fit: BoxFit.cover),
    );
  }
}

class _CaseNotesSheet extends ConsumerStatefulWidget {
  const _CaseNotesSheet({required this.conversation});

  final Conversation conversation;

  @override
  ConsumerState<_CaseNotesSheet> createState() => _CaseNotesSheetState();
}

class _CaseNotesSheetState extends ConsumerState<_CaseNotesSheet> with ActionSheetState {
  final _text = TextEditingController();
  String _risk = 'tidak_ada';

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _save() {
    if (_text.text.trim().length < 3) return fail('Tuliskan catatan minimal 3 karakter.');
    final account = ref.read(currentAccountProvider);
    submit(
      () => ref.read(careRepositoryProvider).addCaseNote(
            schoolId: widget.conversation.schoolId,
            conversationId: widget.conversation.id,
            text: _text.text,
            riskLevel: _risk,
            authorName: account?.displayName ?? 'Konselor',
          ),
      successMessage: 'Catatan kasus disimpan.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final notes = ref.watch(caseNotesProvider(widget.conversation.schoolId, widget.conversation.id)).value ?? const [];
    return ActionSheet(
      title: 'Catatan kasus',
      description: 'Hanya terlihat olehmu sebagai konselor yang menangani. Siswa tidak pernah melihat catatan ini.',
      submitLabel: 'Simpan catatan',
      busy: busy,
      error: error,
      onSubmit: _save,
      children: [
        TextField(
          controller: _text,
          enabled: !busy,
          minLines: 3,
          maxLines: 6,
          maxLength: 4000,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(labelText: 'Catatan baru', alignLabelWithHint: true),
        ),
        const SizedBox(height: Gaps.sm),
        Wrap(
          spacing: Gaps.sm,
          children: [
            for (final entry in kRiskLevels.entries)
              ChoiceChip(
                label: Text(entry.value),
                selected: _risk == entry.key,
                onSelected: busy ? null : (_) => setState(() => _risk = entry.key),
              ),
          ],
        ),
        if (notes.isNotEmpty) ...[
          const SizedBox(height: Gaps.lg),
          const SectionHeader(title: 'Riwayat catatan'),
          for (final note in notes)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(note.text),
              subtitle: Text(
                [
                  kRiskLevels[note.riskLevel] ?? note.riskLevel,
                  note.authorName,
                  if (note.createdAt != null) formatDateTime(note.createdAt!),
                ].join(' · '),
              ),
            ),
        ],
      ],
    );
  }
}

class _MeetingSheet extends ConsumerStatefulWidget {
  const _MeetingSheet({required this.conversation});

  final Conversation conversation;

  @override
  ConsumerState<_MeetingSheet> createState() => _MeetingSheetState();
}

class _MeetingSheetState extends ConsumerState<_MeetingSheet> with ActionSheetState {
  final _place = TextEditingController(text: 'Ruang BK');
  DateTime? _date;
  TimeOfDay? _time;

  @override
  void dispose() {
    _place.dispose();
    super.dispose();
  }

  void _save() {
    if (_date == null || _time == null) return fail('Pilih tanggal dan jam pertemuan.');
    if (_place.text.trim().length < 2) return fail('Isi tempat pertemuan.');
    final at = DateTime(_date!.year, _date!.month, _date!.day, _time!.hour, _time!.minute);
    if (at.isBefore(DateTime.now())) return fail('Jadwal harus di waktu yang akan datang.');
    submit(
      () => ref.read(careRepositoryProvider).proposeMeeting(
            schoolId: widget.conversation.schoolId,
            conversationId: widget.conversation.id,
            at: at,
            place: _place.text,
          ),
      successMessage: 'Usulan jadwal dikirim ke siswa.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return ActionSheet(
      title: 'Usulkan jadwal temu',
      description: 'Siswa dapat menyetujui atau menolak usulan ini.',
      submitLabel: 'Kirim usulan',
      busy: busy,
      error: error,
      onSubmit: _save,
      children: [
        Wrap(
          spacing: Gaps.sm,
          runSpacing: Gaps.sm,
          children: [
            OutlinedButton.icon(
              onPressed: busy
                  ? null
                  : () async {
                      final now = DateTime.now();
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _date ?? now.add(const Duration(days: 1)),
                        firstDate: now,
                        lastDate: now.add(const Duration(days: 60)),
                      );
                      if (picked != null) setState(() => _date = picked);
                    },
              icon: const Icon(Icons.event_outlined),
              label: Text(_date == null ? 'Pilih tanggal' : DateFormat('d MMM yyyy', 'id_ID').format(_date!)),
            ),
            OutlinedButton.icon(
              onPressed: busy
                  ? null
                  : () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: _time ?? const TimeOfDay(hour: 10, minute: 0),
                      );
                      if (picked != null) setState(() => _time = picked);
                    },
              icon: const Icon(Icons.schedule_outlined),
              label: Text(_time == null ? 'Pilih jam' : _time!.format(context)),
            ),
          ],
        ),
        const SizedBox(height: Gaps.lg),
        TextField(
          controller: _place,
          enabled: !busy,
          maxLength: 120,
          decoration: const InputDecoration(labelText: 'Tempat', prefixIcon: Icon(Icons.place_outlined)),
        ),
      ],
    );
  }
}
