import 'package:flutter_test/flutter_test.dart';
import 'package:mandu/core/domain/school_code.dart';
import 'package:mandu/core/utils/csv.dart';
import 'package:mandu/features/members/domain/student_import.dart';

void main() {
  group('parseSchoolCode', () {
    test('menerima kode langsung dan tautan QR MANDU', () {
      expect(parseSchoolCode(' demo01 '), 'DEMO01');
      expect(parseSchoolCode('https://teman-ngadu.web.app/s/DEMO01'), 'DEMO01');
      expect(parseSchoolCode('https://teman-ngadu.web.app/s/demo01/aspirasi'), 'DEMO01');
    });

    test('menolak teks yang bukan kode sekolah', () {
      expect(parseSchoolCode(null), isNull);
      expect(parseSchoolCode('AB'), isNull);
      expect(parseSchoolCode('https://contoh.com/halaman'), isNull);
      expect(parseSchoolCode('kode dengan spasi'), isNull);
    });
  });

  group('parseCsv', () {
    test('mendukung titik koma, tanda kutip, BOM, dan baris kosong', () {
      final rows = parseCsv('﻿nisn;nama;kelas\r\n0061;"Santoso; Budi";X-1\r\n\r\n0062;"Siti ""Ami""";X-2');
      expect(rows, [
        ['nisn', 'nama', 'kelas'],
        ['0061', 'Santoso; Budi', 'X-1'],
        ['0062', 'Siti "Ami"', 'X-2'],
      ]);
    });

    test('toCsv meng-escape nilai yang perlu tanda kutip', () {
      expect(toCsv([
        ['a', 'b,c', 'd"e'],
      ]), 'a,"b,c","d""e"');
    });
  });

  group('readStudentRows', () {
    test('memakai header dalam urutan apa pun dan melaporkan baris tidak valid', () {
      final result = readStudentRows([
        ['Kelas', 'Nama', 'NISN'],
        ['X-1', 'Budi Santoso', '0061234567'],
        ['X-2', 'Siti', '12AB'],
        ['', 'Tanpa Kelas', '0069999999'],
      ]);
      expect(result.students.map((student) => student.nisn), ['0061234567']);
      expect(result.students.single.kelas, 'X-1');
      expect(result.invalid.map((row) => row.line), [3, 4]);
    });

    test('tanpa header dianggap urutan NISN, nama, kelas', () {
      final result = readStudentRows([
        ['0061234567', 'Budi Santoso', 'X-1'],
      ]);
      expect(result.students.single.name, 'Budi Santoso');
      expect(result.invalid, isEmpty);
    });
  });
}
