import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../../core/domain/catalog.dart';
import '../../auth/application/session_controller.dart';
import '../data/stats_repository.dart';
import '../domain/school_stats.dart';

/// Format durasi rata-rata: di bawah 1 jam ditulis "<1 jam" agar tidak tampil "0.0 jam".
String formatHours(double? hours) {
  if (hours == null) return '-';
  if (hours < 1) return '<1 jam';
  if (hours < 48) return '${hours.toStringAsFixed(hours < 10 ? 1 : 0)} jam';
  return '${(hours / 24).toStringAsFixed(1)} hari';
}

/// Dashboard sekolah untuk admin, pimpinan, dan Tim Verifikasi.
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _months = 6;

  Future<void> _exportCsv(SchoolStats stats, String schoolName) async {
    final rows = <List<String>>[
      ['Bagian', 'Rincian', 'Nilai'],
      ['Ringkasan', 'Total laporan', '${stats.tickets.total}'],
      ['Ringkasan', 'Selesai', '${stats.tickets.selesai}'],
      ['Ringkasan', 'Sedang diproses', '${stats.tickets.diproses}'],
      ['Ringkasan', 'Menunggu verifikasi', '${stats.tickets.menungguVerifikasi}'],
      ['Ringkasan', 'Lewat batas waktu', '${stats.tickets.overdue}'],
      ['Ringkasan', 'Rata-rata verifikasi (jam)', '${stats.tickets.avgVerifyHours ?? '-'}'],
      ['Ringkasan', 'Rata-rata penyelesaian (jam)', '${stats.tickets.avgResolveHours ?? '-'}'],
      ['Ringkasan', 'Jumlah penilaian', '${stats.tickets.ratingCount}'],
      ['Ringkasan', 'Rata-rata kepuasan', '${stats.tickets.avgRating ?? '-'}'],
      for (final entry in stats.tickets.byCategory.entries)
        ['Kategori', kCategoryLabels[entry.key] ?? entry.key, '${entry.value}'],
      for (final entry in stats.tickets.byStatus.entries) ['Status', entry.key, '${entry.value}'],
      for (final unit in stats.tickets.units)
        ['Unit', unit.unitName, 'total ${unit.total}; selesai ${unit.selesai}; rata-rata ${unit.avgResolveHours ?? '-'} jam; tepat waktu ${unit.onTimePercent ?? '-'}%'],
      for (final month in stats.tickets.monthly) ['Bulanan', month.month, 'total ${month.total}; selesai ${month.selesai}'],
      for (final location in stats.tickets.topLocations) ['Lokasi', location.location, '${location.count}'],
      ['Aspirasi', 'Total', '${stats.aspirations.total}'],
      ['Aspirasi', 'Tampil di papan', '${stats.aspirations.published}'],
      ['Aspirasi', 'Dukungan', '${stats.aspirations.supports}'],
      ['Layanan BK', 'Permintaan bantuan', '${stats.care.helpTotal}'],
      ['Layanan BK', 'Percakapan curhat', '${stats.care.conversations}'],
      ['Anggota', 'Aktif', '${stats.members.total}'],
    ];
    final csv = rows
        .map((row) => row.map((cell) => '"${cell.replaceAll('"', '""')}"').join(','))
        .join('\n');
    final name = 'statistik-mandu-${stats.from}-${_months}bulan.csv';
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile.fromData(utf8.encode(csv), mimeType: 'text/csv', name: name)],
        fileNameOverrides: [name],
        subject: 'Statistik MANDU $schoolName',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final account = ref.watch(currentAccountProvider);
    final schoolId = account?.schoolId;
    if (schoolId == null) return const Scaffold(body: LoadingView());
    final statsAsync = ref.watch(schoolStatsProvider(schoolId, months: _months));

    return Scaffold(
      appBar: AppBar(
        leading: context.canPop()
            ? null
            : IconButton(
                tooltip: 'Tutup',
                icon: const Icon(Icons.close_rounded),
                onPressed: () => context.go(Routes.staffHome),
              ),
        title: const Text('Dashboard'),
        actions: [
          PopupMenuButton<int>(
            tooltip: 'Periode',
            icon: const Icon(Icons.date_range_rounded),
            onSelected: (months) => setState(() => _months = months),
            itemBuilder: (context) => [
              for (final months in [3, 6, 12])
                PopupMenuItem(value: months, child: Text('$months bulan terakhir')),
            ],
          ),
          IconButton(
            tooltip: 'Ekspor CSV',
            onPressed: statsAsync.value == null
                ? null
                : () => runGuarded(context, () => _exportCsv(statsAsync.value!, account?.schoolName ?? '')),
            icon: const Icon(Icons.download_rounded),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(schoolStatsProvider(schoolId, months: _months)),
        child: AsyncValueView(
          value: statsAsync,
          onRetry: () => ref.invalidate(schoolStatsProvider(schoolId, months: _months)),
          data: (stats) => _StatsBody(stats: stats, months: _months),
        ),
      ),
    );
  }
}

class _StatsBody extends StatelessWidget {
  const _StatsBody({required this.stats, required this.months});

  final SchoolStats stats;
  final int months;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final tickets = stats.tickets;
    final muted = context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant);

    return ListView(
      padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.md, Gaps.lg, Gaps.xxl),
      children: [
        ContentWidth(
          maxWidth: 900,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Ringkasan $months bulan terakhir', style: context.textStyles.titleMedium),
              Text('Sejak ${stats.from}', style: muted),
              const SizedBox(height: Gaps.md),
              GridView.count(
                crossAxisCount: MediaQuery.sizeOf(context).width > 600 ? 5 : 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: Gaps.md,
                crossAxisSpacing: Gaps.md,
                childAspectRatio: 1.1,
                children: [
                  _MetricTile(label: 'Total laporan', value: '${tickets.total}', icon: Icons.campaign_rounded, tone: palette.lapor),
                  _MetricTile(label: 'Selesai', value: '${tickets.selesai}', icon: Icons.check_circle_rounded, tone: palette.success),
                  _MetricTile(label: 'Diproses', value: '${tickets.diproses}', icon: Icons.construction_rounded, tone: palette.curhat),
                  _MetricTile(
                    label: 'Menunggu verifikasi',
                    value: '${tickets.menungguVerifikasi}',
                    icon: Icons.fact_check_outlined,
                    tone: palette.info,
                  ),
                  _MetricTile(label: 'Lewat batas', value: '${tickets.overdue}', icon: Icons.timer_off_outlined, tone: palette.danger),
                ],
              ),
              const SizedBox(height: Gaps.xl),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(Gaps.lg),
                  child: Row(
                    children: [
                      Expanded(
                        child: _Metric(
                          title: 'Kepuasan pelapor',
                          value: tickets.avgRating == null ? '-' : '${tickets.avgRating}/5',
                          hint: '${tickets.ratingCount} penilaian',
                        ),
                      ),
                      Expanded(
                        child: _Metric(
                          title: 'Rata-rata verifikasi',
                          value: formatHours(tickets.avgVerifyHours),
                          hint: 'dari laporan masuk',
                        ),
                      ),
                      Expanded(
                        child: _Metric(
                          title: 'Rata-rata selesai',
                          value: formatHours(tickets.avgResolveHours),
                          hint: 'sampai ditindaklanjuti',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (tickets.total > 0) ...[
                const SizedBox(height: Gaps.xl),
                const SectionHeader(title: 'Tren bulanan'),
                const SizedBox(height: Gaps.md),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(Gaps.md, Gaps.xl, Gaps.md, Gaps.md),
                    child: SizedBox(height: 200, child: _MonthlyChart(monthly: tickets.monthly)),
                  ),
                ),
                const SizedBox(height: Gaps.xl),
                const SectionHeader(title: 'Kategori laporan'),
                const SizedBox(height: Gaps.md),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(Gaps.lg),
                    child: _CategoryChart(byCategory: tickets.byCategory),
                  ),
                ),
              ],
              if (tickets.units.any((unit) => unit.total > 0)) ...[
                const SizedBox(height: Gaps.xl),
                const SectionHeader(title: 'Kinerja unit'),
                const SizedBox(height: Gaps.md),
                Card(
                  child: Column(
                    children: [
                      for (final unit in tickets.units.where((unit) => unit.total > 0))
                        ListTile(
                          title: Text(unit.unitName),
                          subtitle: Text(
                            '${unit.selesai} dari ${unit.total} selesai'
                            '${unit.avgResolveHours == null ? '' : ' · rata-rata ${formatHours(unit.avgResolveHours)}'}',
                          ),
                          trailing: unit.onTimePercent == null
                              ? null
                              : StatusPill(
                                  label: '${unit.onTimePercent}% tepat waktu',
                                  tone: unit.onTimePercent! >= 80 ? palette.success : palette.warning,
                                ),
                        ),
                    ],
                  ),
                ),
              ],
              if (tickets.topLocations.isNotEmpty) ...[
                const SizedBox(height: Gaps.xl),
                const SectionHeader(title: 'Lokasi yang paling sering dilaporkan'),
                const SizedBox(height: Gaps.md),
                Card(
                  child: Column(
                    children: [
                      for (final location in tickets.topLocations)
                        ListTile(
                          leading: const Icon(Icons.place_outlined),
                          title: Text(location.location),
                          trailing: Text('${location.count}', style: context.textStyles.titleMedium),
                        ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: Gaps.xl),
              const SectionHeader(title: 'Layanan lain'),
              const SizedBox(height: Gaps.md),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(Gaps.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Aspirasi', style: context.textStyles.titleSmall),
                      Text(
                        '${stats.aspirations.total} aspirasi · ${stats.aspirations.published} tampil di papan · ${stats.aspirations.supports} dukungan',
                        style: context.textStyles.bodyMedium,
                      ),
                      const SizedBox(height: Gaps.md),
                      Text('Layanan BK', style: context.textStyles.titleSmall),
                      Text(
                        '${stats.care.helpTotal} permintaan bantuan · ${stats.care.conversations} percakapan curhat '
                        '(${stats.care.conversationsActive} berlangsung)',
                        style: context.textStyles.bodyMedium,
                      ),
                      Text('Isi curhat dan permintaan bantuan tidak pernah ditampilkan di dashboard.', style: muted),
                      const SizedBox(height: Gaps.md),
                      Text('Anggota aktif', style: context.textStyles.titleSmall),
                      Text(
                        stats.members.byRole.entries
                            .where((entry) => entry.value > 0)
                            .map((entry) => '${entry.value} ${entry.key}')
                            .join(' · '),
                        style: context.textStyles.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.label, required this.value, required this.icon, required this.tone});

  final String label;
  final String value;
  final IconData icon;
  final ToneColors tone;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: tone.container, borderRadius: BorderRadius.circular(Radii.lg)),
      child: Padding(
        padding: const EdgeInsets.all(Gaps.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: tone.main, size: 20),
            const Spacer(),
            Text(value, style: context.textStyles.headlineMedium?.copyWith(color: tone.onContainer)),
            Text(label, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textStyles.labelMedium?.copyWith(color: tone.onContainer)),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.title, required this.value, required this.hint});

  final String title;
  final String value;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textStyles.labelMedium?.copyWith(color: context.colors.onSurfaceVariant)),
        Text(value, style: context.textStyles.titleLarge),
        Text(hint, style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant)),
      ],
    );
  }
}

class _MonthlyChart extends StatelessWidget {
  const _MonthlyChart({required this.monthly});

  final List<MonthlyCount> monthly;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final maxValue = monthly.fold<int>(1, (max, month) => month.total > max ? month.total : max);
    return BarChart(
      BarChartData(
        maxY: (maxValue * 1.2).ceilToDouble(),
        gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: (maxValue / 3).ceilToDouble()),
        borderData: FlBorderData(show: false),
        barTouchData: const BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 28, interval: (maxValue / 3).ceilToDouble())),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= monthly.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: Gaps.xs),
                  child: Text(monthly[index].month.substring(5), style: context.textStyles.labelSmall),
                );
              },
            ),
          ),
        ),
        barGroups: [
          for (var index = 0; index < monthly.length; index++)
            BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(toY: monthly[index].total.toDouble(), color: palette.lapor.main, width: 10, borderRadius: BorderRadius.circular(4)),
                BarChartRodData(toY: monthly[index].selesai.toDouble(), color: palette.success.main, width: 10, borderRadius: BorderRadius.circular(4)),
              ],
            ),
        ],
      ),
    );
  }
}

class _CategoryChart extends StatelessWidget {
  const _CategoryChart({required this.byCategory});

  final Map<String, int> byCategory;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final colors = [
      palette.lapor.main,
      palette.curhat.main,
      palette.aspirasi.main,
      palette.bantuan.main,
      palette.edukasi.main,
      palette.success.main,
      palette.neutral.main,
    ];
    final entries = byCategory.entries.where((entry) => entry.value > 0).toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    if (entries.isEmpty) return const SizedBox.shrink();
    final total = entries.fold<int>(0, (sum, entry) => sum + entry.value);

    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 48,
              sections: [
                for (var index = 0; index < entries.length; index++)
                  PieChartSectionData(
                    value: entries[index].value.toDouble(),
                    color: colors[index % colors.length],
                    title: '${(entries[index].value / total * 100).round()}%',
                    radius: 42,
                    titleStyle: context.textStyles.labelSmall?.copyWith(color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: Gaps.md),
        Wrap(
          spacing: Gaps.md,
          runSpacing: Gaps.sm,
          children: [
            for (var index = 0; index < entries.length; index++)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(color: colors[index % colors.length], borderRadius: BorderRadius.circular(3)),
                  ),
                  const SizedBox(width: Gaps.xs),
                  Text(
                    '${kCategoryLabels[entries[index].key] ?? entries[index].key} (${entries[index].value})',
                    style: context.textStyles.labelMedium,
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

