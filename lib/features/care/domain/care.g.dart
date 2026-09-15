// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'care.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HelpRequest _$HelpRequestFromJson(Map<String, dynamic> json) => _HelpRequest(
  id: json['id'] as String,
  number: json['number'] as String? ?? '',
  schoolId: json['schoolId'] as String? ?? '',
  studentUid: json['studentUid'] as String? ?? '',
  student: json['student'] == null
      ? const HelpStudent()
      : HelpStudent.fromJson(json['student'] as Map<String, dynamic>),
  needs:
      (json['needs'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  urgency:
      $enumDecodeNullable(
        _$HelpUrgencyEnumMap,
        json['urgency'],
        unknownValue: HelpUrgency.biasa,
      ) ??
      HelpUrgency.biasa,
  contactMethod:
      $enumDecodeNullable(
        _$ContactMethodEnumMap,
        json['contactMethod'],
        unknownValue: ContactMethod.chat,
      ) ??
      ContactMethod.chat,
  contactTime:
      $enumDecodeNullable(
        _$ContactTimeEnumMap,
        json['contactTime'],
        unknownValue: ContactTime.kapanSaja,
      ) ??
      ContactTime.kapanSaja,
  whatsapp: json['whatsapp'] as String?,
  note: json['note'] as String?,
  status:
      $enumDecodeNullable(
        _$HelpStatusEnumMap,
        json['status'],
        unknownValue: HelpStatus.menunggu,
      ) ??
      HelpStatus.menunggu,
  counselorUid: json['counselorUid'] as String?,
  counselorName: json['counselorName'] as String?,
  conversationId: json['conversationId'] as String?,
  closingNote: json['closingNote'] as String?,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  claimedAt: const TimestampConverter().fromJson(json['claimedAt']),
  closedAt: const TimestampConverter().fromJson(json['closedAt']),
);

Map<String, dynamic> _$HelpRequestToJson(_HelpRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'schoolId': instance.schoolId,
      'studentUid': instance.studentUid,
      'student': instance.student.toJson(),
      'needs': instance.needs,
      'urgency': _$HelpUrgencyEnumMap[instance.urgency]!,
      'contactMethod': _$ContactMethodEnumMap[instance.contactMethod]!,
      'contactTime': _$ContactTimeEnumMap[instance.contactTime]!,
      'whatsapp': instance.whatsapp,
      'note': instance.note,
      'status': _$HelpStatusEnumMap[instance.status]!,
      'counselorUid': instance.counselorUid,
      'counselorName': instance.counselorName,
      'conversationId': instance.conversationId,
      'closingNote': instance.closingNote,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'claimedAt': const TimestampConverter().toJson(instance.claimedAt),
      'closedAt': const TimestampConverter().toJson(instance.closedAt),
    };

const _$HelpUrgencyEnumMap = {
  HelpUrgency.biasa: 'biasa',
  HelpUrgency.segera: 'segera',
  HelpUrgency.darurat: 'darurat',
};

const _$ContactMethodEnumMap = {
  ContactMethod.chat: 'chat',
  ContactMethod.bertemu: 'bertemu',
  ContactMethod.whatsapp: 'whatsapp',
};

const _$ContactTimeEnumMap = {
  ContactTime.istirahat: 'istirahat',
  ContactTime.pulangSekolah: 'pulang_sekolah',
  ContactTime.kapanSaja: 'kapan_saja',
};

const _$HelpStatusEnumMap = {
  HelpStatus.menunggu: 'menunggu',
  HelpStatus.ditangani: 'ditangani',
  HelpStatus.selesai: 'selesai',
  HelpStatus.dibatalkan: 'dibatalkan',
};

_HelpStudent _$HelpStudentFromJson(Map<String, dynamic> json) => _HelpStudent(
  name: json['name'] as String? ?? '',
  kelas: json['kelas'] as String?,
);

Map<String, dynamic> _$HelpStudentToJson(_HelpStudent instance) =>
    <String, dynamic>{'name': instance.name, 'kelas': instance.kelas};

_LastMessage _$LastMessageFromJson(Map<String, dynamic> json) => _LastMessage(
  text: json['text'] as String? ?? '',
  senderRole:
      $enumDecodeNullable(
        _$MessageRoleEnumMap,
        json['senderRole'],
        unknownValue: MessageRole.sistem,
      ) ??
      MessageRole.sistem,
  at: const TimestampConverter().fromJson(json['at']),
);

Map<String, dynamic> _$LastMessageToJson(_LastMessage instance) =>
    <String, dynamic>{
      'text': instance.text,
      'senderRole': _$MessageRoleEnumMap[instance.senderRole]!,
      'at': const TimestampConverter().toJson(instance.at),
    };

const _$MessageRoleEnumMap = {
  MessageRole.siswa: 'siswa',
  MessageRole.konselor: 'konselor',
  MessageRole.sistem: 'sistem',
};

_MeetingPlan _$MeetingPlanFromJson(Map<String, dynamic> json) => _MeetingPlan(
  at: const TimestampConverter().fromJson(json['at']),
  place: json['place'] as String? ?? '',
  status: json['status'] as String? ?? 'diusulkan',
);

Map<String, dynamic> _$MeetingPlanToJson(_MeetingPlan instance) =>
    <String, dynamic>{
      'at': const TimestampConverter().toJson(instance.at),
      'place': instance.place,
      'status': instance.status,
    };

_Conversation _$ConversationFromJson(Map<String, dynamic> json) =>
    _Conversation(
      id: json['id'] as String,
      schoolId: json['schoolId'] as String? ?? '',
      studentUid: json['studentUid'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      usesAlias: json['usesAlias'] as bool? ?? false,
      identityRevealed: json['identityRevealed'] as bool? ?? false,
      counselorUid: json['counselorUid'] as String?,
      counselorName: json['counselorName'] as String?,
      status:
          $enumDecodeNullable(
            _$ConversationStatusEnumMap,
            json['status'],
            unknownValue: ConversationStatus.menunggu,
          ) ??
          ConversationStatus.menunggu,
      topic: json['topic'] as String?,
      lastMessage: json['lastMessage'] == null
          ? null
          : LastMessage.fromJson(json['lastMessage'] as Map<String, dynamic>),
      unreadStudent: (json['unreadStudent'] as num?)?.toInt() ?? 0,
      unreadCounselor: (json['unreadCounselor'] as num?)?.toInt() ?? 0,
      meeting: json['meeting'] == null
          ? null
          : MeetingPlan.fromJson(json['meeting'] as Map<String, dynamic>),
      helpRequestId: json['helpRequestId'] as String?,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      closedAt: const TimestampConverter().fromJson(json['closedAt']),
    );

Map<String, dynamic> _$ConversationToJson(_Conversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'schoolId': instance.schoolId,
      'studentUid': instance.studentUid,
      'displayName': instance.displayName,
      'usesAlias': instance.usesAlias,
      'identityRevealed': instance.identityRevealed,
      'counselorUid': instance.counselorUid,
      'counselorName': instance.counselorName,
      'status': _$ConversationStatusEnumMap[instance.status]!,
      'topic': instance.topic,
      'lastMessage': instance.lastMessage?.toJson(),
      'unreadStudent': instance.unreadStudent,
      'unreadCounselor': instance.unreadCounselor,
      'meeting': instance.meeting?.toJson(),
      'helpRequestId': instance.helpRequestId,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'closedAt': const TimestampConverter().toJson(instance.closedAt),
    };

const _$ConversationStatusEnumMap = {
  ConversationStatus.menunggu: 'menunggu',
  ConversationStatus.aktif: 'aktif',
  ConversationStatus.selesai: 'selesai',
};

_ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => _ChatMessage(
  id: json['id'] as String,
  senderUid: json['senderUid'] as String?,
  senderRole:
      $enumDecodeNullable(
        _$MessageRoleEnumMap,
        json['senderRole'],
        unknownValue: MessageRole.sistem,
      ) ??
      MessageRole.sistem,
  text: json['text'] as String? ?? '',
  imagePath: json['imagePath'] as String?,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$ChatMessageToJson(_ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderUid': instance.senderUid,
      'senderRole': _$MessageRoleEnumMap[instance.senderRole]!,
      'text': instance.text,
      'imagePath': instance.imagePath,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };

_CaseNote _$CaseNoteFromJson(Map<String, dynamic> json) => _CaseNote(
  id: json['id'] as String,
  text: json['text'] as String? ?? '',
  riskLevel: json['riskLevel'] as String? ?? 'tidak_ada',
  authorName: json['authorName'] as String? ?? '',
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$CaseNoteToJson(_CaseNote instance) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'riskLevel': instance.riskLevel,
  'authorName': instance.authorName,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
};
