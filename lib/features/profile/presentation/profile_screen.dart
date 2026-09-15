import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/env.dart';
import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../account/data/account_repository.dart';
import '../../account/domain/account_summary.dart';
import '../../auth/application/session_controller.dart';
import '../../onboarding/presentation/privacy_policy.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+')).where((part) => part.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    return (parts.first[0] + (parts.length > 1 ? parts.last[0] : '')).toUpperCase();
  }

  Future<void> _editName(BuildContext context, WidgetRef ref, AccountSummary account) async {
    final name = await showDialog<String>(
      context: context,
      builder: (_) => _NameDialog(initialName: account.displayName),
    );
    if (name == null || name == account.displayName || !context.mounted) return;
    final saved = await runGuarded(context, () async {
      await ref.read(accountRepositoryProvider).updateDisplayName(name);
      return true;
    }, successMessage: 'Nama tampilan diperbarui.');
    if (saved == true) await ref.read(sessionControllerProvider.notifier).refresh(silent: true);
  }

  void _showPolicy(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.8,
        maxChildSize: 0.95,
        builder: (context, controller) => ListView(
          controller: controller,
          padding: const EdgeInsets.fromLTRB(Gaps.xl, 0, Gaps.xl, Gaps.xl),
          children: [
            Text('Kebijakan Privasi', style: context.textStyles.titleLarge),
            const SizedBox(height: Gaps.lg),
            const PrivacyPolicySections(),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut(BuildContext context, WidgetRef ref) async {
    final confirmed = await confirmAction(
      context,
      title: 'Keluar dari MANDU?',
      message: 'Kamu perlu masuk lagi untuk melihat laporan dan pesanmu.',
      confirmLabel: 'Keluar',
      destructive: true,
    );
    if (confirmed) await ref.read(sessionControllerProvider.notifier).signOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(currentAccountProvider);
    if (account == null) return const Scaffold(body: LoadingView());
    final danger = context.palette.danger;

    return Scaffold(
      appBar: AppBar(title: const Text('Akun')),
      body: ListView(
        padding: const EdgeInsets.all(Gaps.xl),
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
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: context.colors.primaryContainer,
                          child: Text(
                            _initials(account.displayName),
                            style: context.textStyles.titleMedium?.copyWith(color: context.colors.onPrimaryContainer),
                          ),
                        ),
                        const SizedBox(width: Gaps.lg),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(account.displayName, style: context.textStyles.titleMedium),
                              Text(
                                account.isNisnAccount ? 'Akun NISN' : account.email ?? '-',
                                style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
                              ),
                              if (account.schoolName != null) ...[
                                const SizedBox(height: Gaps.sm),
                                Wrap(
                                  spacing: Gaps.sm,
                                  runSpacing: Gaps.xs,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    if (account.role != null) StatusPill(label: account.role!.label, tone: context.palette.info),
                                    Text(account.schoolName!, style: context.textStyles.bodySmall),
                                  ],
                                ),
                              ],
                              if (account.isSuperadmin) ...[
                                const SizedBox(height: Gaps.sm),
                                StatusPill(label: 'Superadmin', tone: context.palette.bantuan, icon: Icons.shield_outlined),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: Gaps.xl),
                const SectionHeader(title: 'Pengaturan'),
                const SizedBox(height: Gaps.md),
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.edit_outlined),
                        title: const Text('Ubah nama tampilan'),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => _editName(context, ref, account),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.privacy_tip_outlined),
                        title: const Text('Kebijakan privasi'),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => _showPolicy(context),
                      ),
                      if (account.isSuperadmin && account.isActiveMember) ...[
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.admin_panel_settings_outlined),
                          title: const Text('Konsol superadmin'),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: () => context.go(Routes.superadminHome),
                        ),
                      ],
                      const Divider(height: 1),
                      ListTile(
                        leading: Icon(Icons.logout_rounded, color: danger.main),
                        title: Text('Keluar', style: TextStyle(color: danger.main)),
                        onTap: () => _signOut(context, ref),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Gaps.xl),
                Center(
                  child: Text(
                    'MANDU 2.0 · versi ${Env.appVersion}',
                    style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
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

class _NameDialog extends StatefulWidget {
  const _NameDialog({required this.initialName});

  final String initialName;

  @override
  State<_NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<_NameDialog> {
  late final _controller = TextEditingController(text: widget.initialName);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _controller.text.trim();
    if (name.length >= 2) Navigator.pop(context, name);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ubah nama tampilan'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        maxLength: 60,
        onSubmitted: (_) => _submit(),
        decoration: const InputDecoration(labelText: 'Nama'),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
        FilledButton(onPressed: _submit, style: FilledButton.styleFrom(minimumSize: const Size(64, 44)), child: const Text('Simpan')),
      ],
    );
  }
}
