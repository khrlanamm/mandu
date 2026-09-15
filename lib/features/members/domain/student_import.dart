/// Baris siswa yang siap diimpor.
class StudentInput {
  const StudentInput({required this.nisn, required this.name, required this.kelas});

  final String nisn;
  final String name;
  final String kelas;

  Map<String, String> toJson() => {'nisn': nisn, 'name': name, 'kelas': kelas};
}

/// Baris CSV yang tidak valid beserta alasannya (nomor baris dimulai dari 1).
class InvalidStudentRow {
  const InvalidStudentRow({required this.line, required this.reason});

  final int line;
  final String reason;
}

/// Hasil impor per siswa dari `members-importStudents`.
class StudentImportResult {
  const StudentImportResult({
    required this.nisn,
    required this.name,
    required this.kelas,
    required this.status,
    this.password,
    this.message,
  });

  factory StudentImportResult.fromJson(Map<String, dynamic> json) => StudentImportResult(
        nisn: json['nisn'] as String,
        name: json['name'] as String,
        kelas: json['kelas'] as String,
        status: json['status'] as String,
        password: json['password'] as String?,
        message: json['message'] as String?,
      );

  final String nisn;
  final String name;
  final String kelas;

  /// created | exists | duplicate | error
  final String status;
  final String? password;
  final String? message;

  bool get created => status == 'created';
}

final _nisnPattern = RegExp(r'^\d{4,20}$');

/// Ubah baris CSV menjadi daftar siswa. Mendukung header (nisn, nama, kelas)
/// dalam urutan apa pun; tanpa header dianggap urutan NISN, nama, kelas.
({List<StudentInput> students, List<InvalidStudentRow> invalid}) readStudentRows(List<List<String>> rows) {
  if (rows.isEmpty) return (students: const [], invalid: const []);

  final header = rows.first.map((cell) => cell.trim().toLowerCase()).toList();
  final hasHeader = header.contains('nisn') || header.contains('nis');
  int column(List<String> names, int fallback) {
    if (!hasHeader) return fallback;
    final index = header.indexWhere(names.contains);
    return index;
  }

  final nisnColumn = column(['nisn', 'nis'], 0);
  final nameColumn = column(['nama', 'name', 'nama lengkap', 'nama siswa'], 1);
  final kelasColumn = column(['kelas', 'class', 'rombel'], 2);

  final students = <StudentInput>[];
  final invalid = <InvalidStudentRow>[];
  if (nisnColumn < 0 || nameColumn < 0 || kelasColumn < 0) {
    return (students: students, invalid: [const InvalidStudentRow(line: 1, reason: 'Header wajib memuat kolom nisn, nama, dan kelas.')]);
  }

  for (var i = hasHeader ? 1 : 0; i < rows.length; i++) {
    final row = rows[i];
    String cell(int index) => index < row.length ? row[index].trim() : '';
    final nisn = cell(nisnColumn).replaceAll(RegExp(r'\s'), '');
    final name = cell(nameColumn);
    final kelas = cell(kelasColumn);
    final line = i + 1;

    if (!_nisnPattern.hasMatch(nisn)) {
      invalid.add(InvalidStudentRow(line: line, reason: 'NISN "$nisn" harus 4–20 angka.'));
    } else if (name.length < 2) {
      invalid.add(InvalidStudentRow(line: line, reason: 'Nama siswa kosong.'));
    } else if (kelas.isEmpty) {
      invalid.add(InvalidStudentRow(line: line, reason: 'Kelas kosong.'));
    } else {
      students.add(StudentInput(nisn: nisn, name: name, kelas: kelas));
    }
  }
  return (students: students, invalid: invalid);
}
