/// Parser CSV sederhana: pemisah koma atau titik koma (Excel Indonesia), mendukung tanda kutip.
List<List<String>> parseCsv(String input) {
  final text = input.startsWith('﻿') ? input.substring(1) : input;
  final firstLine = text.split(RegExp(r'\r?\n')).firstWhere((line) => line.trim().isNotEmpty, orElse: () => '');
  final delimiter = firstLine.split(';').length > firstLine.split(',').length ? ';' : ',';

  final rows = <List<String>>[];
  var row = <String>[];
  final field = StringBuffer();
  var inQuotes = false;

  void endRow() {
    row.add(field.toString());
    field.clear();
    if (row.any((cell) => cell.trim().isNotEmpty)) rows.add(row);
    row = <String>[];
  }

  for (var i = 0; i < text.length; i++) {
    final char = text[i];
    if (inQuotes) {
      if (char == '"') {
        if (i + 1 < text.length && text[i + 1] == '"') {
          field.write('"');
          i++;
        } else {
          inQuotes = false;
        }
      } else {
        field.write(char);
      }
    } else if (char == '"') {
      inQuotes = true;
    } else if (char == delimiter) {
      row.add(field.toString());
      field.clear();
    } else if (char == '\n' || char == '\r') {
      if (char == '\r' && i + 1 < text.length && text[i + 1] == '\n') i++;
      endRow();
    } else {
      field.write(char);
    }
  }
  endRow();
  return rows;
}

String toCsv(List<List<Object?>> rows) => rows.map((row) => row.map(_escape).join(',')).join('\r\n');

String _escape(Object? value) {
  final text = value?.toString() ?? '';
  return RegExp(r'[",;\r\n]').hasMatch(text) ? '"${text.replaceAll('"', '""')}"' : text;
}
