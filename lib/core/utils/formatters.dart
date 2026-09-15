import 'package:intl/intl.dart';

const _wibOffset = Duration(hours: 7);

/// Contoh: "15 September 2026 20:30 WIB". Selalu WIB, tidak tergantung zona waktu perangkat.
String formatReportTime(DateTime time) {
  final wib = time.toUtc().add(_wibOffset);
  return '${DateFormat('dd MMMM yyyy HH:mm', 'id_ID').format(wib)} WIB';
}

/// Contoh: "15 Sep 2026".
String formatShortDate(DateTime date) => DateFormat('dd MMM yyyy', 'id_ID').format(date);

/// Normalisasi nomor (0857…, 62857…, +62 857…) menjadi digit internasional untuk wa.me.
String toWhatsAppDigits(String number) {
  final digits = number.replaceAll(RegExp(r'[^0-9]'), '');
  return digits.startsWith('0') ? '62${digits.substring(1)}' : digits;
}

Uri whatsAppUri(String number) => Uri.parse('https://wa.me/${toWhatsAppDigits(number)}');
