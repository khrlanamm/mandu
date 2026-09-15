import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../../core/domain/roles.dart';
import '../../auth/application/session_controller.dart';
import '../../members/data/membership_repository.dart';
import '../../members/domain/member.dart';
import '../../schools/data/school_repository.dart';
import 'widgets/secret_dialog.dart';

class MemberDetailScreen extends ConsumerStatefulWidget {
  const MemberDetailScreen({super.key, required this.schoolId, required this.uid});

  final String schoolId;
  final String uid;

  @override
  ConsumerState<MemberDetailScreen> createState() => _MemberDetailScreenState();
}

class _MemberDetailScreenState extends ConsumerState<MemberDetailScreen> {
  final _kelas = TextEditingController();
  SchoolRole _role = SchoolRole.siswa;
  Set<String> _units = {};
  bool _canVerify = false;
  bool _initialized = false;
  bool _busy = false;

  @override
  void dispose() {
    _kelas.dispose();
    super.dispose();
  }

  void _initFrom(Member member) {
    if (_initialized) return;
    _initialized = true;
    _role = member.role;
    _units = {...member.units};
    _canVerify = member.canVerify;
    _kelas.text = member.kelas ?? '';
  }

  MembershipRepository get _repository => ref.read(membershipRepositoryProvider);

  Future<void> _save() async {
    setState(() => _busy = true);
    await runGuarded(
      context,
      () => _repository.updateMember(
        schoolId: widget.schoolId,
        uid: widget.uid,
        role: _role,
        units: _role.isStaff ? _units.toList() : const [],
        canVerify: _role.isStaff && _canVerify,
        kelas: _role == SchoolRole.siswa ? _kelas.text.trim() : null,
      ),
      successMessage: 'Perubahan disimpan.',
    );
    if (mounted) setState(() => _busy = false);
  }

  Future<void> _resetPassword(Member member) async {
    final confirmed = await confirmAction(
      context,
      title: 'Buat password baru?',
      message: 'Password lama ${member.displayName} tidak berlaku lagi dan siswa harus menggantinya saat masuk.',
      confirmLabel: 'Buat password',
    );
    if (!confirmed || !mounted) return;
    setState(() => _busy = true);
    final password = await runGuarded(
      context,
      () => _repository.resetStudentPassword(schoolId: widget.schoolId, uid: widget.uid),
    );
    if (!mounted) return;
    setState(() => _busy = false);
    if (password != null) {
      await showSecretDialog(
        context,
        title: 'Password baru',
        secret: password,
        note: 'Berikan password ini langsung kepada ${member.displayName}. Password hanya ditampilkan sekali.',
      );
    }
  }

  Future<void> _remove(Member member) async {
    final confirmed = await confirmAction(
      context,
      title: 'Keluarkan ${member.displayName}?',
      message: member.joinedVia == JoinMethod.nisn
          ? 'Akun NISN ini akan dinonaktifkan dan tidak bisa dipakai masuk.'
          : 'Anggota kehilangan akses ke sekolah ini, tetapi akunnya bisa bergabung ke sekolah lain.',
      confirmLabel: 'Keluarkan',
      destructive: true,
    );
    if (!confirmed || !mounted) return;
    setState(() => _busy = true);
    final ok = await runGuarded(context, () async {
      await _repository.removeMember(schoolId: widget.schoolId, uid: widget.uid);
      return true;
    }, successMessage: '${member.displayName} dikeluarkan dari sekolah.');
    if (!mounted) return;
    setState(() => _busy = false);
    if (ok == true) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final memberAsync = ref.watch(schoolMemberProvider(widget.schoolId, widget.uid));
    final units = ref.watch(schoolUnitsProvider(widget.schoolId)).value ?? const [];
    final isSelf = ref.watch(currentAccountProvider)?.uid == widget.uid;
    final palette = context.palette;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail anggota')),
      body: AsyncValueView(
        value: memberAsync,
        data: (member) {
          if (member == null) {
            return const EmptyState(icon: Icons.person_off_outlined, title: 'Anggota tidak ditemukan');
          }
          _initFrom(member);
          final isAdminRole = _role == SchoolRole.admin;

          return ListView(
            padding: const EdgeInsets.all(Gaps.lg),
            children: [
              ContentWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(Gaps.lg),
                        child: Row(
                          children: [
                            CircleAvatar(radius: 28, child: Text(member.initials)),
                            const SizedBox(width: Gaps.lg),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(member.displayName, style: context.textStyles.titleMedium),
                                  Text(
                                    member.joinedVia == JoinMethod.nisn ? 'NISN ${member.nisn}' : member.email ?? '-',
                                    style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
                                  ),
                                  const SizedBox(height: Gaps.sm),
                                  Wrap(
                                    spacing: Gaps.sm,
                                    runSpacing: Gaps.xs,
                                    children: [
                                      StatusPill(
                                        label: switch (member.status) {
                                          MemberStatus.active => 'Aktif',
                                          MemberStatus.pending => 'Menunggu',
                                          MemberStatus.rejected => 'Ditolak',
                                          MemberStatus.removed => 'Dikeluarkan',
                                        },
                                        tone: member.status == MemberStatus.active ? palette.success : palette.warning,
                                      ),
                                      StatusPill(label: member.joinedVia.label, tone: palette.neutral),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: Gaps.xl),
                    const SectionHeader(title: 'Peran & akses'),
                    const SizedBox(height: Gaps.md),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(Gaps.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            DropdownButtonFormField<SchoolRole>(
                              initialValue: _role,
                              decoration: const InputDecoration(labelText: 'Peran'),
                              items: [
                                for (final role in SchoolRole.values) DropdownMenuItem(value: role, child: Text(role.label)),
                              ],
                              onChanged: _busy || isSelf ? null : (role) => setState(() => _role = role ?? _role),
                            ),
                            if (isSelf)
                              Padding(
                                padding: const EdgeInsets.only(top: Gaps.sm),
                                child: Text(
                                  'Kamu tidak dapat mengubah peranmu sendiri.',
                                  style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
                                ),
                              ),
                            if (_role == SchoolRole.siswa) ...[
                              const SizedBox(height: Gaps.lg),
                              TextField(controller: _kelas, decoration: const InputDecoration(labelText: 'Kelas')),
                            ],
                            if (_role.isStaff) ...[
                              const SizedBox(height: Gaps.lg),
                              Text('Unit yang ditangani', style: context.textStyles.titleSmall),
                              const SizedBox(height: Gaps.sm),
                              Wrap(
                                spacing: Gaps.sm,
                                runSpacing: Gaps.sm,
                                children: [
                                  for (final unit in units)
                                    FilterChip(
                                      label: Text(unit.name),
                                      selected: _units.contains(unit.id),
                                      onSelected: _busy
                                          ? null
                                          : (selected) => setState(() => selected ? _units.add(unit.id) : _units.remove(unit.id)),
                                    ),
                                ],
                              ),
                              SwitchListTile(
                                contentPadding: EdgeInsets.zero,
                                value: isAdminRole || _canVerify,
                                onChanged: isAdminRole || _busy ? null : (value) => setState(() => _canVerify = value),
                                title: const Text('Tim Verifikasi'),
                                subtitle: Text(
                                  isAdminRole
                                      ? 'Admin selalu dapat memverifikasi laporan.'
                                      : 'Boleh memeriksa laporan baru sebelum diteruskan ke unit.',
                                ),
                              ),
                            ],
                            const SizedBox(height: Gaps.lg),
                            FilledButton(
                              onPressed: _busy || member.status != MemberStatus.active ? null : _save,
                              child: _busy ? const ButtonSpinner(color: Colors.white) : const Text('Simpan perubahan'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: Gaps.xl),
                    const SectionHeader(title: 'Tindakan lain'),
                    const SizedBox(height: Gaps.md),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          if (member.joinedVia == JoinMethod.nisn && member.status == MemberStatus.active) ...[
                            ListTile(
                              leading: const Icon(Icons.key_rounded),
                              title: const Text('Buat password baru'),
                              subtitle: const Text('Untuk siswa yang lupa password'),
                              onTap: _busy ? null : () => _resetPassword(member),
                            ),
                            const Divider(height: 1),
                          ],
                          ListTile(
                            leading: Icon(Icons.person_remove_outlined, color: palette.danger.main),
                            title: Text('Keluarkan dari sekolah', style: TextStyle(color: palette.danger.main)),
                            subtitle: Text(isSelf ? 'Kamu tidak dapat mengeluarkan dirimu sendiri.' : 'Akses ke data sekolah akan dicabut.'),
                            onTap: _busy || isSelf ? null : () => _remove(member),
                          ),
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
    );
  }
}
