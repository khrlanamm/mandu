import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/catalog.dart';
import '../../../core/files/pending_attachment.dart';
import '../../../core/firebase/callable.dart';
import '../../../core/firebase/firebase_providers.dart';
import '../../auth/application/session_controller.dart';
import '../../members/data/membership_repository.dart';
import '../domain/staff_queue.dart';
import '../domain/ticket.dart';

part 'ticket_repository.g.dart';

typedef SubmitResult = ({String ticketId, String number, TicketPriority priority});

/// Folder lampiran di Storage (sama dengan functions/src/tickets/refs.ts).
enum AttachmentFolder {
  lampiran,
  tindakLanjut('tindak-lanjut');

  const AttachmentFolder([this._segment]);

  final String? _segment;

  String get segment => _segment ?? name;
}

class TicketRepository {
  const TicketRepository(this._functions, this._firestore, this._storage);

  final FirebaseFunctions _functions;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  CollectionReference<Map<String, dynamic>> _tickets(String schoolId) =>
      _firestore.collection('schools').doc(schoolId).collection('tickets');

  /// ID laporan dibuat di perangkat agar lampiran bisa diunggah sebelum laporan dikirim.
  String newTicketId() => _tickets('_').doc().id;

  Future<TicketAttachment> uploadAttachment({
    required String schoolId,
    required String ticketId,
    required AttachmentFolder folder,
    required PendingAttachment file,
  }) async {
    final safeName = file.name.replaceAll(RegExp(r'[^A-Za-z0-9._-]'), '_');
    final path = 'schools/$schoolId/tickets/$ticketId/${folder.segment}/${DateTime.now().millisecondsSinceEpoch}_$safeName';
    await _storage.ref(path).putData(file.bytes, SettableMetadata(contentType: file.contentType));
    return TicketAttachment(path: path, name: file.name, contentType: file.contentType, size: file.size);
  }

  Future<String> downloadUrl(String path) => _storage.ref(path).getDownloadURL();

  static List<Map<String, Object?>> _attachmentsJson(List<TicketAttachment> attachments) => [
        for (final attachment in attachments)
          {'path': attachment.path, 'name': attachment.name, 'contentType': attachment.contentType, 'size': attachment.size},
      ];

  static String? _blankToNull(String? value) => value == null || value.trim().isEmpty ? null : value.trim();

  Future<SubmitResult> submit({
    required String schoolId,
    required String ticketId,
    required ReportDraft draft,
    required List<TicketAttachment> attachments,
  }) async {
    final category = reportCategory(draft.category);
    final data = await _functions.callMap('tickets-submit', {
      'schoolId': schoolId,
      'ticketId': ticketId,
      'category': draft.category,
      'subcategory': draft.subcategory,
      'title': draft.title.trim(),
      'description': draft.description.trim(),
      'location': draft.location.trim(),
      'incidentDate': draft.incidentDate == null ? null : DateFormat('yyyy-MM-dd').format(draft.incidentDate!),
      'incidentTime': _blankToNull(draft.incidentTime),
      'anonymous': draft.anonymous,
      'contactWhatsapp': _blankToNull(draft.contactWhatsapp?.replaceAll(RegExp(r'[\s-]'), '')),
      if (category?.isSafety ?? false)
        'details': {'role': draft.role, 'frequency': _blankToNull(draft.frequency), 'involved': _blankToNull(draft.involved)},
      'attachments': _attachmentsJson(attachments),
    });
    return (
      ticketId: data['ticketId'] as String,
      number: data['number'] as String,
      priority: TicketPriority.values.asNameMap()[data['priority']] ?? TicketPriority.normal,
    );
  }

  Future<void> forward({
    required String schoolId,
    required String ticketId,
    String? unitId,
    String? category,
    String? subcategory,
    TicketPriority? priority,
    String? message,
  }) =>
      _functions.callMap('tickets-verify', {
        'schoolId': schoolId,
        'ticketId': ticketId,
        'decision': 'forward',
        'unitId': ?unitId,
        'category': ?category,
        'subcategory': ?subcategory,
        'priority': ?priority?.name,
        'message': ?_blankToNull(message),
      });

  Future<void> requestInfo({required String schoolId, required String ticketId, required String message}) =>
      _functions.callMap('tickets-verify', {
        'schoolId': schoolId,
        'ticketId': ticketId,
        'decision': 'request_info',
        'message': message.trim(),
      });

  Future<void> reject({required String schoolId, required String ticketId, required RejectReason reason, String? message}) =>
      _functions.callMap('tickets-verify', {
        'schoolId': schoolId,
        'ticketId': ticketId,
        'decision': 'reject',
        'reason': reason.wire,
        'message': ?_blankToNull(message),
      });

  Future<void> supplyInfo({
    required String schoolId,
    required String ticketId,
    required String message,
    List<TicketAttachment> attachments = const [],
  }) =>
      _functions.callMap('tickets-supplyInfo', {
        'schoolId': schoolId,
        'ticketId': ticketId,
        'message': message.trim(),
        'attachments': _attachmentsJson(attachments),
      });

  Future<void> cancel({required String schoolId, required String ticketId}) =>
      _functions.callMap('tickets-cancel', {'schoolId': schoolId, 'ticketId': ticketId});

  Future<void> addProgress({
    required String schoolId,
    required String ticketId,
    required String message,
    required TimelineVisibility visibility,
    List<TicketAttachment> attachments = const [],
  }) =>
      _functions.callMap('tickets-addProgress', {
        'schoolId': schoolId,
        'ticketId': ticketId,
        'message': message.trim(),
        'visibility': visibility.name,
        'attachments': _attachmentsJson(attachments),
      });

  Future<void> resolve({
    required String schoolId,
    required String ticketId,
    required String note,
    List<TicketAttachment> attachments = const [],
  }) =>
      _functions.callMap('tickets-resolve', {
        'schoolId': schoolId,
        'ticketId': ticketId,
        'note': note.trim(),
        'attachments': _attachmentsJson(attachments),
      });

  Future<void> reassign({required String schoolId, required String ticketId, required String unitId, String? message}) =>
      _functions.callMap('tickets-reassign', {
        'schoolId': schoolId,
        'ticketId': ticketId,
        'unitId': unitId,
        'message': ?_blankToNull(message),
      });

  Future<void> rate({required String schoolId, required String ticketId, required int score, String? comment}) =>
      _functions.callMap('tickets-rate', {
        'schoolId': schoolId,
        'ticketId': ticketId,
        'score': score,
        'comment': ?_blankToNull(comment),
      });

  Stream<Ticket?> watchTicket(String schoolId, String ticketId) => _tickets(schoolId)
      .doc(ticketId)
      .snapshots()
      .map((snapshot) => snapshot.exists ? Ticket.fromJson(docWithId(snapshot)) : null);

  /// Riwayat laporan. Pelapor hanya boleh membaca event publik.
  Stream<List<TimelineEvent>> watchTimeline(String schoolId, String ticketId, {required bool publicOnly}) {
    Query<Map<String, dynamic>> query = _tickets(schoolId).doc(ticketId).collection('timeline');
    if (publicOnly) query = query.where('visibility', isEqualTo: 'public');
    return query
        .orderBy('createdAt')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => TimelineEvent.fromJson(docWithId(doc))).toList());
  }

  Stream<List<TicketOwner>> watchOwnedTickets(String schoolId, String uid) => _firestore
      .collection('schools')
      .doc(schoolId)
      .collection('ticketOwners')
      .where('uid', isEqualTo: uid)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => TicketOwner.fromJson(docWithId(doc))).toList());

  /// Laporan yang terlihat oleh staf: semua (admin, pimpinan, verifikator) atau per unit.
  Stream<List<Ticket>> watchStaffTickets(String schoolId, {required bool seesAll, required List<String> units}) {
    Query<Map<String, dynamic>> query = _tickets(schoolId);
    if (!seesAll) {
      if (units.isEmpty) return Stream.value(const []);
      query = query.where('unitId', whereIn: units.take(30).toList());
    }
    return query
        .orderBy('createdAt', descending: true)
        .limit(300)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Ticket.fromJson(docWithId(doc))).toList());
  }
}

@Riverpod(keepAlive: true)
TicketRepository ticketRepository(Ref ref) =>
    TicketRepository(ref.watch(functionsProvider), ref.watch(firestoreProvider), ref.watch(storageProvider));

@riverpod
Stream<Ticket?> ticket(Ref ref, String schoolId, String ticketId) =>
    ref.watch(ticketRepositoryProvider).watchTicket(schoolId, ticketId);

@riverpod
Stream<List<TimelineEvent>> ticketTimeline(Ref ref, String schoolId, String ticketId, {required bool publicOnly}) =>
    ref.watch(ticketRepositoryProvider).watchTimeline(schoolId, ticketId, publicOnly: publicOnly);

@riverpod
Future<String> attachmentUrl(Ref ref, String path) => ref.watch(ticketRepositoryProvider).downloadUrl(path);

/// Laporan milik siswa yang sedang masuk.
@riverpod
Stream<List<TicketOwner>> myTickets(Ref ref) {
  final account = ref.watch(currentAccountProvider);
  if (account?.schoolId == null) return Stream.value(const []);
  return ref.watch(ticketRepositoryProvider).watchOwnedTickets(account!.schoolId!, account.uid);
}

@riverpod
StaffTicketAccess? staffTicketAccess(Ref ref) {
  final account = ref.watch(currentAccountProvider);
  final role = account?.role;
  if (account?.schoolId == null || role == null || !role.isStaff) return null;
  final member = ref.watch(ownMembershipProvider(account!.schoolId!, account.uid)).value;
  return StaffTicketAccess(role: role, units: member?.units ?? const [], canVerify: member?.canVerify ?? false);
}

@riverpod
Stream<List<Ticket>> staffTickets(Ref ref) {
  final account = ref.watch(currentAccountProvider);
  final access = ref.watch(staffTicketAccessProvider);
  if (account?.schoolId == null || access == null) return Stream.value(const []);
  return ref
      .watch(ticketRepositoryProvider)
      .watchStaffTickets(account!.schoolId!, seesAll: access.seesAll, units: access.units);
}

/// Jumlah laporan yang menunggu tindakan staf yang sedang masuk (badge tab Tugas).
@riverpod
int staffActionableCount(Ref ref) {
  final access = ref.watch(staffTicketAccessProvider);
  if (access == null || access.readOnly) return 0;
  return ref.watch(staffTicketsProvider).value?.where(access.needsAction).length ?? 0;
}
