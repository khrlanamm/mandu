import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../members/data/membership_repository.dart';
import '../../members/domain/member.dart';

class MemberApprovalsScreen extends ConsumerStatefulWidget {
  const MemberApprovalsScreen({super.key, required this.schoolId});

  final String schoolId;

  @override
  ConsumerState<MemberApprovalsScreen> createState() => _MemberApprovalsScreenState();
}

class _MemberApprovalsScreenState extends ConsumerState<MemberApprovalsScreen> {
  final _selected = <String>{};
  bool _busy = false;

  String _details(Member member) => [
        if (member.kelas != null) 'Kelas ${member.kelas}',
        if (member.nisn != null) 'NISN ${member.nisn}',
        if (member.email != null) member.email!,
        if (member.createdAt != null) 'diajukan ${timeago.format(member.createdAt!, locale: 'id')}',
      ].join(' · ');

  Future<void> _review(bool approve) async {
    final uids = _selected.toList();
    String? reason;
    if (!approve) {
      reason = await showDialog<String>(context: context, builder: (_) => const _RejectDialog());
      if (reason == null) return;
    }
    if (!mounted) return;
    setState(() => _busy = true);
    final result = await runGuarded(
      context,
      () => ref.read(membershipRepositoryProvider).review(
            schoolId: widget.schoolId,
            uids: uids,
            approve: approve,
            reason: reason,
          ),
    );
    if (!mounted) return;
    setState(() {
      _busy = false;
      if (result != null) _selected.clear();
    });
    if (result != null) {
      showSnack(context, approve ? '${result.updated.length} siswa disetujui.' : '${result.updated.length} permintaan ditolak.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final pending = ref.watch(schoolMembersProvider(widget.schoolId, status: MemberStatus.pending));
    final count = _selected.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Persetujuan siswa')),
      body: AsyncValueView(
        value: pending,
        data: (members) {
          if (members.isEmpty) {
            return const EmptyState(
              icon: Icons.how_to_reg_rounded,
              title: 'Tidak ada permintaan',
              message: 'Siswa yang bergabung memakai kode sekolah akan muncul di sini.',
            );
          }
          final allSelected = members.every((member) => _selected.contains(member.uid));
          return ListView(
            padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.sm, Gaps.lg, Gaps.xxxl * 2),
            children: [
              ContentWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text('${members.length} menunggu persetujuan', style: context.textStyles.titleSmall)),
                        TextButton(
                          onPressed: _busy
                              ? null
                              : () => setState(() {
                                    if (allSelected) {
                                      _selected.clear();
                                    } else {
                                      _selected.addAll(members.map((member) => member.uid));
                                    }
                                  }),
                          child: Text(allSelected ? 'Batal pilih' : 'Pilih semua'),
                        ),
                      ],
                    ),
                    const InfoBanner(
                      icon: Icons.fact_check_outlined,
                      message: 'Pastikan nama dan kelas sesuai data sekolah sebelum menyetujui.',
                    ),
                    const SizedBox(height: Gaps.md),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          for (final (index, member) in members.indexed) ...[
                            if (index > 0) const Divider(height: 1),
                            CheckboxListTile(
                              value: _selected.contains(member.uid),
                              onChanged: _busy
                                  ? null
                                  : (checked) => setState(() {
                                        if (checked ?? false) {
                                          _selected.add(member.uid);
                                        } else {
                                          _selected.remove(member.uid);
                                        }
                                      }),
                              secondary: CircleAvatar(child: Text(member.initials)),
                              title: Text(member.displayName),
                              subtitle: Text(_details(member)),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: count == 0
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(Gaps.lg),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _busy ? null : () => _review(false),
                        style: OutlinedButton.styleFrom(foregroundColor: context.palette.danger.main),
                        child: Text('Tolak ($count)'),
                      ),
                    ),
                    const SizedBox(width: Gaps.md),
                    Expanded(
                      child: FilledButton(
                        onPressed: _busy ? null : () => _review(true),
                        child: _busy ? const ButtonSpinner(color: Colors.white) : Text('Setujui ($count)'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _RejectDialog extends StatefulWidget {
  const _RejectDialog();

  @override
  State<_RejectDialog> createState() => _RejectDialogState();
}

class _RejectDialogState extends State<_RejectDialog> {
  final _controller = TextEditingController(text: 'Tidak dapat diverifikasi sebagai siswa sekolah ini.');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tolak permintaan'),
      content: TextField(
        controller: _controller,
        maxLength: 200,
        maxLines: 3,
        decoration: const InputDecoration(labelText: 'Alasan (dilihat siswa)'),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
        FilledButton(
          onPressed: () => Navigator.pop(context, _controller.text.trim()),
          style: FilledButton.styleFrom(
            backgroundColor: context.palette.danger.main,
            foregroundColor: context.palette.danger.onMain,
            minimumSize: const Size(64, 44),
          ),
          child: const Text('Tolak'),
        ),
      ],
    );
  }
}
