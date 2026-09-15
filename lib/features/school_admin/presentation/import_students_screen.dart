import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/utils/csv.dart';
import '../../members/data/membership_repository.dart';
import '../../members/domain/student_import.dart';

class ImportStudentsScreen extends ConsumerStatefulWidget {
  const ImportStudentsScreen({super.key, required this.schoolId});

  final String schoolId;

  @override
  ConsumerState<ImportStudentsScreen> createState() => _ImportStudentsScreenState();
}

class _ImportStudentsScreenState extends ConsumerState<ImportStudentsScreen> {
  String? _fileName;
  List<StudentInput> _students = const [];
  List<InvalidStudentRow> _invalid = const [];
  List<StudentImportResult>? _results;
  bool _resultsShared = false;
  bool _busy = false;

  static const _templateCsv = 'nisn,nama,kelas\r\n0061234567,Budi Santoso,X-1\r\n0069876543,Siti Aminah,X-2\r\n';

  Future<void> _pickFile() async {
    final files = await FilePicker.pickFiles(type: FileType.custom, allowedExtensions: const ['csv', 'txt']);
    if (files.isEmpty) return;
    final file = files.first;
    final List<int> bytes;
    try {
      bytes = await file.readAsBytes();
    } catch (_) {
      if (mounted) showSnack(context, 'Berkas tidak dapat dibaca. Coba simpan ulang sebagai CSV.', error: true);
      return;
    }
    if (!mounted) return;
    final parsed = readStudentRows(parseCsv(utf8.decode(bytes, allowMalformed: true)));
    setState(() {
      _fileName = file.name;
      _students = parsed.students;
      _invalid = parsed.invalid;
      _results = null;
      _resultsShared = false;
    });
  }

  Future<void> _import() async {
    final confirmed = await confirmAction(
      context,
      title: 'Buat ${_students.length} akun siswa?',
      message: 'Setiap siswa mendapat password awal yang wajib diganti saat masuk pertama kali.',
      confirmLabel: 'Buat akun',
    );
    if (!confirmed || !mounted) return;
    setState(() => _busy = true);
    final results = await runGuarded(
      context,
      () => ref.read(membershipRepositoryProvider).importStudents(widget.schoolId, _students),
    );
    if (!mounted) return;
    setState(() {
      _busy = false;
      if (results != null) _results = results;
    });
  }

  Future<void> _shareResults() async {
    final results = _results;
    if (results == null) return;
    final csv = toCsv([
      ['nisn', 'nama', 'kelas', 'status', 'password_awal', 'keterangan'],
      for (final row in results) [row.nisn, row.name, row.kelas, row.status, row.password ?? '', row.message ?? ''],
    ]);
    await SharePlus.instance.share(ShareParams(
      subject: 'Akun NISN MANDU',
      files: [XFile.fromData(utf8.encode(csv), mimeType: 'text/csv', name: 'akun-nisn-mandu.csv')],
      fileNameOverrides: const ['akun-nisn-mandu.csv'],
    ));
    if (mounted) setState(() => _resultsShared = true);
  }

  Future<void> _shareTemplate() => SharePlus.instance.share(ShareParams(
        subject: 'Contoh format impor NISN MANDU',
        files: [XFile.fromData(utf8.encode(_templateCsv), mimeType: 'text/csv', name: 'contoh-impor-nisn.csv')],
        fileNameOverrides: const ['contoh-impor-nisn.csv'],
      ));

  Future<void> _onPopBlocked() async {
    final leave = await confirmAction(
      context,
      title: 'Password awal belum disimpan',
      message: 'Password awal hanya tampil sekali. Bagikan atau simpan hasil impor sebelum keluar.',
      confirmLabel: 'Tetap keluar',
      destructive: true,
    );
    if (leave && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;
    return PopScope(
      canPop: results == null || _resultsShared,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _onPopBlocked();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Impor akun NISN')),
        body: ListView(
          padding: const EdgeInsets.all(Gaps.lg),
          children: [
            ContentWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (results == null) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(Gaps.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Siapkan berkas CSV', style: context.textStyles.titleMedium),
                            const SizedBox(height: Gaps.xs),
                            Text(
                              'Kolom: nisn, nama, kelas. Baris pertama boleh berisi judul kolom. '
                              'Dari Excel, pilih Simpan Sebagai → CSV. Maksimal ratusan siswa sekali impor.',
                              style: context.textStyles.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
                            ),
                            const SizedBox(height: Gaps.lg),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: _busy ? null : _shareTemplate,
                                    icon: const Icon(Icons.description_outlined),
                                    label: const Text('Contoh format'),
                                  ),
                                ),
                                const SizedBox(width: Gaps.md),
                                Expanded(
                                  child: FilledButton.tonalIcon(
                                    onPressed: _busy ? null : _pickFile,
                                    icon: const Icon(Icons.upload_file_rounded),
                                    label: const Text('Pilih berkas'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_fileName != null) ...[
                      const SizedBox(height: Gaps.lg),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(Gaps.lg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(_fileName!, style: context.textStyles.titleSmall),
                              const SizedBox(height: Gaps.xs),
                              Text('${_students.length} siswa siap diimpor', style: context.textStyles.bodyMedium),
                              if (_invalid.isNotEmpty) ...[
                                const SizedBox(height: Gaps.md),
                                InfoBanner(
                                  icon: Icons.warning_amber_rounded,
                                  tone: context.palette.warning,
                                  title: '${_invalid.length} baris dilewati',
                                  message: [
                                    for (final row in _invalid.take(5)) 'Baris ${row.line}: ${row.reason}',
                                    if (_invalid.length > 5) '… dan ${_invalid.length - 5} baris lainnya.',
                                  ].join('\n'),
                                ),
                              ],
                              if (_students.isNotEmpty) ...[
                                const SizedBox(height: Gaps.md),
                                for (final student in _students.take(5))
                                  ListTile(
                                    dense: true,
                                    contentPadding: EdgeInsets.zero,
                                    leading: const Icon(Icons.person_outline_rounded),
                                    title: Text(student.name),
                                    subtitle: Text('NISN ${student.nisn} · Kelas ${student.kelas}'),
                                  ),
                                if (_students.length > 5)
                                  Text('… dan ${_students.length - 5} siswa lainnya', style: context.textStyles.bodySmall),
                                const SizedBox(height: Gaps.lg),
                                FilledButton(
                                  onPressed: _busy ? null : _import,
                                  child: _busy
                                      ? const ButtonSpinner(color: Colors.white)
                                      : Text('Buat ${_students.length} akun siswa'),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ] else ...[
                    _ResultsSummary(results: results),
                    const SizedBox(height: Gaps.lg),
                    InfoBanner(
                      icon: Icons.lock_clock_outlined,
                      tone: context.palette.danger,
                      title: 'Password awal hanya tampil sekali',
                      message: 'Bagikan hasil ini ke wali kelas lewat jalur pribadi. Siswa wajib mengganti password saat masuk pertama.',
                    ),
                    const SizedBox(height: Gaps.lg),
                    FilledButton.icon(
                      onPressed: _shareResults,
                      icon: const Icon(Icons.ios_share_rounded),
                      label: const Text('Bagikan hasil (CSV)'),
                    ),
                    const SizedBox(height: Gaps.lg),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          for (final (index, row) in results.indexed) ...[
                            if (index > 0) const Divider(height: 1),
                            ListTile(
                              title: Text(row.name),
                              subtitle: Text('NISN ${row.nisn} · Kelas ${row.kelas}${row.message == null ? '' : '\n${row.message}'}'),
                              trailing: row.password == null
                                  ? StatusPill(label: 'Dilewati', tone: context.palette.warning)
                                  : SelectableText(
                                      row.password!,
                                      style: context.textStyles.titleSmall?.copyWith(letterSpacing: 0.8),
                                    ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: Gaps.lg),
                    TextButton(
                      onPressed: () => setState(() {
                        _results = null;
                        _fileName = null;
                        _students = const [];
                        _invalid = const [];
                      }),
                      child: const Text('Impor berkas lain'),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultsSummary extends StatelessWidget {
  const _ResultsSummary({required this.results});

  final List<StudentImportResult> results;

  @override
  Widget build(BuildContext context) {
    int count(String status) => results.where((row) => row.status == status).length;
    final palette = context.palette;
    return Wrap(
      spacing: Gaps.sm,
      runSpacing: Gaps.sm,
      children: [
        StatusPill(label: '${count('created')} akun dibuat', tone: palette.success, icon: Icons.check_circle_rounded),
        if (count('duplicate') > 0) StatusPill(label: '${count('duplicate')} NISN ganda', tone: palette.warning),
        if (count('exists') > 0) StatusPill(label: '${count('exists')} sudah ada', tone: palette.neutral),
        if (count('error') > 0) StatusPill(label: '${count('error')} gagal', tone: palette.danger),
      ],
    );
  }
}
