// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountSummary {

 String get uid; String get displayName; String? get email; bool get isSuperadmin;@JsonKey(unknownEnumValue: AccountStatus.none) AccountStatus get status; String? get schoolId; String? get schoolName;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) SchoolRole? get role; bool get mustChangePassword; bool get needsConsent; bool get claimsUpdated;
/// Create a copy of AccountSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountSummaryCopyWith<AccountSummary> get copyWith => _$AccountSummaryCopyWithImpl<AccountSummary>(this as AccountSummary, _$identity);

  /// Serializes this AccountSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AccountSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountSummary&&(identical(other.uid, _this.uid) || other.uid == _this.uid)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.isSuperadmin, _this.isSuperadmin) || other.isSuperadmin == _this.isSuperadmin)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.schoolId, _this.schoolId) || other.schoolId == _this.schoolId)&&(identical(other.schoolName, _this.schoolName) || other.schoolName == _this.schoolName)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.mustChangePassword, _this.mustChangePassword) || other.mustChangePassword == _this.mustChangePassword)&&(identical(other.needsConsent, _this.needsConsent) || other.needsConsent == _this.needsConsent)&&(identical(other.claimsUpdated, _this.claimsUpdated) || other.claimsUpdated == _this.claimsUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AccountSummary;
  return Object.hash(runtimeType,_this.uid,_this.displayName,_this.email,_this.isSuperadmin,_this.status,_this.schoolId,_this.schoolName,_this.role,_this.mustChangePassword,_this.needsConsent,_this.claimsUpdated);
}

@override
String toString() {
  final _this = this as AccountSummary;
  return 'AccountSummary(uid: ${_this.uid}, displayName: ${_this.displayName}, email: ${_this.email}, isSuperadmin: ${_this.isSuperadmin}, status: ${_this.status}, schoolId: ${_this.schoolId}, schoolName: ${_this.schoolName}, role: ${_this.role}, mustChangePassword: ${_this.mustChangePassword}, needsConsent: ${_this.needsConsent}, claimsUpdated: ${_this.claimsUpdated})';
}


}

/// @nodoc
abstract mixin class $AccountSummaryCopyWith<$Res>  {
  factory $AccountSummaryCopyWith(AccountSummary value, $Res Function(AccountSummary) _then) = _$AccountSummaryCopyWithImpl;
@useResult
$Res call({
 String uid, String displayName, String? email, bool isSuperadmin,@JsonKey(unknownEnumValue: AccountStatus.none) AccountStatus status, String? schoolId, String? schoolName,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) SchoolRole? role, bool mustChangePassword, bool needsConsent, bool claimsUpdated
});




}
/// @nodoc
class _$AccountSummaryCopyWithImpl<$Res>
    implements $AccountSummaryCopyWith<$Res> {
  _$AccountSummaryCopyWithImpl(this._self, this._then);

  final AccountSummary _self;
  final $Res Function(AccountSummary) _then;

/// Create a copy of AccountSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? displayName = null,Object? email = freezed,Object? isSuperadmin = null,Object? status = null,Object? schoolId = freezed,Object? schoolName = freezed,Object? role = freezed,Object? mustChangePassword = null,Object? needsConsent = null,Object? claimsUpdated = null,}) {
  return _then(AccountSummary(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,isSuperadmin: null == isSuperadmin ? _self.isSuperadmin : isSuperadmin // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AccountStatus,schoolId: freezed == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String?,schoolName: freezed == schoolName ? _self.schoolName : schoolName // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as SchoolRole?,mustChangePassword: null == mustChangePassword ? _self.mustChangePassword : mustChangePassword // ignore: cast_nullable_to_non_nullable
as bool,needsConsent: null == needsConsent ? _self.needsConsent : needsConsent // ignore: cast_nullable_to_non_nullable
as bool,claimsUpdated: null == claimsUpdated ? _self.claimsUpdated : claimsUpdated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountSummary].
extension AccountSummaryPatterns on AccountSummary {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountSummary() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountSummary value)  $default,){
final _that = this;
switch (_that) {
case _AccountSummary():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountSummary value)?  $default,){
final _that = this;
switch (_that) {
case _AccountSummary() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String displayName,  String? email,  bool isSuperadmin, @JsonKey(unknownEnumValue: AccountStatus.none)  AccountStatus status,  String? schoolId,  String? schoolName, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  SchoolRole? role,  bool mustChangePassword,  bool needsConsent,  bool claimsUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountSummary() when $default != null:
return $default(_that.uid,_that.displayName,_that.email,_that.isSuperadmin,_that.status,_that.schoolId,_that.schoolName,_that.role,_that.mustChangePassword,_that.needsConsent,_that.claimsUpdated);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String displayName,  String? email,  bool isSuperadmin, @JsonKey(unknownEnumValue: AccountStatus.none)  AccountStatus status,  String? schoolId,  String? schoolName, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  SchoolRole? role,  bool mustChangePassword,  bool needsConsent,  bool claimsUpdated)  $default,) {final _that = this;
switch (_that) {
case _AccountSummary():
return $default(_that.uid,_that.displayName,_that.email,_that.isSuperadmin,_that.status,_that.schoolId,_that.schoolName,_that.role,_that.mustChangePassword,_that.needsConsent,_that.claimsUpdated);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String displayName,  String? email,  bool isSuperadmin, @JsonKey(unknownEnumValue: AccountStatus.none)  AccountStatus status,  String? schoolId,  String? schoolName, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  SchoolRole? role,  bool mustChangePassword,  bool needsConsent,  bool claimsUpdated)?  $default,) {final _that = this;
switch (_that) {
case _AccountSummary() when $default != null:
return $default(_that.uid,_that.displayName,_that.email,_that.isSuperadmin,_that.status,_that.schoolId,_that.schoolName,_that.role,_that.mustChangePassword,_that.needsConsent,_that.claimsUpdated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountSummary extends AccountSummary {
  const _AccountSummary({required this.uid, required this.displayName, this.email, this.isSuperadmin = false, @JsonKey(unknownEnumValue: AccountStatus.none) this.status = AccountStatus.none, this.schoolId, this.schoolName, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.role, this.mustChangePassword = false, this.needsConsent = true, this.claimsUpdated = false}): super._();
  factory _AccountSummary.fromJson(Map<String, dynamic> json) => _$AccountSummaryFromJson(json);

@override final  String uid;
@override final  String displayName;
@override final  String? email;
@override@JsonKey() final  bool isSuperadmin;
@override@JsonKey(unknownEnumValue: AccountStatus.none) final  AccountStatus status;
@override final  String? schoolId;
@override final  String? schoolName;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  SchoolRole? role;
@override@JsonKey() final  bool mustChangePassword;
@override@JsonKey() final  bool needsConsent;
@override@JsonKey() final  bool claimsUpdated;

/// Create a copy of AccountSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountSummaryCopyWith<_AccountSummary> get copyWith => __$AccountSummaryCopyWithImpl<_AccountSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountSummary&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.email, email) || other.email == email)&&(identical(other.isSuperadmin, isSuperadmin) || other.isSuperadmin == isSuperadmin)&&(identical(other.status, status) || other.status == status)&&(identical(other.schoolId, schoolId) || other.schoolId == schoolId)&&(identical(other.schoolName, schoolName) || other.schoolName == schoolName)&&(identical(other.role, role) || other.role == role)&&(identical(other.mustChangePassword, mustChangePassword) || other.mustChangePassword == mustChangePassword)&&(identical(other.needsConsent, needsConsent) || other.needsConsent == needsConsent)&&(identical(other.claimsUpdated, claimsUpdated) || other.claimsUpdated == claimsUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,uid,displayName,email,isSuperadmin,status,schoolId,schoolName,role,mustChangePassword,needsConsent,claimsUpdated);
}

@override
String toString() {
    return 'AccountSummary(uid: $uid, displayName: $displayName, email: $email, isSuperadmin: $isSuperadmin, status: $status, schoolId: $schoolId, schoolName: $schoolName, role: $role, mustChangePassword: $mustChangePassword, needsConsent: $needsConsent, claimsUpdated: $claimsUpdated)';
}


}

/// @nodoc
abstract mixin class _$AccountSummaryCopyWith<$Res> implements $AccountSummaryCopyWith<$Res> {
  factory _$AccountSummaryCopyWith(_AccountSummary value, $Res Function(_AccountSummary) _then) = __$AccountSummaryCopyWithImpl;
@override @useResult
$Res call({
 String uid, String displayName, String? email, bool isSuperadmin,@JsonKey(unknownEnumValue: AccountStatus.none) AccountStatus status, String? schoolId, String? schoolName,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) SchoolRole? role, bool mustChangePassword, bool needsConsent, bool claimsUpdated
});




}
/// @nodoc
class __$AccountSummaryCopyWithImpl<$Res>
    implements _$AccountSummaryCopyWith<$Res> {
  __$AccountSummaryCopyWithImpl(this._self, this._then);

  final _AccountSummary _self;
  final $Res Function(_AccountSummary) _then;

/// Create a copy of AccountSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? displayName = null,Object? email = freezed,Object? isSuperadmin = null,Object? status = null,Object? schoolId = freezed,Object? schoolName = freezed,Object? role = freezed,Object? mustChangePassword = null,Object? needsConsent = null,Object? claimsUpdated = null,}) {
  return _then(_AccountSummary(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,isSuperadmin: null == isSuperadmin ? _self.isSuperadmin : isSuperadmin // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AccountStatus,schoolId: freezed == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String?,schoolName: freezed == schoolName ? _self.schoolName : schoolName // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as SchoolRole?,mustChangePassword: null == mustChangePassword ? _self.mustChangePassword : mustChangePassword // ignore: cast_nullable_to_non_nullable
as bool,needsConsent: null == needsConsent ? _self.needsConsent : needsConsent // ignore: cast_nullable_to_non_nullable
as bool,claimsUpdated: null == claimsUpdated ? _self.claimsUpdated : claimsUpdated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
