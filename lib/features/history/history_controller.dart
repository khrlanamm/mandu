import 'package:flutter/material.dart';

import '../../core/utils/ui_helpers.dart';
import '../../data/models/report.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/report_repository.dart';

enum StatusFilter {
  all('Semua Laporan'),
  reported('Terlapor'),
  handled('Ditangani');

  const StatusFilter(this.label);

  final String label;

  bool matches(Report report) => switch (this) {
        StatusFilter.all => true,
        StatusFilter.reported => report.isReported,
        StatusFilter.handled => report.isHandled,
      };
}

class ReportStats {
  const ReportStats({required this.count, required this.percentage});

  factory ReportStats.of(List<Report> reports, bool Function(Report) test) {
    if (reports.isEmpty) return const ReportStats(count: 0, percentage: 0);
    final count = reports.where(test).length;
    return ReportStats(count: count, percentage: count * 100 / reports.length);
  }

  final int count;
  final double percentage;
}

/// Laporan yang dibuat dalam [range] (tanggal lokal, inklusif di kedua ujung).
List<Report> filterByDateRange(List<Report> reports, DateTimeRange? range) {
  if (range == null) return reports;
  final start = DateTime(range.start.year, range.start.month, range.start.day);
  final endExclusive = DateTime(range.end.year, range.end.month, range.end.day + 1);
  return reports.where((report) {
    final time = report.timestamp.toLocal();
    return !time.isBefore(start) && time.isBefore(endExclusive);
  }).toList();
}

/// State Riwayat Laporan: admin melihat semua laporan, pengguna hanya laporannya sendiri.
class HistoryController extends ChangeNotifier {
  HistoryController({ReportRepository? reports, AuthRepository? auth})
      : _reports = reports ?? ReportRepository.instance,
        _auth = auth ?? AuthRepository.instance;

  final ReportRepository _reports;
  final AuthRepository _auth;

  List<Report> _allReports = const [];
  DateTimeRange? _dateRange;
  StatusFilter _statusFilter = StatusFilter.all;
  bool _isLoading = false;
  bool _hasLoaded = false;
  String? _errorMessage;
  bool _disposed = false;

  List<Report> get allReports => _allReports;
  DateTimeRange? get dateRange => _dateRange;
  StatusFilter get statusFilter => _statusFilter;
  bool get isLoading => _isLoading;
  bool get hasLoaded => _hasLoaded;
  String? get errorMessage => _errorMessage;

  List<Report> get _reportsInRange => filterByDateRange(_allReports, _dateRange);

  ReportStats get reportedStats => ReportStats.of(_reportsInRange, (r) => r.isReported);
  ReportStats get handledStats => ReportStats.of(_reportsInRange, (r) => r.isHandled);
  List<Report> get visibleReports => _reportsInRange.where(_statusFilter.matches).toList();

  Future<void> load() async {
    final user = _auth.currentUser;
    if (user == null) {
      _errorMessage = 'Pengguna tidak terautentikasi.';
      _notify();
      return;
    }

    _isLoading = true;
    _notify();
    try {
      final isAdmin = await _auth.isAdmin(user.uid);
      _allReports = await _reports.fetchHistory(userId: user.uid, isAdmin: isAdmin);
      _errorMessage = null;
    } catch (e) {
      debugPrint('Gagal memuat riwayat laporan: $e');
      _errorMessage = 'Gagal memuat data: ${describeError(e)}';
    } finally {
      _isLoading = false;
      _hasLoaded = true;
      _notify();
    }
  }

  void setDateRange(DateTimeRange? range) {
    _dateRange = range;
    _notify();
  }

  void setStatusFilter(StatusFilter filter) {
    _statusFilter = filter;
    _notify();
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
