// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TicketAttachment _$TicketAttachmentFromJson(Map<String, dynamic> json) =>
    _TicketAttachment(
      path: json['path'] as String,
      name: json['name'] as String,
      contentType: json['contentType'] as String? ?? 'application/octet-stream',
      size: (json['size'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TicketAttachmentToJson(_TicketAttachment instance) =>
    <String, dynamic>{
      'path': instance.path,
      'name': instance.name,
      'contentType': instance.contentType,
      'size': instance.size,
    };

_TicketDetails _$TicketDetailsFromJson(Map<String, dynamic> json) =>
    _TicketDetails(
      role: json['role'] as String?,
      frequency: json['frequency'] as String?,
      involved: json['involved'] as String?,
    );

Map<String, dynamic> _$TicketDetailsToJson(_TicketDetails instance) =>
    <String, dynamic>{
      'role': instance.role,
      'frequency': instance.frequency,
      'involved': instance.involved,
    };

_TicketReporter _$TicketReporterFromJson(Map<String, dynamic> json) =>
    _TicketReporter(
      name: json['name'] as String,
      kelas: json['kelas'] as String?,
    );

Map<String, dynamic> _$TicketReporterToJson(_TicketReporter instance) =>
    <String, dynamic>{'name': instance.name, 'kelas': instance.kelas};

_InfoRequest _$InfoRequestFromJson(Map<String, dynamic> json) => _InfoRequest(
  message: json['message'] as String,
  requestedAt: const TimestampConverter().fromJson(json['requestedAt']),
);

Map<String, dynamic> _$InfoRequestToJson(_InfoRequest instance) =>
    <String, dynamic>{
      'message': instance.message,
      'requestedAt': const TimestampConverter().toJson(instance.requestedAt),
    };

_TicketResolution _$TicketResolutionFromJson(Map<String, dynamic> json) =>
    _TicketResolution(
      note: json['note'] as String,
      attachments:
          (json['attachments'] as List<dynamic>?)
              ?.map((e) => TicketAttachment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TicketAttachment>[],
      resolvedByName: json['resolvedByName'] as String? ?? '',
      resolvedAt: const TimestampConverter().fromJson(json['resolvedAt']),
    );

Map<String, dynamic> _$TicketResolutionToJson(_TicketResolution instance) =>
    <String, dynamic>{
      'note': instance.note,
      'attachments': instance.attachments.map((e) => e.toJson()).toList(),
      'resolvedByName': instance.resolvedByName,
      'resolvedAt': const TimestampConverter().toJson(instance.resolvedAt),
    };

_TicketRejection _$TicketRejectionFromJson(Map<String, dynamic> json) =>
    _TicketRejection(
      reason:
          $enumDecodeNullable(
            _$RejectReasonEnumMap,
            json['reason'],
            unknownValue: RejectReason.lainnya,
          ) ??
          RejectReason.lainnya,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$TicketRejectionToJson(_TicketRejection instance) =>
    <String, dynamic>{
      'reason': _$RejectReasonEnumMap[instance.reason]!,
      'note': instance.note,
    };

const _$RejectReasonEnumMap = {
  RejectReason.duplikat: 'duplikat',
  RejectReason.tidakValid: 'tidak_valid',
  RejectReason.bukanWewenang: 'bukan_wewenang',
  RejectReason.lainnya: 'lainnya',
};

_TicketRating _$TicketRatingFromJson(Map<String, dynamic> json) =>
    _TicketRating(
      score: (json['score'] as num).toInt(),
      comment: json['comment'] as String?,
      ratedAt: const TimestampConverter().fromJson(json['ratedAt']),
    );

Map<String, dynamic> _$TicketRatingToJson(_TicketRating instance) =>
    <String, dynamic>{
      'score': instance.score,
      'comment': instance.comment,
      'ratedAt': const TimestampConverter().toJson(instance.ratedAt),
    };

_TicketSla _$TicketSlaFromJson(Map<String, dynamic> json) => _TicketSla(
  verifyDueAt: const TimestampConverter().fromJson(json['verifyDueAt']),
  resolveDueAt: const TimestampConverter().fromJson(json['resolveDueAt']),
);

Map<String, dynamic> _$TicketSlaToJson(_TicketSla instance) =>
    <String, dynamic>{
      'verifyDueAt': const TimestampConverter().toJson(instance.verifyDueAt),
      'resolveDueAt': const TimestampConverter().toJson(instance.resolveDueAt),
    };

_Ticket _$TicketFromJson(Map<String, dynamic> json) => _Ticket(
  id: json['id'] as String,
  number: json['number'] as String? ?? '',
  schoolId: json['schoolId'] as String? ?? '',
  category: json['category'] as String? ?? 'lainnya',
  categoryLabel: json['categoryLabel'] as String? ?? '',
  subcategory: json['subcategory'] as String? ?? 'lainnya',
  subcategoryLabel: json['subcategoryLabel'] as String? ?? '',
  title: json['title'] as String? ?? '',
  description: json['description'] as String? ?? '',
  location: json['location'] as String? ?? '',
  incidentDate: json['incidentDate'] as String?,
  incidentTime: json['incidentTime'] as String?,
  details: json['details'] == null
      ? const TicketDetails()
      : TicketDetails.fromJson(json['details'] as Map<String, dynamic>),
  attachments:
      (json['attachments'] as List<dynamic>?)
          ?.map((e) => TicketAttachment.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TicketAttachment>[],
  anonymous: json['anonymous'] as bool? ?? false,
  reporter: json['reporter'] == null
      ? null
      : TicketReporter.fromJson(json['reporter'] as Map<String, dynamic>),
  contactWhatsapp: json['contactWhatsapp'] as String?,
  priority:
      $enumDecodeNullable(
        _$TicketPriorityEnumMap,
        json['priority'],
        unknownValue: TicketPriority.normal,
      ) ??
      TicketPriority.normal,
  priorityReason: json['priorityReason'] as String?,
  suggestedCategory: json['suggestedCategory'] as String?,
  possibleDuplicateOf: json['possibleDuplicateOf'] as String?,
  status:
      $enumDecodeNullable(
        _$TicketStatusEnumMap,
        json['status'],
        unknownValue: TicketStatus.menungguVerifikasi,
      ) ??
      TicketStatus.menungguVerifikasi,
  unitId: json['unitId'] as String?,
  unitName: json['unitName'] as String?,
  infoRequest: json['infoRequest'] == null
      ? null
      : InfoRequest.fromJson(json['infoRequest'] as Map<String, dynamic>),
  resolution: json['resolution'] == null
      ? null
      : TicketResolution.fromJson(json['resolution'] as Map<String, dynamic>),
  rejection: json['rejection'] == null
      ? null
      : TicketRejection.fromJson(json['rejection'] as Map<String, dynamic>),
  rating: json['rating'] == null
      ? null
      : TicketRating.fromJson(json['rating'] as Map<String, dynamic>),
  sla: json['sla'] == null
      ? const TicketSla()
      : TicketSla.fromJson(json['sla'] as Map<String, dynamic>),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  verifiedAt: const TimestampConverter().fromJson(json['verifiedAt']),
  resolvedAt: const TimestampConverter().fromJson(json['resolvedAt']),
);

Map<String, dynamic> _$TicketToJson(_Ticket instance) => <String, dynamic>{
  'id': instance.id,
  'number': instance.number,
  'schoolId': instance.schoolId,
  'category': instance.category,
  'categoryLabel': instance.categoryLabel,
  'subcategory': instance.subcategory,
  'subcategoryLabel': instance.subcategoryLabel,
  'title': instance.title,
  'description': instance.description,
  'location': instance.location,
  'incidentDate': instance.incidentDate,
  'incidentTime': instance.incidentTime,
  'details': instance.details.toJson(),
  'attachments': instance.attachments.map((e) => e.toJson()).toList(),
  'anonymous': instance.anonymous,
  'reporter': instance.reporter?.toJson(),
  'contactWhatsapp': instance.contactWhatsapp,
  'priority': _$TicketPriorityEnumMap[instance.priority]!,
  'priorityReason': instance.priorityReason,
  'suggestedCategory': instance.suggestedCategory,
  'possibleDuplicateOf': instance.possibleDuplicateOf,
  'status': _$TicketStatusEnumMap[instance.status]!,
  'unitId': instance.unitId,
  'unitName': instance.unitName,
  'infoRequest': instance.infoRequest?.toJson(),
  'resolution': instance.resolution?.toJson(),
  'rejection': instance.rejection?.toJson(),
  'rating': instance.rating?.toJson(),
  'sla': instance.sla.toJson(),
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'verifiedAt': const TimestampConverter().toJson(instance.verifiedAt),
  'resolvedAt': const TimestampConverter().toJson(instance.resolvedAt),
};

const _$TicketPriorityEnumMap = {
  TicketPriority.normal: 'normal',
  TicketPriority.tinggi: 'tinggi',
  TicketPriority.darurat: 'darurat',
};

const _$TicketStatusEnumMap = {
  TicketStatus.menungguVerifikasi: 'menunggu_verifikasi',
  TicketStatus.perluDilengkapi: 'perlu_dilengkapi',
  TicketStatus.diteruskan: 'diteruskan',
  TicketStatus.diproses: 'diproses',
  TicketStatus.selesai: 'selesai',
  TicketStatus.ditolak: 'ditolak',
  TicketStatus.dibatalkan: 'dibatalkan',
};

_TimelineEvent _$TimelineEventFromJson(Map<String, dynamic> json) =>
    _TimelineEvent(
      id: json['id'] as String,
      type:
          $enumDecodeNullable(
            _$TimelineTypeEnumMap,
            json['type'],
            unknownValue: TimelineType.progres,
          ) ??
          TimelineType.progres,
      visibility:
          $enumDecodeNullable(
            _$TimelineVisibilityEnumMap,
            json['visibility'],
            unknownValue: TimelineVisibility.internal,
          ) ??
          TimelineVisibility.public,
      message: json['message'] as String?,
      actorRole: json['actorRole'] as String? ?? 'sistem',
      actorName: json['actorName'] as String?,
      attachments:
          (json['attachments'] as List<dynamic>?)
              ?.map((e) => TicketAttachment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TicketAttachment>[],
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$TimelineEventToJson(_TimelineEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$TimelineTypeEnumMap[instance.type]!,
      'visibility': _$TimelineVisibilityEnumMap[instance.visibility]!,
      'message': instance.message,
      'actorRole': instance.actorRole,
      'actorName': instance.actorName,
      'attachments': instance.attachments.map((e) => e.toJson()).toList(),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };

const _$TimelineTypeEnumMap = {
  TimelineType.dibuat: 'dibuat',
  TimelineType.dimintaMelengkapi: 'diminta_melengkapi',
  TimelineType.dilengkapi: 'dilengkapi',
  TimelineType.diteruskan: 'diteruskan',
  TimelineType.dialihkan: 'dialihkan',
  TimelineType.progres: 'progres',
  TimelineType.catatanInternal: 'catatan_internal',
  TimelineType.selesai: 'selesai',
  TimelineType.ditolak: 'ditolak',
  TimelineType.dibatalkan: 'dibatalkan',
  TimelineType.dinilai: 'dinilai',
  TimelineType.pengingat: 'pengingat',
};

const _$TimelineVisibilityEnumMap = {
  TimelineVisibility.public: 'public',
  TimelineVisibility.internal: 'internal',
};

_TicketOwner _$TicketOwnerFromJson(Map<String, dynamic> json) => _TicketOwner(
  id: json['id'] as String,
  uid: json['uid'] as String,
  anonymous: json['anonymous'] as bool? ?? false,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$TicketOwnerToJson(_TicketOwner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'anonymous': instance.anonymous,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
