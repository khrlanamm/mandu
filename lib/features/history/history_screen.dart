import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/report.dart';
import '../detail/report_detail_screen.dart';
import 'history_controller.dart';
import 'widgets/report_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _controller = HistoryController();

  @override
  void initState() {
    super.initState();
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _controller.dateRange,
      helpText: 'Pilih Rentang Tanggal',
      saveText: 'Simpan',
    );
    if (picked != null) _controller.setDateRange(picked);
  }

  Future<void> _openDetail(Report report) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => ReportDetailScreen(report: report)),
    );
    // Status bisa berubah atau laporan dibatalkan di halaman detail.
    if (mounted) _controller.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Laporan')),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          return RefreshIndicator(
            onRefresh: _controller.load,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + MediaQuery.paddingOf(context).bottom),
              children: [
                _DateRangeField(
                  range: _controller.dateRange,
                  onTap: _pickDateRange,
                  onClear: () => _controller.setDateRange(null),
                ),
                const SizedBox(height: 12),
                _StatsCard(
                  reported: _controller.reportedStats,
                  handled: _controller.handledStats,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<StatusFilter>(
                  initialValue: _controller.statusFilter,
                  decoration: const InputDecoration(labelText: 'Filter Status Laporan'),
                  items: [
                    for (final filter in StatusFilter.values)
                      DropdownMenuItem(value: filter, child: Text(filter.label)),
                  ],
                  onChanged: (filter) {
                    if (filter != null) _controller.setStatusFilter(filter);
                  },
                ),
                const SizedBox(height: 4),
                ..._buildReports(),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildReports() {
    if (_controller.isLoading && !_controller.hasLoaded) {
      return const [
        Padding(
          padding: EdgeInsets.all(48),
          child: Center(child: CircularProgressIndicator()),
        ),
      ];
    }

    final reports = _controller.visibleReports;
    final String? emptyMessage;
    if (_controller.allReports.isEmpty) {
      emptyMessage = _controller.errorMessage ?? 'Belum ada laporan.';
    } else if (reports.isEmpty) {
      emptyMessage = 'Tidak ada laporan yang cocok dengan filter.';
    } else {
      emptyMessage = null;
    }

    if (emptyMessage != null) {
      return [
        Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            emptyMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
      ];
    }

    return [
      for (final report in reports)
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ReportCard(report: report, onTap: () => _openDetail(report)),
        ),
    ];
  }
}

class _DateRangeField extends StatelessWidget {
  const _DateRangeField({required this.range, required this.onTap, required this.onClear});

  final DateTimeRange? range;
  final VoidCallback onTap;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final range = this.range;
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Filter Rentang Tanggal',
                prefixIcon: Icon(Icons.date_range),
              ),
              child: Text(
                range == null
                    ? 'Semua Waktu'
                    : '${formatShortDate(range.start)} - ${formatShortDate(range.end)}',
              ),
            ),
          ),
        ),
        if (range != null)
          IconButton(
            tooltip: 'Hapus filter tanggal',
            onPressed: onClear,
            icon: const Icon(Icons.clear),
          ),
      ],
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard({required this.reported, required this.handled});

  final ReportStats reported;
  final ReportStats handled;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Statistik Laporan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 12),
            _StatRow(label: 'Terlapor', stats: reported, color: AppColors.statusReported),
            const SizedBox(height: 12),
            _StatRow(label: 'Ditangani', stats: handled, color: AppColors.statusHandled),
          ],
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.stats, required this.color});

  final String label;
  final ReportStats stats;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label : ${stats.count} (${stats.percentage.toStringAsFixed(1)}%)',
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: stats.percentage / 100,
          minHeight: 8,
          color: color,
          backgroundColor: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
