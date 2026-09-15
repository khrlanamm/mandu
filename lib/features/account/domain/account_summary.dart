import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../app/env.dart';
import '../../../core/domain/roles.dart';

part 'account_summary.freezed.dart';
part 'account_summary.g.dart';

/// Hasil `account-sync` (functions/src/accounts/sync.ts).
@freezed
abstract class AccountSummary with _$AccountSummary {
  const AccountSummary._();

  const factory AccountSummary({
    required String uid,
    required String displayName,
    String? email,
    @Default(false) bool isSuperadmin,
    @JsonKey(unknownEnumValue: AccountStatus.none) @Default(AccountStatus.none) AccountStatus status,
    String? schoolId,
    String? schoolName,
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) SchoolRole? role,
    @Default(false) bool mustChangePassword,
    @Default(true) bool needsConsent,
    @Default(false) bool claimsUpdated,
  }) = _AccountSummary;

  factory AccountSummary.fromJson(Map<String, dynamic> json) => _$AccountSummaryFromJson(json);

  bool get isActiveMember => status == AccountStatus.active && schoolId != null && role != null;

  bool get isNisnAccount => email?.endsWith('@${Env.nisnEmailDomain}') ?? false;

  String get firstName => displayName.trim().split(RegExp(r'\s+')).first;
}
