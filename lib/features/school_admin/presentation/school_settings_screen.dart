import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../../core/domain/catalog.dart';
import '../../../core/domain/service.dart';
import '../../auth/application/session_controller.dart';
import '../../schools/data/school_repository.dart';
import '../../schools/domain/school.dart';
import 'school_code_sheet.dart';

class SchoolSettingsScreen extends ConsumerStatefulWidget {
  const SchoolSettingsScreen({super.key, required this.schoolId});

  final String schoolId;

  @override
  ConsumerState<SchoolSettingsScreen> createState() => _SchoolSettingsScreenState();
}

class _SchoolSettingsScreenState extends ConsumerState<SchoolSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _city = TextEditingController();
  final _province = TextEditingController();
  final _npsn = TextEditingController();
  final _address = TextEditingController();
  final _domains = TextEditingController();
  final _slaVerify = TextEditingController();
  final _slaFollowUp = TextEditingController();
  final _slaEmergency = TextEditingController();
  String _level = 'SMA';
  ServiceToggles _services = const ServiceToggles();
  bool _publicAspiration = true;
  bool _aspirationBoard = true;
  bool _active = true;
  bool _initialized = false;
  bool _busy = false;

  @override
  void dispose() {
    for (final controller in [_name, _city, _province, _npsn, _address, _domains, _slaVerify, _slaFollowUp, _slaEmergency]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initFrom(School school) {
    if (_initialized) return;
    _initialized = true;
    _name.text = school.name;
    _city.text = school.city;
    _province.text = school.province;
    _npsn.text = school.npsn ?? '';
    _address.text = school.address ?? '';
    _domains.text = school.allowedDomains.join(', ');
    _slaVerify.text = '${school.slaHours.verifikasi}';
    _slaFollowUp.text = '${school.slaHours.tindakLanjut}';
    _slaEmergency.text = '${school.slaHours.darurat}';
    _level = kSchoolLevels.contains(school.level) ? school.level : 'Lainnya';
    _services = school.services;
    _publicAspiration = school.publicAspiration;
    _aspirationBoard = school.aspirationBoard;
    _active = school.active;
  }

  bool _serviceEnabled(ManduService service) => switch (service) {
        ManduService.lapor => _services.lapor,
        ManduService.curhat => _services.curhat,
        ManduService.aspirasi => _services.aspirasi,
        ManduService.bantuan => _services.bantuan,
        ManduService.edukasi => _services.edukasi,
      };

  void _toggleService(ManduService service, bool value) => setState(() {
        _services = switch (service) {
          ManduService.lapor => _services.copyWith(lapor: value),
          ManduService.curhat => _services.copyWith(curhat: value),
          ManduService.aspirasi => _services.copyWith(aspirasi: value),
          ManduService.bantuan => _services.copyWith(bantuan: value),
          ManduService.edukasi => _services.copyWith(edukasi: value),
        };
      });

  Future<void> _save(bool isSuperadmin) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _busy = true);
    final domains = _domains.text
        .split(RegExp(r'[,;\s]+'))
        .map((domain) => domain.trim().toLowerCase())
        .where((domain) => domain.isNotEmpty)
        .toList();
    await runGuarded(
      context,
      () => ref.read(schoolRepositoryProvider).update(widget.schoolId, {
        'name': _name.text.trim(),
        'level': _level,
        'city': _city.text.trim(),
        'province': _province.text.trim(),
        'npsn': _npsn.text.trim().isEmpty ? null : _npsn.text.trim(),
        'address': _address.text.trim().isEmpty ? null : _address.text.trim(),
        'allowedDomains': domains,
        'services': _services.toJson(),
        'publicAspiration': _publicAspiration,
        'aspirationBoard': _aspirationBoard,
        'slaHours': {
          'verifikasi': int.parse(_slaVerify.text),
          'tindakLanjut': int.parse(_slaFollowUp.text),
          'darurat': int.parse(_slaEmergency.text),
        },
        if (isSuperadmin) 'active': _active,
      }),
      successMessage: 'Pengaturan sekolah disimpan.',
    );
    if (mounted) setState(() => _busy = false);
  }

  Future<void> _changeCode() async {
    final confirmed = await confirmAction(
      context,
      title: 'Ganti kode sekolah?',
      message: 'Kode dan QR lama tidak berlaku lagi. Akun NISN tetap bisa masuk dengan kode baru.',
      confirmLabel: 'Ganti kode',
      destructive: true,
    );
    if (!confirmed || !mounted) return;
    final code = await runGuarded(context, () => ref.read(schoolRepositoryProvider).changeCode(widget.schoolId));
    if (code != null && mounted) showSnack(context, 'Kode sekolah baru: $code');
  }

  String? _hoursValidator(String? value, {required int max}) {
    final hours = int.tryParse(value ?? '');
    return hours == null || hours < 1 || hours > max ? '1–$max jam' : null;
  }

  @override
  Widget build(BuildContext context) {
    final school = ref.watch(schoolDocProvider(widget.schoolId));
    final isSuperadmin = ref.watch(currentAccountProvider)?.isSuperadmin ?? false;

    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan sekolah')),
      body: AsyncValueView(
        value: school,
        data: (school) {
          if (school == null) return const EmptyState(icon: Icons.apartment_rounded, title: 'Sekolah tidak ditemukan');
          _initFrom(school);
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.lg, Gaps.lg, Gaps.xxxl),
              children: [
                ContentWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _Section(
                        title: 'Profil sekolah',
                        children: [
                          TextFormField(
                            controller: _name,
                            decoration: const InputDecoration(labelText: 'Nama sekolah'),
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
                            decoration: const InputDecoration(labelText: 'Kabupaten/Kota'),
                            validator: (value) => (value ?? '').trim().length >= 2 ? null : 'Wajib diisi.',
                          ),
                          TextFormField(
                            controller: _province,
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
                        ],
                      ),
                      _Section(
                        title: 'Kode sekolah',
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(school.code, style: context.textStyles.headlineSmall?.copyWith(letterSpacing: 4)),
                              ),
                              TextButton.icon(
                                onPressed: () => showSchoolCodeSheet(context, school),
                                icon: const Icon(Icons.qr_code_2_rounded),
                                label: const Text('QR'),
                              ),
                              TextButton(onPressed: _busy ? null : _changeCode, child: const Text('Ganti kode')),
                            ],
                          ),
                        ],
                      ),
                      _Section(
                        title: 'Persetujuan otomatis',
                        children: [
                          TextFormField(
                            controller: _domains,
                            keyboardType: TextInputType.url,
                            decoration: const InputDecoration(
                              labelText: 'Domain email sekolah',
                              hintText: 'mis. sman1contoh.sch.id',
                              helperText: 'Pisahkan dengan koma. Siswa berakun email domain ini langsung disetujui.',
                              helperMaxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      _Section(
                        title: 'Layanan aktif',
                        children: [
                          for (final service in ManduService.values)
                            SwitchListTile(
                              contentPadding: EdgeInsets.zero,
                              secondary: Icon(service.icon, color: service.tone(context.palette).main),
                              title: Text(service.label),
                              subtitle: Text(service.tagline),
                              value: _serviceEnabled(service),
                              onChanged: (value) => _toggleService(service, value),
                            ),
                        ],
                      ),
                      _Section(
                        title: 'Aspirasi',
                        children: [
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Aspirasi tanpa login'),
                            subtitle: const Text('Siapa pun dengan kode atau QR sekolah dapat mengirim aspirasi tanpa akun.'),
                            value: _publicAspiration,
                            onChanged: (value) => setState(() => _publicAspiration = value),
                          ),
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Papan aspirasi'),
                            subtitle: const Text('Aspirasi yang disetujui tampil untuk siswa dan bisa didukung.'),
                            value: _aspirationBoard,
                            onChanged: (value) => setState(() => _aspirationBoard = value),
                          ),
                        ],
                      ),
                      _Section(
                        title: 'Target waktu layanan (jam)',
                        children: [
                          TextFormField(
                            controller: _slaVerify,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: const InputDecoration(labelText: 'Verifikasi laporan baru'),
                            validator: (value) => _hoursValidator(value, max: 168),
                          ),
                          TextFormField(
                            controller: _slaFollowUp,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: const InputDecoration(labelText: 'Tindak lanjut oleh unit'),
                            validator: (value) => _hoursValidator(value, max: 720),
                          ),
                          TextFormField(
                            controller: _slaEmergency,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: const InputDecoration(labelText: 'Respons laporan darurat'),
                            validator: (value) => _hoursValidator(value, max: 24),
                          ),
                        ],
                      ),
                      if (isSuperadmin)
                        _Section(
                          title: 'Status sekolah',
                          children: [
                            SwitchListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Sekolah aktif'),
                              subtitle: const Text('Sekolah nonaktif tidak bisa ditemukan lewat kode.'),
                              value: _active,
                              onChanged: (value) => setState(() => _active = value),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Gaps.lg),
          child: FilledButton(
            onPressed: _busy || !_initialized ? null : () => _save(isSuperadmin),
            child: _busy ? const ButtonSpinner(color: Colors.white) : const Text('Simpan pengaturan'),
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Gaps.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(title: title),
          const SizedBox(height: Gaps.md),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Gaps.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: Gaps.lg,
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
