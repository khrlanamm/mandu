import 'package:freezed_annotation/freezed_annotation.dart';

import 'school.dart';

part 'public_school.freezed.dart';
part 'public_school.g.dart';

/// Hasil `schools-lookup`: informasi publik sekolah dari kodenya.
@freezed
abstract class PublicSchool with _$PublicSchool {
  const factory PublicSchool({
    required String schoolId,
    required String code,
    required String name,
    @Default('') String level,
    @Default('') String city,
    @Default('') String province,
    String? logoUrl,
    @Default(ServiceToggles()) ServiceToggles services,
    @Default(false) bool publicAspiration,
  }) = _PublicSchool;

  factory PublicSchool.fromJson(Map<String, dynamic> json) => _$PublicSchoolFromJson(json);
}
