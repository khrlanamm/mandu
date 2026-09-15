import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mandu/data/models/report.dart';
import 'package:mandu/features/history/history_controller.dart';

Report _report(String id, String status, DateTime timestamp) {
  return Report(
    id: id,
    userId: 'user-1',
    peran: Report.roleVictim,
    status: status,
    tanggalBullying: '01/09/2026',
    lokasi: 'Kelas',
    frekuensi: 'Sering',
    deskripsi: '-',
    nomorWhatsapp: '081234567890',
    timestamp: timestamp,
  );
}

void main() {
  final reports = [
    _report('a', Report.statusReported, DateTime(2026, 9, 1, 8)),
    _report('b', Report.statusHandled, DateTime(2026, 9, 10, 23, 59)),
    _report('c', Report.statusHandled, DateTime(2026, 9, 11, 0, 1)),
  ];

  test('filterByDateRange inklusif sampai akhir hari terakhir', () {
    final range = DateTimeRange(start: DateTime(2026, 9, 1), end: DateTime(2026, 9, 10));
    expect(filterByDateRange(reports, range).map((r) => r.id), ['a', 'b']);
    expect(filterByDateRange(reports, null), hasLength(3));
  });

  test('ReportStats menghitung jumlah dan persentase', () {
    final handled = ReportStats.of(reports, (r) => r.isHandled);
    expect(handled.count, 2);
    expect(handled.percentage, closeTo(66.67, 0.01));
    expect(ReportStats.of(const [], (r) => r.isHandled).percentage, 0);
  });

  test('StatusFilter tidak peka huruf besar/kecil', () {
    final report = _report('d', 'DITANGANI', DateTime(2026, 9, 2));
    expect(StatusFilter.handled.matches(report), isTrue);
    expect(StatusFilter.reported.matches(report), isFalse);
    expect(StatusFilter.all.matches(report), isTrue);
  });
}
