final _codePattern = RegExp(r'^[A-Z0-9]{4,12}$');

bool isValidSchoolCode(String value) => _codePattern.hasMatch(value.trim().toUpperCase());

/// Ambil kode sekolah dari teks QR: kode langsung atau tautan `.../s/{KODE}`.
String? parseSchoolCode(String? raw) {
  if (raw == null) return null;
  var text = raw.trim();
  final uri = Uri.tryParse(text);
  if (uri != null && uri.hasScheme) {
    final segments = uri.pathSegments;
    final index = segments.indexOf('s');
    if (index < 0 || index + 1 >= segments.length) return null;
    text = segments[index + 1];
  }
  final code = text.toUpperCase();
  return _codePattern.hasMatch(code) ? code : null;
}
