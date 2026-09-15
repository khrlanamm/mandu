import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../app/routes.dart';
import '../../../core/design/assets.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/mandu_logo.dart';
import '../../../core/domain/school_code.dart';
import '../../../core/domain/service.dart';
import '../../../core/errors.dart';
import '../data/auth_repository.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  bool _busy = false;

  Future<void> _signInWithGoogle() async {
    setState(() => _busy = true);
    try {
      await ref.read(authRepositoryProvider).signInWithGoogle();
    } on GoogleSignInException catch (error) {
      if (error.code != GoogleSignInExceptionCode.canceled && mounted) {
        showSnack(context, 'Gagal masuk dengan Google: ${error.description ?? error.code.name}', error: true);
      }
    } catch (error) {
      if (mounted) showSnack(context, describeError(error), error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _openPublicAspiration() async {
    final code = await showDialog<String>(context: context, builder: (context) => const _SchoolCodeDialog());
    if (code != null && mounted) context.push(Routes.publicAspiration(code));
  }

  @override
  Widget build(BuildContext context) {
    final text = context.textStyles;
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(Gaps.xl, Gaps.xl, Gaps.xl, Gaps.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Align(alignment: Alignment.centerLeft, child: ManduLogo(size: 46, tagline: true)),
                        const SizedBox(height: Gaps.xxl),
                        Text('Ruang aman untuk bersuara di sekolah.', style: text.displaySmall),
                        const SizedBox(height: Gaps.md),
                        Text(
                          'Laporkan masalah, curhat ke Guru BK, sampaikan aspirasi, atau minta bantuan. '
                          'Semuanya di satu tempat.',
                          style: text.bodyLarge?.copyWith(color: context.colors.onSurfaceVariant),
                        ),
                        const SizedBox(height: Gaps.xl),
                        Wrap(
                          spacing: Gaps.sm,
                          runSpacing: Gaps.sm,
                          children: [for (final service in ManduService.values) _ServiceChip(service: service)],
                        ),
                        const SizedBox(height: Gaps.xxl),
                        FilledButton.icon(
                          onPressed: _busy ? null : _signInWithGoogle,
                          icon: _busy
                              ? const ButtonSpinner(color: Colors.white)
                              : DecoratedBox(
                                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: SvgPicture.asset(ManduAssets.googleG, width: 18, height: 18),
                                  ),
                                ),
                          label: const Text('Masuk dengan Google'),
                        ),
                        const SizedBox(height: Gaps.md),
                        OutlinedButton.icon(
                          onPressed: _busy ? null : () => context.push(Routes.nisnLogin),
                          icon: const Icon(Icons.badge_outlined),
                          label: const Text('Masuk dengan Akun Sekolah (NISN)'),
                        ),
                        const SizedBox(height: Gaps.sm),
                        TextButton(
                          onPressed: _busy ? null : () => context.push(Routes.emailLogin),
                          child: const Text('Staf sekolah? Masuk dengan email'),
                        ),
                        TextButton.icon(
                          onPressed: _busy ? null : _openPublicAspiration,
                          icon: const Icon(Icons.lightbulb_outline_rounded),
                          label: const Text('Kirim aspirasi tanpa login'),
                        ),
                        const SizedBox(height: Gaps.xl),
                        Text(
                          'Setelah masuk, kamu akan diminta membaca dan menyetujui Kebijakan Privasi MANDU.',
                          textAlign: TextAlign.center,
                          style: text.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SchoolCodeDialog extends StatefulWidget {
  const _SchoolCodeDialog();

  @override
  State<_SchoolCodeDialog> createState() => _SchoolCodeDialogState();
}

class _SchoolCodeDialogState extends State<_SchoolCodeDialog> {
  final _code = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  void _submit() {
    final code = _code.text.trim().toUpperCase();
    if (!isValidSchoolCode(code)) {
      setState(() => _error = 'Kode sekolah terdiri dari 4–12 huruf/angka.');
      return;
    }
    Navigator.pop(context, code);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Aspirasi tanpa login'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Masukkan kode sekolah yang tertera di poster atau QR MANDU sekolahmu.'),
          const SizedBox(height: Gaps.lg),
          TextField(
            controller: _code,
            autofocus: true,
            textCapitalization: TextCapitalization.characters,
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(labelText: 'Kode sekolah', errorText: _error),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
        FilledButton(onPressed: _submit, child: const Text('Lanjut')),
      ],
    );
  }
}

class _ServiceChip extends StatelessWidget {
  const _ServiceChip({required this.service});

  final ManduService service;

  @override
  Widget build(BuildContext context) {
    final tone = service.tone(context.palette);
    return DecoratedBox(
      decoration: BoxDecoration(color: tone.container, borderRadius: BorderRadius.circular(999)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Gaps.md, vertical: Gaps.sm),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(service.icon, size: 18, color: tone.main),
            const SizedBox(width: 6),
            Text(service.label, style: context.textStyles.labelMedium?.copyWith(color: tone.onContainer)),
          ],
        ),
      ),
    );
  }
}
