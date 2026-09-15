import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/roles.dart';
import '../../../core/firebase/callable.dart';

part 'member.freezed.dart';
part 'member.g.dart';

enum MemberStatus { pending, active, rejected, removed }

enum JoinMethod {
  code('Kode sekolah'),
  domain('Email sekolah'),
  nisn('Akun NISN'),
  invite('Undangan'),
  migration('Migrasi MANDU lama');

  const JoinMethod(this.label);

  final String label;
}

/// Dokumen `schools/{schoolId}/members/{uid}`.
@freezed
abstract class Member with _$Member {
  const Member._();

  const factory Member({
    required String uid,
    required String displayName,
    String? email,
    @JsonKey(unknownEnumValue: SchoolRole.siswa) @Default(SchoolRole.siswa) SchoolRole role,
    @Default(<String>[]) List<String> units,
    @Default(false) bool canVerify,
    @JsonKey(unknownEnumValue: MemberStatus.pending) @Default(MemberStatus.pending) MemberStatus status,
    @JsonKey(unknownEnumValue: JoinMethod.code) @Default(JoinMethod.code) JoinMethod joinedVia,
    String? kelas,
    String? nisn,
    String? rejectionReason,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _Member;

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  String get initials {
    final parts = displayName.trim().split(RegExp(r'\s+')).where((part) => part.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    return (parts.first[0] + (parts.length > 1 ? parts.last[0] : '')).toUpperCase();
  }
}

enum InvitationStatus { pending, accepted, revoked }

/// Dokumen `invitations/{id}`.
@freezed
abstract class Invitation with _$Invitation {
  const factory Invitation({
    required String id,
    required String email,
    required String schoolId,
    @Default('') String schoolName,
    @JsonKey(unknownEnumValue: SchoolRole.petugas) @Default(SchoolRole.petugas) SchoolRole role,
    @Default(<String>[]) List<String> units,
    @Default(false) bool canVerify,
    String? displayName,
    @JsonKey(unknownEnumValue: InvitationStatus.pending) @Default(InvitationStatus.pending) InvitationStatus status,
    @TimestampConverter() DateTime? createdAt,
  }) = _Invitation;

  factory Invitation.fromJson(Map<String, dynamic> json) => _$InvitationFromJson(json);
}
