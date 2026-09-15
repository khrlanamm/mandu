// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_school.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PublicSchool _$PublicSchoolFromJson(Map<String, dynamic> json) =>
    _PublicSchool(
      schoolId: json['schoolId'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      level: json['level'] as String? ?? '',
      city: json['city'] as String? ?? '',
      province: json['province'] as String? ?? '',
      logoUrl: json['logoUrl'] as String?,
      services: json['services'] == null
          ? const ServiceToggles()
          : ServiceToggles.fromJson(json['services'] as Map<String, dynamic>),
      publicAspiration: json['publicAspiration'] as bool? ?? false,
    );

Map<String, dynamic> _$PublicSchoolToJson(_PublicSchool instance) =>
    <String, dynamic>{
      'schoolId': instance.schoolId,
      'code': instance.code,
      'name': instance.name,
      'level': instance.level,
      'city': instance.city,
      'province': instance.province,
      'logoUrl': instance.logoUrl,
      'services': instance.services.toJson(),
      'publicAspiration': instance.publicAspiration,
    };
