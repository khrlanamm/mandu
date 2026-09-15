// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Member _$MemberFromJson(Map<String, dynamic> json) => _Member(
  uid: json['uid'] as String,
  displayName: json['displayName'] as String,
  email: json['email'] as String?,
  role:
      $enumDecodeNullable(
        _$SchoolRoleEnumMap,
        json['role'],
        unknownValue: SchoolRole.siswa,
      ) ??
      SchoolRole.siswa,
  units:
      (json['units'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  canVerify: json['canVerify'] as bool? ?? false,
  status:
      $enumDecodeNullable(
        _$MemberStatusEnumMap,
        json['status'],
        unknownValue: MemberStatus.pending,
      ) ??
      MemberStatus.pending,
  joinedVia:
      $enumDecodeNullable(
        _$JoinMethodEnumMap,
        json['joinedVia'],
        unknownValue: JoinMethod.code,
      ) ??
      JoinMethod.code,
  kelas: json['kelas'] as String?,
  nisn: json['nisn'] as String?,
  rejectionReason: json['rejectionReason'] as String?,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$MemberToJson(_Member instance) => <String, dynamic>{
  'uid': instance.uid,
  'displayName': instance.displayName,
  'email': instance.email,
  'role': _$SchoolRoleEnumMap[instance.role]!,
  'units': instance.units,
  'canVerify': instance.canVerify,
  'status': _$MemberStatusEnumMap[instance.status]!,
  'joinedVia': _$JoinMethodEnumMap[instance.joinedVia]!,
  'kelas': instance.kelas,
  'nisn': instance.nisn,
  'rejectionReason': instance.rejectionReason,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};

const _$SchoolRoleEnumMap = {
  SchoolRole.admin: 'admin',
  SchoolRole.pimpinan: 'pimpinan',
  SchoolRole.konselor: 'konselor',
  SchoolRole.petugas: 'petugas',
  SchoolRole.siswa: 'siswa',
};

const _$MemberStatusEnumMap = {
  MemberStatus.pending: 'pending',
  MemberStatus.active: 'active',
  MemberStatus.rejected: 'rejected',
  MemberStatus.removed: 'removed',
};

const _$JoinMethodEnumMap = {
  JoinMethod.code: 'code',
  JoinMethod.domain: 'domain',
  JoinMethod.nisn: 'nisn',
  JoinMethod.invite: 'invite',
  JoinMethod.migration: 'migration',
};

_Invitation _$InvitationFromJson(Map<String, dynamic> json) => _Invitation(
  id: json['id'] as String,
  email: json['email'] as String,
  schoolId: json['schoolId'] as String,
  schoolName: json['schoolName'] as String? ?? '',
  role:
      $enumDecodeNullable(
        _$SchoolRoleEnumMap,
        json['role'],
        unknownValue: SchoolRole.petugas,
      ) ??
      SchoolRole.petugas,
  units:
      (json['units'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  canVerify: json['canVerify'] as bool? ?? false,
  displayName: json['displayName'] as String?,
  status:
      $enumDecodeNullable(
        _$InvitationStatusEnumMap,
        json['status'],
        unknownValue: InvitationStatus.pending,
      ) ??
      InvitationStatus.pending,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$InvitationToJson(_Invitation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'schoolId': instance.schoolId,
      'schoolName': instance.schoolName,
      'role': _$SchoolRoleEnumMap[instance.role]!,
      'units': instance.units,
      'canVerify': instance.canVerify,
      'displayName': instance.displayName,
      'status': _$InvitationStatusEnumMap[instance.status]!,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };

const _$InvitationStatusEnumMap = {
  InvitationStatus.pending: 'pending',
  InvitationStatus.accepted: 'accepted',
  InvitationStatus.revoked: 'revoked',
};
