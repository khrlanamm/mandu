// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aspiration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AspirationResponse _$AspirationResponseFromJson(Map<String, dynamic> json) =>
    _AspirationResponse(
      message: json['message'] as String,
      respondedByName: json['respondedByName'] as String? ?? '',
      respondedAt: const TimestampConverter().fromJson(json['respondedAt']),
    );

Map<String, dynamic> _$AspirationResponseToJson(_AspirationResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'respondedByName': instance.respondedByName,
      'respondedAt': const TimestampConverter().toJson(instance.respondedAt),
    };

_Aspiration _$AspirationFromJson(Map<String, dynamic> json) => _Aspiration(
  id: json['id'] as String,
  number: json['number'] as String? ?? '',
  schoolId: json['schoolId'] as String? ?? '',
  type:
      $enumDecodeNullable(
        _$AspirationTypeEnumMap,
        json['type'],
        unknownValue: AspirationType.saran,
      ) ??
      AspirationType.saran,
  topic: json['topic'] as String? ?? 'lainnya',
  topicLabel: json['topicLabel'] as String? ?? '',
  title: json['title'] as String? ?? '',
  content: json['content'] as String? ?? '',
  source: json['source'] as String? ?? 'siswa',
  anonymous: json['anonymous'] as bool? ?? false,
  flagged: json['flagged'] as bool? ?? false,
  status:
      $enumDecodeNullable(
        _$AspirationStatusEnumMap,
        json['status'],
        unknownValue: AspirationStatus.diterima,
      ) ??
      AspirationStatus.diterima,
  response: json['response'] == null
      ? null
      : AspirationResponse.fromJson(json['response'] as Map<String, dynamic>),
  board:
      $enumDecodeNullable(
        _$BoardStateEnumMap,
        json['board'],
        unknownValue: BoardState.none,
      ) ??
      BoardState.none,
  publishedAt: const TimestampConverter().fromJson(json['publishedAt']),
  supportCount: (json['supportCount'] as num?)?.toInt() ?? 0,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$AspirationToJson(_Aspiration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'schoolId': instance.schoolId,
      'type': _$AspirationTypeEnumMap[instance.type]!,
      'topic': instance.topic,
      'topicLabel': instance.topicLabel,
      'title': instance.title,
      'content': instance.content,
      'source': instance.source,
      'anonymous': instance.anonymous,
      'flagged': instance.flagged,
      'status': _$AspirationStatusEnumMap[instance.status]!,
      'response': instance.response?.toJson(),
      'board': _$BoardStateEnumMap[instance.board]!,
      'publishedAt': const TimestampConverter().toJson(instance.publishedAt),
      'supportCount': instance.supportCount,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

const _$AspirationTypeEnumMap = {
  AspirationType.saran: 'saran',
  AspirationType.ide: 'ide',
  AspirationType.usulan: 'usulan',
  AspirationType.kritik: 'kritik',
};

const _$AspirationStatusEnumMap = {
  AspirationStatus.diterima: 'diterima',
  AspirationStatus.ditinjau: 'ditinjau',
  AspirationStatus.ditindaklanjuti: 'ditindaklanjuti',
  AspirationStatus.direalisasikan: 'direalisasikan',
  AspirationStatus.belumDapat: 'belum_dapat',
};

const _$BoardStateEnumMap = {
  BoardState.none: 'none',
  BoardState.published: 'published',
  BoardState.hidden: 'hidden',
};

_AspirationIdentity _$AspirationIdentityFromJson(Map<String, dynamic> json) =>
    _AspirationIdentity(
      name: json['name'] as String,
      kelas: json['kelas'] as String?,
    );

Map<String, dynamic> _$AspirationIdentityToJson(_AspirationIdentity instance) =>
    <String, dynamic>{'name': instance.name, 'kelas': instance.kelas};

_AspirationOwner _$AspirationOwnerFromJson(Map<String, dynamic> json) =>
    _AspirationOwner(
      id: json['id'] as String,
      uid: json['uid'] as String,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$AspirationOwnerToJson(_AspirationOwner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
