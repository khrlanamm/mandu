import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/catalog.dart';
import '../../../core/firebase/callable.dart';

part 'ticket.freezed.dart';
part 'ticket.g.dart';

enum TicketStatus {
  @JsonValue('menunggu_verifikasi')
  menungguVerifikasi('Menunggu verifikasi', 'Tim Verifikasi sekolah sedang memeriksa laporan.'),
  @JsonValue('perlu_dilengkapi')
  perluDilengkapi('Perlu dilengkapi', 'Sekolah membutuhkan informasi tambahan darimu.'),
  @JsonValue('diteruskan')
  diteruskan('Diteruskan ke unit', 'Laporan sudah diverifikasi dan diteruskan ke unit penangan.'),
  @JsonValue('diproses')
  diproses('Sedang diproses', 'Unit penangan sedang menindaklanjuti laporan.'),
  @JsonValue('selesai')
  selesai('Selesai', 'Laporan sudah ditindaklanjuti.'),
  @JsonValue('ditolak')
  ditolak('Tidak dilanjutkan', 'Laporan tidak dapat ditindaklanjuti.'),
  @JsonValue('dibatalkan')
  dibatalkan('Dibatalkan', 'Laporan dibatalkan oleh pelapor.');

  const TicketStatus(this.label, this.description);

  final String label;
  final String description;

  bool get isClosed => this == selesai || this == ditolak || this == dibatalkan;

  bool get awaitingVerification => this == menungguVerifikasi;

  bool get inHandling => this == diteruskan || this == diproses;

  bool get cancellable => this == menungguVerifikasi || this == perluDilengkapi;

  /// Posisi pada alur Terkirim → Diverifikasi → Diproses → Selesai (0–3).
  int get step => switch (this) {
        menungguVerifikasi || perluDilengkapi || ditolak || dibatalkan => 0,
        diteruskan => 1,
        diproses => 2,
        selesai => 3,
      };
}

@freezed
abstract class TicketAttachment with _$TicketAttachment {
  const TicketAttachment._();

  const factory TicketAttachment({
    required String path,
    required String name,
    @Default('application/octet-stream') String contentType,
    @Default(0) int size,
  }) = _TicketAttachment;

  factory TicketAttachment.fromJson(Map<String, dynamic> json) => _$TicketAttachmentFromJson(json);

  bool get isImage => contentType.startsWith('image/');
}

@freezed
abstract class TicketDetails with _$TicketDetails {
  const factory TicketDetails({String? role, String? frequency, String? involved}) = _TicketDetails;

  factory TicketDetails.fromJson(Map<String, dynamic> json) => _$TicketDetailsFromJson(json);
}

@freezed
abstract class TicketReporter with _$TicketReporter {
  const factory TicketReporter({required String name, String? kelas}) = _TicketReporter;

  factory TicketReporter.fromJson(Map<String, dynamic> json) => _$TicketReporterFromJson(json);
}

@freezed
abstract class InfoRequest with _$InfoRequest {
  const factory InfoRequest({required String message, @TimestampConverter() DateTime? requestedAt}) = _InfoRequest;

  factory InfoRequest.fromJson(Map<String, dynamic> json) => _$InfoRequestFromJson(json);
}

@freezed
abstract class TicketResolution with _$TicketResolution {
  const factory TicketResolution({
    required String note,
    @Default(<TicketAttachment>[]) List<TicketAttachment> attachments,
    @Default('') String resolvedByName,
    @TimestampConverter() DateTime? resolvedAt,
  }) = _TicketResolution;

  factory TicketResolution.fromJson(Map<String, dynamic> json) => _$TicketResolutionFromJson(json);
}

@freezed
abstract class TicketRejection with _$TicketRejection {
  const factory TicketRejection({
    @JsonKey(unknownEnumValue: RejectReason.lainnya) @Default(RejectReason.lainnya) RejectReason reason,
    String? note,
  }) = _TicketRejection;

  factory TicketRejection.fromJson(Map<String, dynamic> json) => _$TicketRejectionFromJson(json);
}

@freezed
abstract class TicketRating with _$TicketRating {
  const factory TicketRating({required int score, String? comment, @TimestampConverter() DateTime? ratedAt}) = _TicketRating;

  factory TicketRating.fromJson(Map<String, dynamic> json) => _$TicketRatingFromJson(json);
}

@freezed
abstract class TicketSla with _$TicketSla {
  const factory TicketSla({
    @TimestampConverter() DateTime? verifyDueAt,
    @TimestampConverter() DateTime? resolveDueAt,
  }) = _TicketSla;

  factory TicketSla.fromJson(Map<String, dynamic> json) => _$TicketSlaFromJson(json);
}

/// Dokumen `schools/{schoolId}/tickets/{ticketId}` (functions/src/domain/tickets.ts).
@freezed
abstract class Ticket with _$Ticket {
  const Ticket._();

  const factory Ticket({
    required String id,
    @Default('') String number,
    @Default('') String schoolId,
    @Default('lainnya') String category,
    @Default('') String categoryLabel,
    @Default('lainnya') String subcategory,
    @Default('') String subcategoryLabel,
    @Default('') String title,
    @Default('') String description,
    @Default('') String location,
    String? incidentDate,
    String? incidentTime,
    @Default(TicketDetails()) TicketDetails details,
    @Default(<TicketAttachment>[]) List<TicketAttachment> attachments,
    @Default(false) bool anonymous,
    TicketReporter? reporter,
    String? contactWhatsapp,
    @JsonKey(unknownEnumValue: TicketPriority.normal) @Default(TicketPriority.normal) TicketPriority priority,
    String? priorityReason,
    String? suggestedCategory,
    String? possibleDuplicateOf,
    @JsonKey(unknownEnumValue: TicketStatus.menungguVerifikasi) @Default(TicketStatus.menungguVerifikasi) TicketStatus status,
    String? unitId,
    String? unitName,
    InfoRequest? infoRequest,
    TicketResolution? resolution,
    TicketRejection? rejection,
    TicketRating? rating,
    @Default(TicketSla()) TicketSla sla,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @TimestampConverter() DateTime? verifiedAt,
    @TimestampConverter() DateTime? resolvedAt,
  }) = _Ticket;

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  /// Batas waktu tahap yang sedang berjalan, bila ada.
  DateTime? get dueAt => switch (status) {
        TicketStatus.menungguVerifikasi => sla.verifyDueAt,
        TicketStatus.diteruskan || TicketStatus.diproses => sla.resolveDueAt,
        _ => null,
      };

  bool isOverdue([DateTime? now]) {
    final due = dueAt;
    return due != null && due.isBefore(now ?? DateTime.now());
  }
}

enum TimelineType {
  dibuat,
  @JsonValue('diminta_melengkapi')
  dimintaMelengkapi,
  dilengkapi,
  diteruskan,
  dialihkan,
  progres,
  @JsonValue('catatan_internal')
  catatanInternal,
  selesai,
  ditolak,
  dibatalkan,
  dinilai,
  pengingat,
}

enum TimelineVisibility { public, internal }

/// Dokumen `schools/{schoolId}/tickets/{ticketId}/timeline/{eventId}`.
@freezed
abstract class TimelineEvent with _$TimelineEvent {
  const factory TimelineEvent({
    required String id,
    @JsonKey(unknownEnumValue: TimelineType.progres) @Default(TimelineType.progres) TimelineType type,
    @JsonKey(unknownEnumValue: TimelineVisibility.internal) @Default(TimelineVisibility.public) TimelineVisibility visibility,
    String? message,
    @Default('sistem') String actorRole,
    String? actorName,
    @Default(<TicketAttachment>[]) List<TicketAttachment> attachments,
    @TimestampConverter() DateTime? createdAt,
  }) = _TimelineEvent;

  factory TimelineEvent.fromJson(Map<String, dynamic> json) => _$TimelineEventFromJson(json);
}

/// Dokumen `schools/{schoolId}/ticketOwners/{ticketId}` — hanya terbaca oleh pelapor.
@freezed
abstract class TicketOwner with _$TicketOwner {
  const factory TicketOwner({
    required String id,
    required String uid,
    @Default(false) bool anonymous,
    @TimestampConverter() DateTime? createdAt,
  }) = _TicketOwner;

  factory TicketOwner.fromJson(Map<String, dynamic> json) => _$TicketOwnerFromJson(json);
}

/// Isian formulir Lapor sebelum dikirim.
class ReportDraft {
  const ReportDraft({
    required this.category,
    required this.subcategory,
    required this.title,
    required this.description,
    required this.location,
    required this.anonymous,
    this.incidentDate,
    this.incidentTime,
    this.contactWhatsapp,
    this.role,
    this.frequency,
    this.involved,
  });

  final String category;
  final String subcategory;
  final String title;
  final String description;
  final String location;
  final bool anonymous;
  final DateTime? incidentDate;
  final String? incidentTime;
  final String? contactWhatsapp;
  final String? role;
  final String? frequency;
  final String? involved;
}
