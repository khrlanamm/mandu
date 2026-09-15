// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountSummary _$AccountSummaryFromJson(Map<String, dynamic> json) =>
    _AccountSummary(
      uid: json['uid'] as String,
      displayName: json['displayName'] as String,
      email: json['email'] as String?,
      isSuperadmin: json['isSuperadmin'] as bool? ?? false,
      status:
          $enumDecodeNullable(
            _$AccountStatusEnumMap,
            json['status'],
            unknownValue: AccountStatus.none,
          ) ??
          AccountStatus.none,
      schoolId: json['schoolId'] as String?,
      schoolName: json['schoolName'] as String?,
      role: $enumDecodeNullable(
        _$SchoolRoleEnumMap,
        json['role'],
        unknownValue: JsonKey.nullForUndefinedEnumValue,
      ),
      mustChangePassword: json['mustChangePassword'] as bool? ?? false,
      needsConsent: json['needsConsent'] as bool? ?? true,
      claimsUpdated: json['claimsUpdated'] as bool? ?? false,
    );

Map<String, dynamic> _$AccountSummaryToJson(_AccountSummary instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'displayName': instance.displayName,
      'email': instance.email,
      'isSuperadmin': instance.isSuperadmin,
      'status': _$AccountStatusEnumMap[instance.status]!,
      'schoolId': instance.schoolId,
      'schoolName': instance.schoolName,
      'role': _$SchoolRoleEnumMap[instance.role],
      'mustChangePassword': instance.mustChangePassword,
      'needsConsent': instance.needsConsent,
      'claimsUpdated': instance.claimsUpdated,
    };

const _$AccountStatusEnumMap = {
  AccountStatus.none: 'none',
  AccountStatus.pending: 'pending',
  AccountStatus.active: 'active',
  AccountStatus.rejected: 'rejected',
  AccountStatus.removed: 'removed',
};

const _$SchoolRoleEnumMap = {
  SchoolRole.admin: 'admin',
  SchoolRole.pimpinan: 'pimpinan',
  SchoolRole.konselor: 'konselor',
  SchoolRole.petugas: 'petugas',
  SchoolRole.siswa: 'siswa',
};
