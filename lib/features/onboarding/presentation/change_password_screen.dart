import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/errors.dart';
import '../../account/data/account_repository.dart';
import '../../auth/application/session_controller.dart';
import '../../auth/data/auth_repository.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _obscure = true;
  bool _busy = false;

  @override
  void dispose() {
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    final password = value ?? '';
    if (password.length < 8) return 'Password minimal 8 karakter.';
    if (!RegExp(r'[A-Za-z]').hasMatch(password) || !RegExp(r'\d').hasMatch(password)) {
      return 'Gunakan kombinasi huruf dan angka.';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _busy = true);
    try {
      await ref.read(accountRepositoryProvider).changeInitialPassword(_password.text);
      await ref.read(authRepositoryProvider).signInAgain(_password.text);
      await ref.read(sessionControllerProvider.notifier).refresh();
      if (mounted) showSnack(context, 'Password berhasil diganti.');
    } catch (error) {
      if (mounted) showSnack(context, describeError(error), error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Password Baru'),
        actions: [
          TextButton(
            onPressed: _busy ? null : () => signOutFromApp(ref),
            child: const Text('Keluar'),
          ),
        ],
      ),
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
                    Text('Amankan akunmu', style: context.textStyles.headlineSmall),
                    const SizedBox(height: Gaps.sm),
                    Text(
                      'Password dari admin sekolah hanya untuk masuk pertama kali. Buat password baru yang hanya kamu ketahui.',
                      style: context.textStyles.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
                    ),
                    const SizedBox(height: Gaps.xl),
                    TextFormField(
                      controller: _password,
                      obscureText: _obscure,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Password baru',
                        helperText: 'Minimal 8 karakter, kombinasi huruf dan angka.',
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          tooltip: _obscure ? 'Tampilkan password' : 'Sembunyikan password',
                          onPressed: () => setState(() => _obscure = !_obscure),
                          icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                        ),
                      ),
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: Gaps.lg),
                    TextFormField(
                      controller: _confirm,
                      obscureText: _obscure,
                      onFieldSubmitted: (_) => _submit(),
                      decoration: const InputDecoration(
                        labelText: 'Ulangi password baru',
                        prefixIcon: Icon(Icons.lock_reset_rounded),
                      ),
                      validator: (value) => value == _password.text ? null : 'Password tidak sama.',
                    ),
                    const SizedBox(height: Gaps.xl),
                    FilledButton(
                      onPressed: _busy ? null : _submit,
                      child: _busy ? const ButtonSpinner(color: Colors.white) : const Text('Simpan password'),
                    ),
                    const SizedBox(height: Gaps.lg),
                    const InfoBanner(
                      icon: Icons.privacy_tip_outlined,
                      message: 'Jangan bagikan password ke teman. Jika lupa, minta admin sekolah membuatkan password baru.',
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
