import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../core/assets.dart';
import '../../core/constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/ui_helpers.dart';
import '../../data/models/report.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/report_repository.dart';

/// Formulir Pelaporan Bullying (LaBu).
class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _imagePicker = ImagePicker();

  String? _role;
  String? _frequency;
  DateTime? _incidentDate;
  File? _proof;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _dateController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _whatsappController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _incidentDate ?? now,
      firstDate: DateTime(now.year - 10),
      lastDate: now,
      helpText: 'Tanggal Bullying',
    );
    if (picked == null) return;
    setState(() {
      _incidentDate = picked;
      _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
    });
  }

  Future<void> _pickProof() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 0, 24, 8),
              child: Text(
                'Pilih Sumber Gambar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Buka Kamera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Pilih dari Galeri'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;

    try {
      final picked = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1920,
        imageQuality: 85,
      );
      if (picked != null && mounted) setState(() => _proof = File(picked.path));
    } on PlatformException catch (e) {
      if (!mounted) return;
      showSnack(
        context,
        e.code == 'camera_access_denied'
            ? 'Izin kamera ditolak'
            : 'Gagal mengambil gambar: ${e.message ?? e.code}',
      );
    }
  }

  Future<void> _submit() async {
    if (AuthRepository.instance.currentUser == null) {
      showSnack(context, 'Anda harus masuk untuk dapat mengirim laporan.');
      return;
    }
    if (_role == null) {
      showSnack(context, 'Pilih peran Anda (Korban/Saksi)');
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    final confirmed = await showConfirmDialog(
      context,
      title: 'Kirim Laporan?',
      message: 'Pastikan semua data yang Anda masukkan sudah benar.',
      confirmLabel: 'Kirim',
      cancelLabel: 'Batal',
    );
    if (!confirmed || !mounted) return;

    setState(() => _isSubmitting = true);
    try {
      await ReportRepository.instance.submitReport(
        ReportDraft(
          peran: _role!,
          tanggalBullying: _dateController.text,
          lokasi: _locationController.text.trim(),
          frekuensi: _frequency!,
          deskripsi: _descriptionController.text.trim(),
          nomorWhatsapp: _whatsappController.text.trim(),
        ),
        proof: _proof,
      );
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      await _showSuccessDialog();
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      debugPrint('Gagal mengirim laporan: $e');
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      showSnack(context, 'Gagal mengirim laporan: ${describeError(e)}');
    }
  }

  Future<void> _showSuccessDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          icon: Image.asset(AppAssets.appLogo, width: 56, height: 56),
          title: const Text('Laporan Berhasil Terkirim'),
          content: const Text(
            'Laporan Anda sudah kami terima. Ingat, Anda tidak sendirian dan Anda telah '
            'berani melangkah maju. Kami akan segera menindaklanjuti laporan ini. '
            'Kerahasiaan anda akan kami jaga.',
          ),
          actions: [
            FilledButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
          ],
        ),
      ),
    );
  }

  Future<void> _contactCounseling() async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Hubungi Bimbingan Konseling',
      message: 'Anda akan diarahkan ke WhatsApp ${AppConstants.counselingName}.',
      confirmLabel: 'Lanjutkan',
      cancelLabel: 'Batal',
    );
    if (confirmed && mounted) await openWhatsApp(context, AppConstants.counselingWhatsApp);
  }

  static FormFieldValidator<String> _required(String message) {
    return (value) => value == null || value.trim().isEmpty ? message : null;
  }

  static String? _validateWhatsApp(String? value) {
    final digits = value?.replaceAll(RegExp(r'[^0-9]'), '') ?? '';
    if (digits.isEmpty) return 'Nomor WhatsApp tidak boleh kosong';
    if (digits.length < 9) return 'Nomor WhatsApp tidak valid';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final proof = _proof;

    return PopScope(
      canPop: !_isSubmitting,
      child: Scaffold(
        appBar: AppBar(title: const Text('LaBu')),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Hubungi Bimbingan Konseling via WhatsApp',
          backgroundColor: AppColors.whatsapp,
          onPressed: _isSubmitting ? null : _contactCounseling,
          child: SvgPicture.asset(AppAssets.icWhatsApp, width: 36, height: 36),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: _isSubmitting ? null : _submit,
                icon: const Icon(Icons.send),
                label: const Text('Kirim Laporan', style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Formulir Pelaporan Bullying (LaBu)',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Laporan Bersifat Anonim',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 8),
                          RadioGroup<String>(
                            groupValue: _role,
                            onChanged: (role) => setState(() => _role = role),
                            child: const Row(
                              children: [
                                Expanded(
                                  child: RadioListTile<String>(
                                    value: Report.roleVictim,
                                    title: Text('Korban'),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<String>(
                                    value: Report.roleWitness,
                                    title: Text('Saksi'),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _dateController,
                            readOnly: true,
                            onTap: _pickDate,
                            decoration: const InputDecoration(
                              labelText: 'Tanggal Bullying',
                              suffixIcon: Icon(Icons.calendar_today_outlined),
                            ),
                            validator: _required('Tanggal tidak boleh kosong'),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _locationController,
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(labelText: 'Lokasi Bullying'),
                            validator: _required('Lokasi tidak boleh kosong'),
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            initialValue: _frequency,
                            decoration: const InputDecoration(labelText: 'Frekuensi Bullying'),
                            items: [
                              for (final frequency in AppConstants.reportFrequencies)
                                DropdownMenuItem(value: frequency, child: Text(frequency)),
                            ],
                            onChanged: (frequency) => setState(() => _frequency = frequency),
                            validator: (value) =>
                                value == null ? 'Frekuensi tidak boleh kosong' : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _descriptionController,
                            minLines: 4,
                            maxLines: 8,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration(
                              labelText: 'Deskripsi (Kronologi)',
                              alignLabelWithHint: true,
                            ),
                            validator: _required('Deskripsi tidak boleh kosong'),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _whatsappController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9+ \-]')),
                            ],
                            decoration: const InputDecoration(
                              labelText: 'Nomor yang dapat dihubungi (WhatsApp)',
                            ),
                            validator: _validateWhatsApp,
                          ),
                          const SizedBox(height: 16),
                          if (proof != null) ...[
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    proof,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: IconButton.filledTonal(
                                    tooltip: 'Hapus gambar',
                                    onPressed: () => setState(() => _proof = null),
                                    icon: const Icon(Icons.close),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                          ],
                          OutlinedButton.icon(
                            onPressed: _isSubmitting ? null : _pickProof,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.toscaDark,
                              side: const BorderSide(color: AppColors.toscaDark),
                            ),
                            icon: const Icon(Icons.upload_outlined),
                            label: Text(
                              proof == null ? 'Unggah Gambar/Bukti' : 'Ganti Gambar/Bukti',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_isSubmitting)
              const Positioned.fill(
                child: ColoredBox(
                  color: Colors.black26,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
