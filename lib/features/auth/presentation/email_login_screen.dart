import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/demo_accounts.dart';
import '../../../app/env.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/errors.dart';
import '../data/auth_repository.dart';

class EmailLoginScreen extends ConsumerStatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  ConsumerState<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends ConsumerState<EmailLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  bool _busy = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _signIn(String email, String password) async {
    setState(() => _busy = true);
    try {
      await ref.read(authRepositoryProvider).signInWithEmail(email, password);
    } catch (error) {
      if (mounted) showSnack(context, describeError(error), error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _resetPassword() async {
    final email = _email.text.trim();
    if (!email.contains('@')) {
      showSnack(context, 'Isi email terlebih dahulu, lalu ketuk "Lupa password".', error: true);
      return;
    }
    await runGuarded(
      context,
      () => ref.read(authRepositoryProvider).sendPasswordReset(email),
      successMessage: 'Tautan atur ulang password dikirim ke $email.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Masuk dengan Email')),
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
                    Text('Masuk dengan email', style: context.textStyles.headlineSmall),
                    const SizedBox(height: Gaps.sm),
                    Text(
                      'Untuk guru, staf, dan siswa yang dibuatkan akun email oleh sekolah. '
                      'Punya akun Google? Kembali dan pilih "Masuk dengan Google".',
                      style: context.textStyles.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
                    ),
                    const SizedBox(height: Gaps.xl),
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.mail_outline_rounded)),
                      validator: (value) => (value ?? '').contains('@') ? null : 'Masukkan email yang valid.',
                    ),
                    const SizedBox(height: Gaps.lg),
                    TextFormField(
                      controller: _password,
                      obscureText: _obscure,
                      autofillHints: const [AutofillHints.password],
                      onFieldSubmitted: (_) {
                        if (_formKey.currentState!.validate()) _signIn(_email.text, _password.text);
                      },
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: _busy ? null : _resetPassword, child: const Text('Lupa password')),
                    ),
                    const SizedBox(height: Gaps.sm),
                    FilledButton(
                      onPressed: _busy
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) _signIn(_email.text, _password.text);
                            },
                      child: _busy ? const ButtonSpinner(color: Colors.white) : const Text('Masuk'),
                    ),
                    if (Env.useEmulators) ...[
                      const SizedBox(height: Gaps.xxl),
                      const SectionHeader(title: 'Akun demo (Emulator Suite)'),
                      const SizedBox(height: Gaps.sm),
                      Card(
                        child: Column(
                          children: [
                            for (final demo in kDemoAccounts)
                              ListTile(
                                leading: const Icon(Icons.person_pin_outlined),
                                title: Text(demo.label),
                                subtitle: Text('${demo.email} · ${demo.description}'),
                                onTap: _busy ? null : () => _signIn(demo.email, kDemoPassword),
                              ),
                          ],
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
    );
  }
}
