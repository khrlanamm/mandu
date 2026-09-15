import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../core/utils/ui_helpers.dart';
import '../../core/widgets/label_chip.dart';
import '../../core/widgets/shimmer_network_image.dart';
import '../../data/models/report.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/report_repository.dart';

class ReportDetailScreen extends StatefulWidget {
  const ReportDetailScreen({super.key, required this.report});

  final Report report;

  @override
  State<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  late Report _report = widget.report;

  /// `null` selama status admin masih dicek.
  bool? _isAdmin;
  bool _isBusy = false;

  @override
  void initState() {
    super.initState();
    AuthRepository.instance.isAdmin().then((isAdmin) {
      if (mounted) setState(() => _isAdmin = isAdmin);
    });
  }

  bool get _canCancel =>
      _isAdmin == false &&
      AuthRepository.instance.currentUser?.uid == _report.userId &&
      _report.isReported;

  Future<void> _setHandled(bool handled) async {
    final newStatus = handled ? Report.statusHandled : Report.statusReported;
    final confirmed = await showConfirmDialog(
      context,
      title: 'Ubah Status',
      message: 'Apakah Anda yakin ingin mengubah status laporan menjadi ${newStatus.toUpperCase()}?',
    );
    if (!confirmed || !mounted) return;

    setState(() => _isBusy = true);
    try {
      await ReportRepository.instance.updateStatus(_report.id, newStatus);
      if (!mounted) return;
      setState(() => _report = _report.copyWith(status: newStatus));
      showSnack(context, 'Status berhasil diperbarui');
    } catch (e) {
      if (mounted) showSnack(context, 'Operasi gagal: ${describeError(e)}');
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  Future<void> _cancelReport() async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Batalkan Laporan',
      message: 'Apakah Anda yakin ingin membatalkan laporan ini? Tindakan ini tidak dapat diurungkan.',
      destructive: true,
    );
    if (!confirmed || !mounted) return;

    setState(() => _isBusy = true);
    try {
      await ReportRepository.instance.deleteReport(_report.id);
      if (!mounted) return;
      showSnack(context, 'Laporan berhasil dibatalkan');
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      setState(() => _isBusy = false);
      showSnack(context, 'Operasi gagal: ${describeError(e)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = _isAdmin ?? false;
    final Widget? bottomAction;
    if (isAdmin) {
      bottomAction = FilledButton.icon(
        onPressed: _isBusy ? null : () => openWhatsApp(context, _report.nomorWhatsapp),
        icon: SvgPicture.asset(AppAssets.icWhatsApp, width: 22, height: 22),
        label: const Text('Hubungi Pelapor'),
      );
    } else if (_canCancel) {
      bottomAction = FilledButton.icon(
        style: FilledButton.styleFrom(backgroundColor: AppColors.error),
        onPressed: _isBusy ? null : _cancelReport,
        icon: const Icon(Icons.delete_outline),
        label: const Text('Batalkan Laporan'),
      );
    } else {
      bottomAction = null;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Rincian Laporan')),
      bottomNavigationBar: bottomAction == null
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: SizedBox(height: 48, child: bottomAction),
              ),
            ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  LabelChip.status(_report.status, fontSize: 12),
                  const SizedBox(width: 8),
                  LabelChip.role(_report.peran, fontSize: 12),
                ],
              ),
              const SizedBox(height: 16),
              ShimmerNetworkImage(
                url: _report.urlBukti,
                width: double.infinity,
                height: 200,
                borderRadius: BorderRadius.circular(12),
              ),
              _DetailItem(label: 'Waktu Lapor', value: formatReportTime(_report.timestamp)),
              _DetailItem(label: 'Tanggal Kejadian', value: _report.tanggalBullying),
              _DetailItem(label: 'Lokasi Kejadian', value: _report.lokasi),
              _DetailItem(
                label: 'Frekuensi Kejadian',
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Chip(label: Text(_report.frekuensi)),
                ),
              ),
              _DetailItem(label: 'Deskripsi Lengkap', value: _report.deskripsi),
              _DetailItem(label: 'Nomor Pelapor', value: _report.nomorWhatsapp),
              if (isAdmin)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Tandai sebagai Ditangani'),
                    value: _report.isHandled,
                    onChanged: _isBusy ? null : _setHandled,
                  ),
                ),
            ],
          ),
          if (_isBusy)
            const Positioned.fill(
              child: ColoredBox(
                color: Colors.black26,
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  const _DetailItem({required this.label, this.value, this.child})
      : assert(value != null || child != null);

  final String label;
  final String? value;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          child ?? Text(value!, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
