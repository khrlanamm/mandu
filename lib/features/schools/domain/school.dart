import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/firebase/callable.dart';

part 'school.freezed.dart';
part 'school.g.dart';

@freezed
abstract class ServiceToggles with _$ServiceToggles {
  const factory ServiceToggles({
    @Default(true) bool lapor,
    @Default(true) bool curhat,
    @Default(true) bool aspirasi,
    @Default(true) bool bantuan,
    @Default(true) bool edukasi,
  }) = _ServiceToggles;

  factory ServiceToggles.fromJson(Map<String, dynamic> json) => _$ServiceTogglesFromJson(json);
}

@freezed
abstract class SlaHours with _$SlaHours {
  const factory SlaHours({
    @Default(24) int verifikasi,
    @Default(72) int tindakLanjut,
    @Default(2) int darurat,
  }) = _SlaHours;

  factory SlaHours.fromJson(Map<String, dynamic> json) => _$SlaHoursFromJson(json);
}

/// Dokumen `schools/{id}`.
@freezed
abstract class School with _$School {
  const factory School({
    required String id,
    required String name,
    required String code,
    String? npsn,
    @Default('SMA') String level,
    String? address,
    @Default('') String city,
    @Default('') String province,
    String? logoUrl,
    @Default(<String>[]) List<String> allowedDomains,
    @Default(true) bool active,
    @Default(ServiceToggles()) ServiceToggles services,
    @Default(true) bool publicAspiration,
    @Default(true) bool aspirationBoard,
    @Default(SlaHours()) SlaHours slaHours,
    @TimestampConverter() DateTime? createdAt,
  }) = _School;

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);
}

/// Dokumen `schools/{id}/units/{unitId}`.
@freezed
abstract class SchoolUnit with _$SchoolUnit {
  const factory SchoolUnit({
    required String id,
    required String name,
    @Default('') String description,
    @Default(<String>[]) List<String> categories,
    @Default(true) bool active,
  }) = _SchoolUnit;

  factory SchoolUnit.fromJson(Map<String, dynamic> json) => _$SchoolUnitFromJson(json);
}
