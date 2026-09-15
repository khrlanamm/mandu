import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../../core/errors.dart';
import '../../auth/application/session_controller.dart';
import '../data/care_repository.dart';
import 'widgets/care_widgets.dart';

class StartCurhatScreen extends ConsumerStatefulWidget {
  const StartCurhatScreen({super.key});

  @override
  ConsumerState<StartCurhatScreen> createState() => _StartCurhatScreenState();
}

class _StartCurhatScreenState extends ConsumerState<StartCurhatScreen> {
  final _formKey = GlobalKey<FormState>();
  final _alias = TextEditingController();
  final _topic = TextEditingController();
  final _message = TextEditingController();
  String? _counselorUid;
  bool _useAlias = false;
  bool _busy = false;

  @override
  void dispose() {
    _alias.dispose();
    _topic.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _start(String schoolId) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _busy = true);
    try {
      final conversationId = await ref.read(careRepositoryProvider).startConversation(
            schoolId: schoolId,
            counselorUid: _counselorUid,
            alias: _useAlias ? _alias.text : null,
            topic: _topic.text,
            message: _message.text,
          );
      if (mounted) context.go(Routes.studentConversation(conversationId));
    } catch (error) {
      if (!mounted) return;
      setState(() => _busy = false);
      showSnack(context, describeError(error), error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final schoolId = ref.watch(currentAccountProvider)?.schoolId;
    final counselors = schoolId == null ? null : ref.watch(counselorListProvider(schoolId));
    final tone = context.palette.curhat;
    final muted = context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant);

    return Scaffold(
      appBar: AppBar(title: const Text('Mulai curhat')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(Gaps.xl, Gaps.sm, Gaps.xl, Gaps.xxl),
          children: [
            ContentWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Mau cerita ke siapa?', style: context.textStyles.titleMedium),
                  const SizedBox(height: Gaps.md),
                  if (counselors == null)
                    const LoadingView()
                  else
                    AsyncValueView(
                      value: counselors,
                      loading: const Padding(padding: EdgeInsets.all(Gaps.lg), child: LinearProgressIndicator()),
                      onRetry: () => ref.invalidate(counselorListProvider(schoolId!)),
                      data: (list) => Column(
                        children: [
                          _CounselorOption(
                            name: 'Siapa saja yang tersedia',
                            description: 'Guru BK pertama yang membaca akan menemanimu',
                            selected: _counselorUid == null,
                            onTap: _busy ? null : () => setState(() => _counselorUid = null),
                          ),
                          for (final counselor in list)
                            _CounselorOption(
                              name: counselor.name,
                              description: 'Guru BK',
                              selected: _counselorUid == counselor.uid,
                              onTap: _busy ? null : () => setState(() => _counselorUid = counselor.uid),
                            ),
                        ],
                      ),
                    ),
                  const SizedBox(height: Gaps.xl),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    value: _useAlias,
                    onChanged: _busy ? null : (value) => setState(() => _useAlias = value),
                    title: const Text('Pakai nama samaran'),
                    subtitle: const Text('Guru BK tidak melihat nama aslimu sampai kamu membukanya sendiri.'),
                  ),
                  if (_useAlias)
                    TextFormField(
                      controller: _alias,
                      enabled: !_busy,
                      maxLength: 40,
                      decoration: const InputDecoration(labelText: 'Nama samaran', hintText: 'Contoh: Bunga'),
                      validator: (value) => !_useAlias || (value ?? '').trim().length >= 2 ? null : 'Minimal 2 karakter.',
                    ),
                  const SizedBox(height: Gaps.sm),
                  TextFormField(
                    controller: _topic,
                    enabled: !_busy,
                    maxLength: 60,
                    decoration: const InputDecoration(labelText: 'Topik (opsional)', hintText: 'Contoh: Pertemanan, keluarga, belajar'),
                  ),
                  const SizedBox(height: Gaps.sm),
                  TextFormField(
                    controller: _message,
                    enabled: !_busy,
                    minLines: 4,
                    maxLines: 10,
                    maxLength: 2000,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Ceritakan sedikit untuk memulai',
                      alignLabelWithHint: true,
                      hintText: 'Tulis sebisamu. Tidak harus panjang.',
                    ),
                    validator: (value) => (value ?? '').trim().isEmpty ? 'Tulis pesan pertamamu.' : null,
                  ),
                  const SizedBox(height: Gaps.sm),
                  Text('Percakapan ini tidak bisa dibaca guru atau staf lain, termasuk admin sekolah.', style: muted),
                  const SizedBox(height: Gaps.lg),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(backgroundColor: tone.main, foregroundColor: tone.onMain),
                    onPressed: _busy || schoolId == null ? null : () => _start(schoolId),
                    icon: _busy ? const ButtonSpinner(color: Colors.white) : const Icon(Icons.send_rounded),
                    label: const Text('Mulai percakapan'),
                  ),
                  const SizedBox(height: Gaps.lg),
                  const EmergencyContactsCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CounselorOption extends StatelessWidget {
  const _CounselorOption({required this.name, required this.description, required this.selected, required this.onTap});

  final String name;
  final String description;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tone = context.palette.curhat;
    return Padding(
      padding: const EdgeInsets.only(bottom: Gaps.sm),
      child: Material(
        color: selected ? tone.container : context.colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.md),
          side: BorderSide(color: selected ? tone.main : context.colors.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            backgroundColor: tone.container,
            child: Icon(selected ? Icons.check_rounded : Icons.person_outline_rounded, color: tone.main),
          ),
          title: Text(name),
          subtitle: Text(description),
        ),
      ),
    );
  }
}
