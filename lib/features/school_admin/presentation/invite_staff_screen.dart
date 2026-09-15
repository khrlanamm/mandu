import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/domain/roles.dart';
import '../../../core/errors.dart';
import '../../members/data/membership_repository.dart';
import '../../members/domain/member.dart';
import '../../schools/data/school_repository.dart';
import 'widgets/secret_dialog.dart';

class InviteStaffScreen extends ConsumerStatefulWidget {
  const InviteStaffScreen({super.key, required this.schoolId, this.initialRole});

  final String schoolId;
  final SchoolRole? initialRole;

  @override
  ConsumerState<InviteStaffScreen> createState() => _InviteStaffScreenState();
}

class _InviteStaffScreenState extends ConsumerState<InviteStaffScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _name = TextEditingController();
  late SchoolRole _role = (widget.initialRole?.isStaff ?? false) ? widget.initialRole! : SchoolRole.konselor;
  final _units = <String>{};
  bool _canVerify = false;
  bool _createAccount = false;
  bool _busy = false;

  @override
  void dispose() {
    _email.dispose();
    _name.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _busy = true);
    final role = _role;
    final result = await runGuarded(
      context,
      () => ref.read(membershipRepositoryProvider).invite(
            schoolId: widget.schoolId,
            email: _email.text.trim(),
            displayName: _name.text.trim(),
            role: role,
            units: _units.toList(),
            canVerify: role == SchoolRole.admin || _canVerify,
            createAccount: _createAccount,
          ),
    );
    if (!mounted) return;
    setState(() => _busy = false);
    if (result == null) return;

    _email.clear();
    _name.clear();
    setState(() {
      _units.clear();
      _canVerify = false;
      _createAccount = false;
    });

    final link = result.passwordSetupLink;
    if (link != null) {
      await showSecretDialog(
        context,
        title: 'Akun staf dibuat',
        secret: link,
        note: 'Bagikan tautan ini secara pribadi kepada staf untuk mengatur password. Setelah itu staf masuk lewat "Masuk dengan email".',
      );
    } else {
      showSnack(
        context,
        result.status == 'activated'
            ? 'Staf langsung aktif sebagai ${role.label}.'
            : 'Undangan dibuat. Peran aktif saat staf masuk dengan email tersebut.',
      );
    }
  }

  Future<void> _revoke(Invitation invitation) async {
    final confirmed = await confirmAction(
      context,
      title: 'Batalkan undangan?',
      message: 'Undangan untuk ${invitation.email} tidak berlaku lagi.',
      confirmLabel: 'Batalkan undangan',
      destructive: true,
    );
    if (!confirmed || !mounted) return;
    await runGuarded(
      context,
      () => ref.read(membershipRepositoryProvider).revokeInvitation(invitation.id),
      successMessage: 'Undangan dibatalkan.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final units = ref.watch(schoolUnitsProvider(widget.schoolId)).value ?? const [];
    final invitations = ref.watch(pendingInvitationsProvider(widget.schoolId));
    final isAdminRole = _role == SchoolRole.admin;

    return Scaffold(
      appBar: AppBar(title: const Text('Undang staf')),
      body: ListView(
        padding: const EdgeInsets.all(Gaps.lg),
        children: [
          ContentWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const InfoBanner(
                  icon: Icons.mark_email_read_outlined,
                  message: 'Peran aktif otomatis saat staf masuk ke MANDU dengan email yang diundang, lewat Google atau email.',
                ),
                const SizedBox(height: Gaps.lg),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(Gaps.lg),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(labelText: 'Email staf', prefixIcon: Icon(Icons.mail_outline_rounded)),
                            validator: (value) => RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value?.trim() ?? '')
                                ? null
                                : 'Masukkan email yang valid.',
                          ),
                          const SizedBox(height: Gaps.lg),
                          TextFormField(
                            controller: _name,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(labelText: 'Nama (opsional)', prefixIcon: Icon(Icons.person_outline_rounded)),
                          ),
                          const SizedBox(height: Gaps.lg),
                          DropdownButtonFormField<SchoolRole>(
                            initialValue: _role,
                            decoration: const InputDecoration(labelText: 'Peran'),
                            items: [
                              for (final role in SchoolRole.staffRoles) DropdownMenuItem(value: role, child: Text(role.label)),
                            ],
                            onChanged: _busy ? null : (role) => setState(() => _role = role ?? _role),
                          ),
                          const SizedBox(height: Gaps.lg),
                          Text('Unit yang ditangani', style: context.textStyles.titleSmall),
                          Text(
                            'Untuk petugas unit dan konselor. Laporan kategori terkait diteruskan ke unit ini.',
                            style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
                          ),
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
                            subtitle: const Text('Boleh memeriksa laporan baru sebelum diteruskan ke unit.'),
                          ),
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            value: _createAccount,
                            onChanged: _busy ? null : (value) => setState(() => _createAccount = value),
                            title: const Text('Buatkan akun email & password'),
                            subtitle: const Text('Untuk staf yang tidak memakai akun Google.'),
                          ),
                          const SizedBox(height: Gaps.lg),
                          FilledButton(
                            onPressed: _busy ? null : _submit,
                            child: _busy ? const ButtonSpinner(color: Colors.white) : const Text('Kirim undangan'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: Gaps.xl),
                const SectionHeader(title: 'Undangan menunggu'),
                const SizedBox(height: Gaps.sm),
                invitations.when(
                  loading: () => const LinearProgressIndicator(),
                  error: (error, _) => Text(describeError(error), style: TextStyle(color: context.palette.danger.main)),
                  data: (list) => list.isEmpty
                      ? Text(
                          'Belum ada undangan yang menunggu.',
                          style: context.textStyles.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
                        )
                      : Card(
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: [
                              for (final (index, invitation) in list.indexed) ...[
                                if (index > 0) const Divider(height: 1),
                                ListTile(
                                  leading: const Icon(Icons.schedule_send_outlined),
                                  title: Text(invitation.email),
                                  subtitle: Text([
                                    invitation.role.label,
                                    if (invitation.displayName != null) invitation.displayName!,
                                  ].join(' · ')),
                                  trailing: IconButton(
                                    tooltip: 'Batalkan undangan',
                                    onPressed: () => _revoke(invitation),
                                    icon: const Icon(Icons.close_rounded),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
