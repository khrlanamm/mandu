enum SchoolRole {
  admin('Admin Sekolah'),
  pimpinan('Pimpinan'),
  konselor('Konselor (BK)'),
  petugas('Petugas Unit'),
  siswa('Siswa');

  const SchoolRole(this.label);

  final String label;

  bool get isStaff => this != SchoolRole.siswa;

  static SchoolRole? tryParse(Object? value) => SchoolRole.values.asNameMap()[value];

  /// Peran yang bisa diberikan lewat undangan staf.
  static const staffRoles = [admin, pimpinan, konselor, petugas];
}

enum AccountStatus { none, pending, active, rejected, removed }
