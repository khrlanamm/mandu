import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/domain/school_code.dart';
import '../../../core/errors.dart';
import '../../onboarding/presentation/qr_scan_screen.dart';
import '../../schools/data/school_repository.dart';
import '../data/auth_repository.dart';

class NisnLoginScreen extends ConsumerStatefulWidget {
  const NisnLoginScreen({super.key, this.initialCode});

  final String? initialCode;

  @override
  ConsumerState<NisnLoginScreen> createState() => _NisnLoginScreenState();
}

class _NisnLoginScreenState extends ConsumerState<NisnLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _code = TextEditingController(text: widget.initialCode ?? '');
  final _nisn = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  bool _busy = false;

  @override
  void dispose() {
    _code.dispose();
    _nisn.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _scan() async {
    final code = await Navigator.of(context).push<String>(MaterialPageRoute(builder: (_) => const QrScanScreen()));
    if (code != null) _code.text = code;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _busy = true);
    try {
      final school = await ref.read(schoolRepositoryProvider).lookup(_code.text);
      await ref.read(authRepositoryProvider).signInWithNisn(
            schoolId: school.schoolId,
            nisn: _nisn.text,
            password: _password.text,
          );
    } catch (error) {
      if (mounted) showSnack(context, describeError(error), error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Akun Sekolah')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Gaps.xl),
          children: [
            ContentWidth(
              maxWidth: 480,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Masuk dengan NISN', style: context.textStyles.headlineSmall),
                    const SizedBox(height: Gaps.sm),
                    Text(
                      'Gunakan kode sekolah, NISN, dan password yang dibagikan admin sekolahmu.',
                      style: context.textStyles.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
                    ),
                    const SizedBox(height: Gaps.xl),
                    TextFormField(
                      controller: _code,
                      textCapitalization: TextCapitalization.characters,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Kode sekolah',
                        prefixIcon: const Icon(Icons.school_outlined),
                        suffixIcon: IconButton(
                          tooltip: 'Pindai QR sekolah',
                          onPressed: _scan,
                          icon: const Icon(Icons.qr_code_scanner_rounded),
                        ),
                      ),
                      validator: (value) => isValidSchoolCode(value ?? '') ? null : 'Kode sekolah terdiri dari 4–12 huruf/angka.',
                    ),
                    const SizedBox(height: Gaps.lg),
                    TextFormField(
                      controller: _nisn,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(labelText: 'NISN / NIS', prefixIcon: Icon(Icons.badge_outlined)),
                      validator: (value) =>
                          RegExp(r'^\d{4,20}$').hasMatch(value?.trim() ?? '') ? null : 'Masukkan NISN/NIS (hanya angka).',
                    ),
                    const SizedBox(height: Gaps.lg),
                    TextFormField(
                      controller: _password,
                      obscureText: _obscure,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          tooltip: _obscure ? 'Tampilkan password' : 'Sembunyikan password',
                          onPressed: () => setState(() => _obscure = !_obscure),
                          icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                        ),
                      ),
                      validator: (value) => (value ?? '').isEmpty ? 'Masukkan password.' : null,
                    ),
                    const SizedBox(height: Gaps.xl),
                    FilledButton(
                      onPressed: _busy ? null : _submit,
                      child: _busy ? const ButtonSpinner(color: Colors.white) : const Text('Masuk'),
                    ),
                    const SizedBox(height: Gaps.lg),
                    const InfoBanner(
                      icon: Icons.help_outline_rounded,
                      message: 'Lupa password? Minta admin sekolah membuatkan password baru untukmu.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
