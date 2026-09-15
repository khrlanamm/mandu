import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mandu/core/utils/formatters.dart';

void main() {
  setUpAll(() => initializeDateFormatting('id_ID'));

  group('toWhatsAppDigits', () {
    test('mengubah awalan 0 menjadi 62', () {
      expect(toWhatsAppDigits('0857-3177-4570'), '6285731774570');
    });

    test('mempertahankan nomor yang sudah berawalan 62 atau +62', () {
      expect(toWhatsAppDigits('6285731774570'), '6285731774570');
      expect(toWhatsAppDigits('+62 857 3177 4570'), '6285731774570');
    });
  });

  test('formatReportTime selalu memakai WIB', () {
    expect(formatReportTime(DateTime.utc(2026, 9, 15, 13, 5)), '15 September 2026 20:05 WIB');
  });
}
