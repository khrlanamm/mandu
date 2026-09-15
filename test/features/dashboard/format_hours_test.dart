import 'package:flutter_test/flutter_test.dart';
import 'package:mandu/features/dashboard/presentation/dashboard_screen.dart';

void main() {
  test('durasi rata-rata ditampilkan dalam satuan yang mudah dibaca', () {
    expect(formatHours(null), '-');
    // Data uji coba sering selesai dalam hitungan detik; jangan tampilkan "0.0 jam".
    expect(formatHours(0), '<1 jam');
    expect(formatHours(0.4), '<1 jam');
    expect(formatHours(3.5), '3.5 jam');
    expect(formatHours(12.4), '12 jam');
    expect(formatHours(47.9), '48 jam');
    expect(formatHours(60), '2.5 hari');
  });
}
