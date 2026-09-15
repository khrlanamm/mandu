/// Akun demo Emulator Suite (dibuat oleh functions/scripts/seed.ts). Hanya tampil dengan MANDU_EMULATOR=true.
class DemoAccount {
  const DemoAccount({required this.label, required this.email, required this.description});

  final String label;
  final String email;
  final String description;
}

const kDemoPassword = 'mandu123';

const kDemoAccounts = [
  DemoAccount(label: 'Superadmin', email: 'superadmin@mandu.test', description: 'Kelola semua sekolah'),
  DemoAccount(label: 'Admin Sekolah', email: 'admin@smandemo.sch.id', description: 'SMA Negeri Demo MANDU'),
  DemoAccount(label: 'Pimpinan', email: 'kepsek@smandemo.sch.id', description: 'Kepala sekolah'),
  DemoAccount(label: 'Konselor (BK)', email: 'bk@smandemo.sch.id', description: 'Curhat, bantuan, keamanan'),
  DemoAccount(label: 'Petugas Sarpras', email: 'sarpras@smandemo.sch.id', description: 'Fasilitas & kebersihan'),
  DemoAccount(label: 'Petugas Kurikulum', email: 'kurikulum@smandemo.sch.id', description: 'Pembelajaran'),
  DemoAccount(label: 'Siswa', email: 'siswa@smandemo.sch.id', description: 'Budi Santoso, XI IPA 1'),
  DemoAccount(label: 'Siswa 2', email: 'siswa2@smandemo.sch.id', description: 'Siti Aminah, X-2'),
  DemoAccount(label: 'Calon siswa', email: 'calon.siswa@mandu.test', description: 'Menunggu persetujuan'),
  DemoAccount(label: 'Admin sekolah lain', email: 'admin@smpharapan.sch.id', description: 'SMP Harapan Bangsa'),
];
