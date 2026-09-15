import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/domain/catalog.dart';
import '../../schools/data/school_repository.dart';

class CreateSchoolScreen extends ConsumerStatefulWidget {
  const CreateSchoolScreen({super.key});

  @override
  ConsumerState<CreateSchoolScreen> createState() => _CreateSchoolScreenState();
}

class _CreateSchoolScreenState extends ConsumerState<CreateSchoolScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _city = TextEditingController();
  final _province = TextEditingController(text: 'Jawa Timur');
  final _npsn = TextEditingController();
  final _address = TextEditingController();
  final _code = TextEditingController();
  final _domains = TextEditingController();
  String _level = 'SMA';
  bool _busy = false;

  @override
  void dispose() {
    for (final controller in [_name, _city, _province, _npsn, _address, _code, _domains]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _busy = true);
    final result = await runGuarded(
      context,
      () => ref.read(schoolRepositoryProvider).create(
            name: _name.text.trim(),
            level: _level,
            city: _city.text.trim(),
            province: _province.text.trim(),
            npsn: _npsn.text.trim(),
            address: _address.text.trim(),
            code: _code.text.trim().toUpperCase(),
            allowedDomains: _domains.text
                .split(RegExp(r'[,;\s]+'))
                .map((domain) => domain.trim().toLowerCase())
                .where((domain) => domain.isNotEmpty)
                .toList(),
          ),
    );
    if (!mounted) return;
    setState(() => _busy = false);
    if (result == null) return;
    showSnack(context, 'Sekolah dibuat dengan kode ${result.code}. Undang admin sekolahnya sekarang.');
    context.pushReplacement(Routes.superadminSchool(result.schoolId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah sekolah')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(Gaps.lg),
          children: [
            ContentWidth(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(Gaps.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: Gaps.lg,
                    children: [
                      TextFormField(
                        controller: _name,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(labelText: 'Nama sekolah', hintText: 'mis. SMA Negeri 1 Sukodadi'),
                        validator: (value) => (value ?? '').trim().length >= 3 ? null : 'Nama minimal 3 huruf.',
                      ),
                      DropdownButtonFormField<String>(
                        initialValue: _level,
                        decoration: const InputDecoration(labelText: 'Jenjang'),
                        items: [for (final level in kSchoolLevels) DropdownMenuItem(value: level, child: Text(level))],
                        onChanged: (level) => setState(() => _level = level ?? _level),
                      ),
                      TextFormField(
                        controller: _city,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(labelText: 'Kabupaten/Kota'),
                        validator: (value) => (value ?? '').trim().length >= 2 ? null : 'Wajib diisi.',
                      ),
                      TextFormField(
                        controller: _province,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(labelText: 'Provinsi'),
                        validator: (value) => (value ?? '').trim().length >= 2 ? null : 'Wajib diisi.',
                      ),
                      TextFormField(
                        controller: _npsn,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: const InputDecoration(labelText: 'NPSN (opsional)'),
                        validator: (value) {
                          final npsn = (value ?? '').trim();
                          return npsn.isEmpty || RegExp(r'^\d{8}$').hasMatch(npsn) ? null : 'NPSN terdiri dari 8 angka.';
                        },
                      ),
                      TextFormField(
                        controller: _address,
                        maxLines: 2,
                        decoration: const InputDecoration(labelText: 'Alamat (opsional)'),
                      ),
                      TextFormField(
                        controller: _code,
                        textCapitalization: TextCapitalization.characters,
                        decoration: const InputDecoration(
                          labelText: 'Kode sekolah (opsional)',
                          helperText: 'Kosongkan untuk dibuat otomatis. 4–12 huruf/angka.',
                        ),
                        validator: (value) {
                          final code = (value ?? '').trim();
                          return code.isEmpty || RegExp(r'^[A-Za-z0-9]{4,12}$').hasMatch(code) ? null : 'Kode 4–12 huruf/angka.';
                        },
                      ),
                      TextFormField(
                        controller: _domains,
                        keyboardType: TextInputType.url,
                        decoration: const InputDecoration(
                          labelText: 'Domain email sekolah (opsional)',
                          helperText: 'Siswa dengan email domain ini langsung disetujui.',
                        ),
                      ),
                      FilledButton(
                        onPressed: _busy ? null : _submit,
                        child: _busy ? const ButtonSpinner(color: Colors.white) : const Text('Buat sekolah'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
