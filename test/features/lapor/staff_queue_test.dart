import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mandu/core/domain/catalog.dart';
import 'package:mandu/core/domain/roles.dart';
import 'package:mandu/features/lapor/domain/staff_queue.dart';
import 'package:mandu/features/lapor/domain/ticket.dart';

final _now = DateTime(2026, 9, 16, 10);

Ticket _ticket(
  String id, {
  TicketStatus status = TicketStatus.menungguVerifikasi,
  TicketPriority priority = TicketPriority.normal,
  String? unitId,
  int ageHours = 1,
  int? dueInHours,
}) {
  return Ticket(
    id: id,
    status: status,
    priority: priority,
    unitId: unitId,
    createdAt: _now.subtract(Duration(hours: ageHours)),
    updatedAt: _now.subtract(Duration(hours: ageHours)),
    sla: TicketSla(verifyDueAt: dueInHours == null ? null : _now.add(Duration(hours: dueInHours))),
  );
}

void main() {
  test('dokumen Firestore dibaca lengkap, termasuk status berformat snake_case', () {
    final ticket = Ticket.fromJson({
      'id': 't1',
      'number': 'MND-2026-0001',
      'status': 'perlu_dilengkapi',
      'priority': 'darurat',
      'createdAt': Timestamp.fromDate(_now),
      'sla': {'verifyDueAt': Timestamp.fromDate(_now), 'resolveDueAt': null},
      'infoRequest': {'message': 'Lampirkan foto', 'requestedAt': Timestamp.fromDate(_now)},
      'rejection': {'reason': 'bukan_wewenang', 'note': null},
      'reporter': null,
      'attachments': [
        {'path': 'schools/a/tickets/t1/lampiran/1.jpg', 'name': '1.jpg', 'contentType': 'image/jpeg', 'size': 10},
      ],
      'statusBaru': 'diabaikan',
    });

    expect(ticket.status, TicketStatus.perluDilengkapi);
    expect(ticket.priority, TicketPriority.darurat);
    expect(ticket.infoRequest?.message, 'Lampirkan foto');
    expect(ticket.rejection?.reason, RejectReason.bukanWewenang);
    expect(ticket.attachments.single.isImage, isTrue);
    expect(ticket.createdAt, _now);

    final unknown = Ticket.fromJson({'id': 't2', 'status': 'status_masa_depan'});
    expect(unknown.status, TicketStatus.menungguVerifikasi);
  });

  test('timeline internal dan tipe snake_case terbaca', () {
    final event = TimelineEvent.fromJson({'id': 'e1', 'type': 'catatan_internal', 'visibility': 'internal', 'actorRole': 'petugas'});
    expect(event.type, TimelineType.catatanInternal);
    expect(event.visibility, TimelineVisibility.internal);
  });

  group('hak staf', () {
    const admin = StaffTicketAccess(role: SchoolRole.admin, units: [], canVerify: false);
    const kepsek = StaffTicketAccess(role: SchoolRole.pimpinan, units: [], canVerify: false);
    const sarpras = StaffTicketAccess(role: SchoolRole.petugas, units: ['sarpras'], canVerify: false);
    const bkVerifikator = StaffTicketAccess(role: SchoolRole.konselor, units: ['bk_ppks'], canVerify: true);
    final forwarded = _ticket('t', status: TicketStatus.diteruskan, unitId: 'sarpras');

    test('sama dengan aturan functions', () {
      expect(admin.isVerifier && admin.seesAll && admin.canHandle(forwarded), isTrue);
      expect(kepsek.seesAll && kepsek.readOnly, isTrue);
      expect(kepsek.canHandle(forwarded) || kepsek.isVerifier, isFalse);
      expect(sarpras.seesAll || sarpras.isVerifier, isFalse);
      expect(sarpras.canHandle(forwarded), isTrue);
      expect(bkVerifikator.isVerifier && bkVerifikator.seesAll, isTrue);
      expect(bkVerifikator.canHandle(forwarded), isFalse);
    });

    test('laporan yang perlu tindakan', () {
      final waiting = _ticket('w');
      expect(admin.needsAction(waiting), isTrue);
      expect(sarpras.needsAction(waiting), isFalse);
      expect(sarpras.needsAction(forwarded), isTrue);
      expect(bkVerifikator.needsAction(forwarded), isFalse);
      expect(StaffTicketFilter.availableFor(sarpras), isNot(contains(StaffTicketFilter.verifikasi)));
      expect(StaffTicketFilter.initialFor(sarpras), StaffTicketFilter.ditangani);
      expect(StaffTicketFilter.initialFor(bkVerifikator), StaffTicketFilter.verifikasi);
    });
  });

  test('antrean: darurat, lalu terlambat, lalu yang paling lama menunggu; yang ditutup di akhir', () {
    final tickets = [
      _ticket('baru', ageHours: 1, dueInHours: 20),
      _ticket('selesai-lama', status: TicketStatus.selesai, ageHours: 50),
      _ticket('lama', ageHours: 10, dueInHours: 14),
      _ticket('terlambat', ageHours: 5, dueInHours: -1),
      _ticket('darurat', priority: TicketPriority.darurat, ageHours: 0, dueInHours: 2),
      _ticket('selesai-baru', status: TicketStatus.ditolak, ageHours: 3),
    ];
    expect(
      sortForQueue(tickets, now: _now).map((ticket) => ticket.id),
      ['darurat', 'terlambat', 'lama', 'baru', 'selesai-baru', 'selesai-lama'],
    );
  });

  test('langkah progres dan batas waktu aktif', () {
    expect(TicketStatus.perluDilengkapi.step, 0);
    expect(TicketStatus.diproses.step, 2);
    final overdue = _ticket('x', dueInHours: -2);
    expect(overdue.isOverdue(_now), isTrue);
    expect(overdue.copyWith(status: TicketStatus.selesai).dueAt, isNull);
  });
}
