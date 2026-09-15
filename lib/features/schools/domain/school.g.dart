// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceToggles _$ServiceTogglesFromJson(Map<String, dynamic> json) =>
    _ServiceToggles(
      lapor: json['lapor'] as bool? ?? true,
      curhat: json['curhat'] as bool? ?? true,
      aspirasi: json['aspirasi'] as bool? ?? true,
      bantuan: json['bantuan'] as bool? ?? true,
      edukasi: json['edukasi'] as bool? ?? true,
    );

Map<String, dynamic> _$ServiceTogglesToJson(_ServiceToggles instance) =>
    <String, dynamic>{
      'lapor': instance.lapor,
      'curhat': instance.curhat,
      'aspirasi': instance.aspirasi,
      'bantuan': instance.bantuan,
      'edukasi': instance.edukasi,
    };

_SlaHours _$SlaHoursFromJson(Map<String, dynamic> json) => _SlaHours(
  verifikasi: (json['verifikasi'] as num?)?.toInt() ?? 24,
  tindakLanjut: (json['tindakLanjut'] as num?)?.toInt() ?? 72,
  darurat: (json['darurat'] as num?)?.toInt() ?? 2,
);

Map<String, dynamic> _$SlaHoursToJson(_SlaHours instance) => <String, dynamic>{
  'verifikasi': instance.verifikasi,
  'tindakLanjut': instance.tindakLanjut,
  'darurat': instance.darurat,
};

_School _$SchoolFromJson(Map<String, dynamic> json) => _School(
  id: json['id'] as String,
  name: json['name'] as String,
  code: json['code'] as String,
  npsn: json['npsn'] as String?,
  level: json['level'] as String? ?? 'SMA',
  address: json['address'] as String?,
  city: json['city'] as String? ?? '',
  province: json['province'] as String? ?? '',
  logoUrl: json['logoUrl'] as String?,
  allowedDomains:
      (json['allowedDomains'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  active: json['active'] as bool? ?? true,
  services: json['services'] == null
      ? const ServiceToggles()
      : ServiceToggles.fromJson(json['services'] as Map<String, dynamic>),
  publicAspiration: json['publicAspiration'] as bool? ?? true,
  aspirationBoard: json['aspirationBoard'] as bool? ?? true,
  slaHours: json['slaHours'] == null
      ? const SlaHours()
      : SlaHours.fromJson(json['slaHours'] as Map<String, dynamic>),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$SchoolToJson(_School instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'code': instance.code,
  'npsn': instance.npsn,
  'level': instance.level,
  'address': instance.address,
  'city': instance.city,
  'province': instance.province,
  'logoUrl': instance.logoUrl,
  'allowedDomains': instance.allowedDomains,
  'active': instance.active,
  'services': instance.services.toJson(),
  'publicAspiration': instance.publicAspiration,
  'aspirationBoard': instance.aspirationBoard,
  'slaHours': instance.slaHours.toJson(),
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
};

_SchoolUnit _$SchoolUnitFromJson(Map<String, dynamic> json) => _SchoolUnit(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String? ?? '',
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  active: json['active'] as bool? ?? true,
);

Map<String, dynamic> _$SchoolUnitToJson(_SchoolUnit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'categories': instance.categories,
      'active': instance.active,
    };
