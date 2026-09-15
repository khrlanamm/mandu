import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/domain/school_code.dart';
import '../../../core/errors.dart';
import '../../auth/application/session_controller.dart';
import '../../members/data/membership_repository.dart';
import '../../schools/data/school_repository.dart';
import '../../schools/domain/public_school.dart';
import 'qr_scan_screen.dart';

class JoinSchoolScreen extends ConsumerStatefulWidget {
  const JoinSchoolScreen({super.key, this.initialCode});

  final String? initialCode;

  @override
  ConsumerState<JoinSchoolScreen> createState() => _JoinSchoolScreenState();
}

class _JoinSchoolScreenState extends ConsumerState<JoinSchoolScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _code = TextEditingController(text: widget.initialCode ?? '');
  final _name = TextEditingController();
  final _kelas = TextEditingController();
  final _nisn = TextEditingController();
  PublicSchool? _school;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _name.text = ref.read(currentAccountProvider)?.displayName ?? '';
    if (widget.initialCode != null && isValidSchoolCode(widget.initialCode!)) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _lookup());
    }
  }

  @override
  void dispose() {
    _code.dispose();
    _name.dispose();
    _kelas.dispose();
    _nisn.dispose();
    super.dispose();
  }

  Future<void> _scan() async {
    final code = await Navigator.of(context).push<String>(MaterialPageRoute(builder: (_) => const QrScanScreen()));
    if (code == null) return;
    _code.text = code;
    await _lookup();
  }

  Future<void> _lookup() async {
    if (!isValidSchoolCode(_code.text)) {
      showSnack(context, 'Kode sekolah terdiri dari 4–12 huruf/angka.', error: true);
      return;
    }
    setState(() => _busy = true);
    try {
      final school = await ref.read(schoolRepositoryProvider).lookup(_code.text);
      if (mounted) setState(() => _school = school);
    } catch (error) {
      if (mounted) showSnack(context, describeError(error), error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _join() async {
    final school = _school;
    if (school == null || !_formKey.currentState!.validate()) return;
    setState(() => _busy = true);
    try {
      final result = await ref.read(membershipRepositoryProvider).join(
            code: school.code,
            displayName: _name.text.trim(),
            kelas: _kelas.text.trim(),
            nisn: _nisn.text.trim(),
          );
      await ref.read(sessionControllerProvider.notifier).refresh();
      if (mounted) {
        showSnack(
          context,
          result.status == 'active'
              ? 'Selamat bergabung di ${result.schoolName}!'
              : 'Permintaan terkirim. Tunggu persetujuan admin ${result.schoolName}.',
        );
      }
    } catch (error) {
      if (mounted) showSnack(context, describeError(error), error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final school = _school;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gabung ke Sekolah'),
        actions: [
          IconButton(tooltip: 'Akun', onPressed: () => context.push(Routes.account), icon: const Icon(Icons.person_outline_rounded)),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Gaps.xl),
          children: [
            ContentWidth(
              maxWidth: 520,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Hubungkan akunmu dengan sekolah', style: context.textStyles.headlineSmall),
                  const SizedBox(height: Gaps.sm),
                  Text(
                    'Masukkan kode sekolah dari guru/admin, atau pindai QR MANDU yang dibagikan sekolahmu.',
                    style: context.textStyles.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: Gaps.xl),
                  if (school == null) ...[
                    TextField(
                      controller: _code,
                      textCapitalization: TextCapitalization.characters,
                      onSubmitted: (_) => _lookup(),
                      decoration: InputDecoration(
                        labelText: 'Kode sekolah',
                        prefixIcon: const Icon(Icons.school_outlined),
                        suffixIcon: IconButton(
                          tooltip: 'Pindai QR sekolah',
                          onPressed: _busy ? null : _scan,
                          icon: const Icon(Icons.qr_code_scanner_rounded),
                        ),
                      ),
                    ),
                    const SizedBox(height: Gaps.lg),
                    FilledButton(
                      onPressed: _busy ? null : _lookup,
                      child: _busy ? const ButtonSpinner(color: Colors.white) : const Text('Cari sekolah'),
                    ),
                  ] else ...[
                    _SchoolCard(school: school, onChange: _busy ? null : () => setState(() => _school = null)),
                    const SizedBox(height: Gaps.xl),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _name,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(labelText: 'Nama lengkap', prefixIcon: Icon(Icons.person_outline_rounded)),
                            validator: (value) => (value ?? '').trim().length >= 2 ? null : 'Masukkan nama lengkap.',
                          ),
                          const SizedBox(height: Gaps.lg),
                          TextFormField(
                            controller: _kelas,
                            textCapitalization: TextCapitalization.characters,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'Kelas',
                              hintText: 'mis. XI IPA 2',
                              prefixIcon: Icon(Icons.class_outlined),
                            ),
                            validator: (value) => (value ?? '').trim().isEmpty ? 'Masukkan kelas.' : null,
                          ),
                          const SizedBox(height: Gaps.lg),
                          TextFormField(
                            controller: _nisn,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: const InputDecoration(
                              labelText: 'NISN / NIS (opsional)',
                              helperText: 'Membantu admin memastikan kamu siswa sekolah ini.',
                              prefixIcon: Icon(Icons.badge_outlined),
                            ),
                            validator: (value) {
                              final nisn = (value ?? '').trim();
                              return nisn.isEmpty || RegExp(r'^\d{4,20}$').hasMatch(nisn) ? null : 'NISN/NIS hanya angka.';
                            },
                          ),
                          const SizedBox(height: Gaps.xl),
                          FilledButton(
                            onPressed: _busy ? null : _join,
                            child: _busy ? const ButtonSpinner(color: Colors.white) : const Text('Kirim permintaan bergabung'),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: Gaps.xxl),
                  const Divider(),
                  const SizedBox(height: Gaps.lg),
                  Text('Punya akun NISN dari sekolah?', style: context.textStyles.titleSmall),
                  const SizedBox(height: Gaps.xs),
                  Text(
                    'Keluar, lalu pilih "Masuk dengan Akun Sekolah (NISN)" di halaman awal.',
                    style: context.textStyles.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: _busy ? null : () => signOutFromApp(ref),
                      child: const Text('Keluar'),
                    ),
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

class _SchoolCard extends StatelessWidget {
  const _SchoolCard({required this.school, required this.onChange});

  final PublicSchool school;
  final VoidCallback? onChange;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Gaps.lg),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(color: context.colors.primaryContainer, borderRadius: BorderRadius.circular(Radii.md)),
              child: Padding(
                padding: const EdgeInsets.all(Gaps.md),
                child: Icon(Icons.apartment_rounded, color: context.colors.onPrimaryContainer),
              ),
            ),
            const SizedBox(width: Gaps.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(school.name, style: context.textStyles.titleMedium),
                  const SizedBox(height: 2),
                  Text(
                    '${school.level} · ${school.city}, ${school.province}',
                    style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: Gaps.sm),
                  StatusPill(label: 'Kode ${school.code}', tone: context.palette.info, icon: Icons.verified_rounded),
                ],
              ),
            ),
            TextButton(onPressed: onChange, child: const Text('Ganti')),
          ],
        ),
      ),
    );
  }
}
