import '../../../core/domain/catalog.dart';
import '../../../core/domain/roles.dart';
import 'ticket.dart';

/// Hak staf atas laporan (sama dengan functions/src/tickets/access.ts).
class StaffTicketAccess {
  const StaffTicketAccess({required this.role, required this.units, required this.canVerify});

  final SchoolRole role;
  final List<String> units;
  final bool canVerify;

  bool get isVerifier => role == SchoolRole.admin || canVerify;

  bool get seesAll => role == SchoolRole.admin || role == SchoolRole.pimpinan || canVerify;

  /// Pimpinan tanpa hak verifikasi hanya membaca.
  bool get readOnly => role == SchoolRole.pimpinan && !canVerify;

  bool inUnit(Ticket ticket) =>
      (role == SchoolRole.konselor || role == SchoolRole.petugas) && ticket.unitId != null && units.contains(ticket.unitId);

  bool canHandle(Ticket ticket) => role == SchoolRole.admin || inUnit(ticket);

  /// Laporan yang menunggu tindakan staf ini.
  bool needsAction(Ticket ticket) =>
      (isVerifier && ticket.status == TicketStatus.menungguVerifikasi) || (ticket.status.inHandling && canHandle(ticket));
}

enum StaffTicketFilter {
  verifikasi('Perlu verifikasi'),
  ditangani('Ditangani'),
  menungguPelapor('Menunggu pelapor'),
  selesai('Selesai'),
  semua('Semua');

  const StaffTicketFilter(this.label);

  final String label;

  bool matches(Ticket ticket) => switch (this) {
        StaffTicketFilter.verifikasi => ticket.status == TicketStatus.menungguVerifikasi,
        StaffTicketFilter.ditangani => ticket.status.inHandling,
        StaffTicketFilter.menungguPelapor => ticket.status == TicketStatus.perluDilengkapi,
        StaffTicketFilter.selesai => ticket.status.isClosed,
        StaffTicketFilter.semua => true,
      };

  /// Filter yang relevan untuk peran staf.
  static List<StaffTicketFilter> availableFor(StaffTicketAccess access) => [
        if (access.seesAll) verifikasi,
        ditangani,
        if (access.seesAll) menungguPelapor,
        selesai,
        semua,
      ];

  static StaffTicketFilter initialFor(StaffTicketAccess access) => access.isVerifier ? verifikasi : ditangani;
}

/// Urutan antrean: darurat dulu, lalu yang lewat batas waktu, lalu yang paling lama menunggu.
/// Laporan yang sudah ditutup diurutkan dari yang terbaru.
List<Ticket> sortForQueue(Iterable<Ticket> tickets, {DateTime? now}) {
  final at = now ?? DateTime.now();
  int rank(Ticket ticket) {
    if (ticket.status.isClosed) return 3;
    if (ticket.priority == TicketPriority.darurat) return 0;
    if (ticket.isOverdue(at)) return 1;
    return 2;
  }

  final epoch = DateTime.fromMillisecondsSinceEpoch(0);
  return [...tickets]..sort((a, b) {
      final byRank = rank(a).compareTo(rank(b));
      if (byRank != 0) return byRank;
      if (rank(a) == 3) return (b.updatedAt ?? epoch).compareTo(a.updatedAt ?? epoch);
      return (a.createdAt ?? epoch).compareTo(b.createdAt ?? epoch);
    });
}
