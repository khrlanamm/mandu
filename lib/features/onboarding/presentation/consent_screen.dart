import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../account/data/account_repository.dart';
import '../../auth/application/session_controller.dart';
import 'privacy_policy.dart';

class ConsentScreen extends ConsumerStatefulWidget {
  const ConsentScreen({super.key});

  @override
  ConsumerState<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends ConsumerState<ConsentScreen> {
  bool _agreed = false;
  bool _guardianAware = false;
  bool _busy = false;

  Future<void> _accept() async {
    setState(() => _busy = true);
    final ok = await runGuarded(context, () async {
      await ref.read(accountRepositoryProvider).acceptConsent();
      return true;
    });
    if (ok == true) await ref.read(sessionControllerProvider.notifier).refresh();
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kebijakan Privasi'),
        actions: [
          TextButton(
            onPressed: _busy ? null : () => ref.read(sessionControllerProvider.notifier).signOut(),
            child: const Text('Keluar'),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(Gaps.xl, Gaps.md, Gaps.xl, Gaps.xl),
          children: [
            ContentWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Sebelum mulai', style: context.textStyles.headlineSmall),
                  const SizedBox(height: Gaps.sm),
                  Text(
                    'MANDU menjaga kerahasiaan ceritamu. Baca ringkasan berikut agar kamu tahu bagaimana datamu digunakan.',
                    style: context.textStyles.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: Gaps.xl),
                  const Card(child: Padding(padding: EdgeInsets.all(Gaps.lg), child: PrivacyPolicySections())),
                  const SizedBox(height: Gaps.lg),
                  CheckboxListTile(
                    value: _agreed,
                    onChanged: _busy ? null : (value) => setState(() => _agreed = value ?? false),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Saya sudah membaca dan menyetujui Kebijakan Privasi serta Ketentuan Layanan MANDU.'),
                  ),
                  CheckboxListTile(
                    value: _guardianAware,
                    onChanged: _busy ? null : (value) => setState(() => _guardianAware = value ?? false),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Jika saya berusia di bawah 18 tahun, orang tua/wali saya mengetahui penggunaan aplikasi ini.'),
                  ),
                  const SizedBox(height: Gaps.lg),
                  FilledButton(
                    onPressed: _agreed && _guardianAware && !_busy ? _accept : null,
                    child: _busy ? const ButtonSpinner(color: Colors.white) : const Text('Setuju dan lanjutkan'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
