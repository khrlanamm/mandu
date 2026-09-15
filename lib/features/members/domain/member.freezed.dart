// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Member {

 String get uid; String get displayName; String? get email;@JsonKey(unknownEnumValue: SchoolRole.siswa) SchoolRole get role; List<String> get units; bool get canVerify;@JsonKey(unknownEnumValue: MemberStatus.pending) MemberStatus get status;@JsonKey(unknownEnumValue: JoinMethod.code) JoinMethod get joinedVia; String? get kelas; String? get nisn; String? get rejectionReason;@TimestampConverter() DateTime? get createdAt;@TimestampConverter() DateTime? get updatedAt;
/// Create a copy of Member
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberCopyWith<Member> get copyWith => _$MemberCopyWithImpl<Member>(this as Member, _$identity);

  /// Serializes this Member to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Member;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Member&&(identical(other.uid, _this.uid) || other.uid == _this.uid)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.role, _this.role) || other.role == _this.role)&&const DeepCollectionEquality().equals(other.units, _this.units)&&(identical(other.canVerify, _this.canVerify) || other.canVerify == _this.canVerify)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.joinedVia, _this.joinedVia) || other.joinedVia == _this.joinedVia)&&(identical(other.kelas, _this.kelas) || other.kelas == _this.kelas)&&(identical(other.nisn, _this.nisn) || other.nisn == _this.nisn)&&(identical(other.rejectionReason, _this.rejectionReason) || other.rejectionReason == _this.rejectionReason)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Member;
  return Object.hash(runtimeType,_this.uid,_this.displayName,_this.email,_this.role,const DeepCollectionEquality().hash(_this.units),_this.canVerify,_this.status,_this.joinedVia,_this.kelas,_this.nisn,_this.rejectionReason,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as Member;
  return 'Member(uid: ${_this.uid}, displayName: ${_this.displayName}, email: ${_this.email}, role: ${_this.role}, units: ${_this.units}, canVerify: ${_this.canVerify}, status: ${_this.status}, joinedVia: ${_this.joinedVia}, kelas: ${_this.kelas}, nisn: ${_this.nisn}, rejectionReason: ${_this.rejectionReason}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $MemberCopyWith<$Res>  {
  factory $MemberCopyWith(Member value, $Res Function(Member) _then) = _$MemberCopyWithImpl;
@useResult
$Res call({
 String uid, String displayName, String? email,@JsonKey(unknownEnumValue: SchoolRole.siswa) SchoolRole role, List<String> units, bool canVerify,@JsonKey(unknownEnumValue: MemberStatus.pending) MemberStatus status,@JsonKey(unknownEnumValue: JoinMethod.code) JoinMethod joinedVia, String? kelas, String? nisn, String? rejectionReason,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class _$MemberCopyWithImpl<$Res>
    implements $MemberCopyWith<$Res> {
  _$MemberCopyWithImpl(this._self, this._then);

  final Member _self;
  final $Res Function(Member) _then;

/// Create a copy of Member
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? displayName = null,Object? email = freezed,Object? role = null,Object? units = null,Object? canVerify = null,Object? status = null,Object? joinedVia = null,Object? kelas = freezed,Object? nisn = freezed,Object? rejectionReason = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(Member(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as SchoolRole,units: null == units ? _self.units : units // ignore: cast_nullable_to_non_nullable
as List<String>,canVerify: null == canVerify ? _self.canVerify : canVerify // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MemberStatus,joinedVia: null == joinedVia ? _self.joinedVia : joinedVia // ignore: cast_nullable_to_non_nullable
as JoinMethod,kelas: freezed == kelas ? _self.kelas : kelas // ignore: cast_nullable_to_non_nullable
as String?,nisn: freezed == nisn ? _self.nisn : nisn // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Member].
extension MemberPatterns on Member {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Member value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Member() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Member value)  $default,){
final _that = this;
switch (_that) {
case _Member():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Member value)?  $default,){
final _that = this;
switch (_that) {
case _Member() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String displayName,  String? email, @JsonKey(unknownEnumValue: SchoolRole.siswa)  SchoolRole role,  List<String> units,  bool canVerify, @JsonKey(unknownEnumValue: MemberStatus.pending)  MemberStatus status, @JsonKey(unknownEnumValue: JoinMethod.code)  JoinMethod joinedVia,  String? kelas,  String? nisn,  String? rejectionReason, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Member() when $default != null:
return $default(_that.uid,_that.displayName,_that.email,_that.role,_that.units,_that.canVerify,_that.status,_that.joinedVia,_that.kelas,_that.nisn,_that.rejectionReason,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String displayName,  String? email, @JsonKey(unknownEnumValue: SchoolRole.siswa)  SchoolRole role,  List<String> units,  bool canVerify, @JsonKey(unknownEnumValue: MemberStatus.pending)  MemberStatus status, @JsonKey(unknownEnumValue: JoinMethod.code)  JoinMethod joinedVia,  String? kelas,  String? nisn,  String? rejectionReason, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Member():
return $default(_that.uid,_that.displayName,_that.email,_that.role,_that.units,_that.canVerify,_that.status,_that.joinedVia,_that.kelas,_that.nisn,_that.rejectionReason,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String displayName,  String? email, @JsonKey(unknownEnumValue: SchoolRole.siswa)  SchoolRole role,  List<String> units,  bool canVerify, @JsonKey(unknownEnumValue: MemberStatus.pending)  MemberStatus status, @JsonKey(unknownEnumValue: JoinMethod.code)  JoinMethod joinedVia,  String? kelas,  String? nisn,  String? rejectionReason, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Member() when $default != null:
return $default(_that.uid,_that.displayName,_that.email,_that.role,_that.units,_that.canVerify,_that.status,_that.joinedVia,_that.kelas,_that.nisn,_that.rejectionReason,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Member extends Member {
  const _Member({required this.uid, required this.displayName, this.email, @JsonKey(unknownEnumValue: SchoolRole.siswa) this.role = SchoolRole.siswa,  List<String> units = const <String>[], this.canVerify = false, @JsonKey(unknownEnumValue: MemberStatus.pending) this.status = MemberStatus.pending, @JsonKey(unknownEnumValue: JoinMethod.code) this.joinedVia = JoinMethod.code, this.kelas, this.nisn, this.rejectionReason, @TimestampConverter() this.createdAt, @TimestampConverter() this.updatedAt}): _units = units,super._();
  factory _Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

@override final  String uid;
@override final  String displayName;
@override final  String? email;
@override@JsonKey(unknownEnumValue: SchoolRole.siswa) final  SchoolRole role;
 final  List<String> _units;
@override@JsonKey() List<String> get units {
  if (_units is EqualUnmodifiableListView) return _units;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_units);
}

@override@JsonKey() final  bool canVerify;
@override@JsonKey(unknownEnumValue: MemberStatus.pending) final  MemberStatus status;
@override@JsonKey(unknownEnumValue: JoinMethod.code) final  JoinMethod joinedVia;
@override final  String? kelas;
@override final  String? nisn;
@override final  String? rejectionReason;
@override@TimestampConverter() final  DateTime? createdAt;
@override@TimestampConverter() final  DateTime? updatedAt;

/// Create a copy of Member
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberCopyWith<_Member> get copyWith => __$MemberCopyWithImpl<_Member>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Member&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.email, email) || other.email == email)&&(identical(other.role, role) || other.role == role)&&const DeepCollectionEquality().equals(other.units, _units)&&(identical(other.canVerify, canVerify) || other.canVerify == canVerify)&&(identical(other.status, status) || other.status == status)&&(identical(other.joinedVia, joinedVia) || other.joinedVia == joinedVia)&&(identical(other.kelas, kelas) || other.kelas == kelas)&&(identical(other.nisn, nisn) || other.nisn == nisn)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,uid,displayName,email,role,const DeepCollectionEquality().hash(_units),canVerify,status,joinedVia,kelas,nisn,rejectionReason,createdAt,updatedAt);
}

@override
String toString() {
    return 'Member(uid: $uid, displayName: $displayName, email: $email, role: $role, units: $units, canVerify: $canVerify, status: $status, joinedVia: $joinedVia, kelas: $kelas, nisn: $nisn, rejectionReason: $rejectionReason, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MemberCopyWith<$Res> implements $MemberCopyWith<$Res> {
  factory _$MemberCopyWith(_Member value, $Res Function(_Member) _then) = __$MemberCopyWithImpl;
@override @useResult
$Res call({
 String uid, String displayName, String? email,@JsonKey(unknownEnumValue: SchoolRole.siswa) SchoolRole role, List<String> units, bool canVerify,@JsonKey(unknownEnumValue: MemberStatus.pending) MemberStatus status,@JsonKey(unknownEnumValue: JoinMethod.code) JoinMethod joinedVia, String? kelas, String? nisn, String? rejectionReason,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class __$MemberCopyWithImpl<$Res>
    implements _$MemberCopyWith<$Res> {
  __$MemberCopyWithImpl(this._self, this._then);

  final _Member _self;
  final $Res Function(_Member) _then;

/// Create a copy of Member
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? displayName = null,Object? email = freezed,Object? role = null,Object? units = null,Object? canVerify = null,Object? status = null,Object? joinedVia = null,Object? kelas = freezed,Object? nisn = freezed,Object? rejectionReason = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Member(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as SchoolRole,units: null == units ? _self._units : units // ignore: cast_nullable_to_non_nullable
as List<String>,canVerify: null == canVerify ? _self.canVerify : canVerify // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MemberStatus,joinedVia: null == joinedVia ? _self.joinedVia : joinedVia // ignore: cast_nullable_to_non_nullable
as JoinMethod,kelas: freezed == kelas ? _self.kelas : kelas // ignore: cast_nullable_to_non_nullable
as String?,nisn: freezed == nisn ? _self.nisn : nisn // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$Invitation {

 String get id; String get email; String get schoolId; String get schoolName;@JsonKey(unknownEnumValue: SchoolRole.petugas) SchoolRole get role; List<String> get units; bool get canVerify; String? get displayName;@JsonKey(unknownEnumValue: InvitationStatus.pending) InvitationStatus get status;@TimestampConverter() DateTime? get createdAt;
/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvitationCopyWith<Invitation> get copyWith => _$InvitationCopyWithImpl<Invitation>(this as Invitation, _$identity);

  /// Serializes this Invitation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Invitation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Invitation&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.schoolId, _this.schoolId) || other.schoolId == _this.schoolId)&&(identical(other.schoolName, _this.schoolName) || other.schoolName == _this.schoolName)&&(identical(other.role, _this.role) || other.role == _this.role)&&const DeepCollectionEquality().equals(other.units, _this.units)&&(identical(other.canVerify, _this.canVerify) || other.canVerify == _this.canVerify)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Invitation;
  return Object.hash(runtimeType,_this.id,_this.email,_this.schoolId,_this.schoolName,_this.role,const DeepCollectionEquality().hash(_this.units),_this.canVerify,_this.displayName,_this.status,_this.createdAt);
}

@override
String toString() {
  final _this = this as Invitation;
  return 'Invitation(id: ${_this.id}, email: ${_this.email}, schoolId: ${_this.schoolId}, schoolName: ${_this.schoolName}, role: ${_this.role}, units: ${_this.units}, canVerify: ${_this.canVerify}, displayName: ${_this.displayName}, status: ${_this.status}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $InvitationCopyWith<$Res>  {
  factory $InvitationCopyWith(Invitation value, $Res Function(Invitation) _then) = _$InvitationCopyWithImpl;
@useResult
$Res call({
 String id, String email, String schoolId, String schoolName,@JsonKey(unknownEnumValue: SchoolRole.petugas) SchoolRole role, List<String> units, bool canVerify, String? displayName,@JsonKey(unknownEnumValue: InvitationStatus.pending) InvitationStatus status,@TimestampConverter() DateTime? createdAt
});




}
/// @nodoc
class _$InvitationCopyWithImpl<$Res>
    implements $InvitationCopyWith<$Res> {
  _$InvitationCopyWithImpl(this._self, this._then);

  final Invitation _self;
  final $Res Function(Invitation) _then;

/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? schoolId = null,Object? schoolName = null,Object? role = null,Object? units = null,Object? canVerify = null,Object? displayName = freezed,Object? status = null,Object? createdAt = freezed,}) {
  return _then(Invitation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,schoolId: null == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String,schoolName: null == schoolName ? _self.schoolName : schoolName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as SchoolRole,units: null == units ? _self.units : units // ignore: cast_nullable_to_non_nullable
as List<String>,canVerify: null == canVerify ? _self.canVerify : canVerify // ignore: cast_nullable_to_non_nullable
as bool,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InvitationStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Invitation].
extension InvitationPatterns on Invitation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Invitation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Invitation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Invitation value)  $default,){
final _that = this;
switch (_that) {
case _Invitation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Invitation value)?  $default,){
final _that = this;
switch (_that) {
case _Invitation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String schoolId,  String schoolName, @JsonKey(unknownEnumValue: SchoolRole.petugas)  SchoolRole role,  List<String> units,  bool canVerify,  String? displayName, @JsonKey(unknownEnumValue: InvitationStatus.pending)  InvitationStatus status, @TimestampConverter()  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Invitation() when $default != null:
return $default(_that.id,_that.email,_that.schoolId,_that.schoolName,_that.role,_that.units,_that.canVerify,_that.displayName,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String schoolId,  String schoolName, @JsonKey(unknownEnumValue: SchoolRole.petugas)  SchoolRole role,  List<String> units,  bool canVerify,  String? displayName, @JsonKey(unknownEnumValue: InvitationStatus.pending)  InvitationStatus status, @TimestampConverter()  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Invitation():
return $default(_that.id,_that.email,_that.schoolId,_that.schoolName,_that.role,_that.units,_that.canVerify,_that.displayName,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String schoolId,  String schoolName, @JsonKey(unknownEnumValue: SchoolRole.petugas)  SchoolRole role,  List<String> units,  bool canVerify,  String? displayName, @JsonKey(unknownEnumValue: InvitationStatus.pending)  InvitationStatus status, @TimestampConverter()  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Invitation() when $default != null:
return $default(_that.id,_that.email,_that.schoolId,_that.schoolName,_that.role,_that.units,_that.canVerify,_that.displayName,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Invitation implements Invitation {
  const _Invitation({required this.id, required this.email, required this.schoolId, this.schoolName = '', @JsonKey(unknownEnumValue: SchoolRole.petugas) this.role = SchoolRole.petugas,  List<String> units = const <String>[], this.canVerify = false, this.displayName, @JsonKey(unknownEnumValue: InvitationStatus.pending) this.status = InvitationStatus.pending, @TimestampConverter() this.createdAt}): _units = units;
  factory _Invitation.fromJson(Map<String, dynamic> json) => _$InvitationFromJson(json);

@override final  String id;
@override final  String email;
@override final  String schoolId;
@override@JsonKey() final  String schoolName;
@override@JsonKey(unknownEnumValue: SchoolRole.petugas) final  SchoolRole role;
 final  List<String> _units;
@override@JsonKey() List<String> get units {
  if (_units is EqualUnmodifiableListView) return _units;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_units);
}

@override@JsonKey() final  bool canVerify;
@override final  String? displayName;
@override@JsonKey(unknownEnumValue: InvitationStatus.pending) final  InvitationStatus status;
@override@TimestampConverter() final  DateTime? createdAt;

/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvitationCopyWith<_Invitation> get copyWith => __$InvitationCopyWithImpl<_Invitation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvitationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Invitation&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.schoolId, schoolId) || other.schoolId == schoolId)&&(identical(other.schoolName, schoolName) || other.schoolName == schoolName)&&(identical(other.role, role) || other.role == role)&&const DeepCollectionEquality().equals(other.units, _units)&&(identical(other.canVerify, canVerify) || other.canVerify == canVerify)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,email,schoolId,schoolName,role,const DeepCollectionEquality().hash(_units),canVerify,displayName,status,createdAt);
}

@override
String toString() {
    return 'Invitation(id: $id, email: $email, schoolId: $schoolId, schoolName: $schoolName, role: $role, units: $units, canVerify: $canVerify, displayName: $displayName, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$InvitationCopyWith<$Res> implements $InvitationCopyWith<$Res> {
  factory _$InvitationCopyWith(_Invitation value, $Res Function(_Invitation) _then) = __$InvitationCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String schoolId, String schoolName,@JsonKey(unknownEnumValue: SchoolRole.petugas) SchoolRole role, List<String> units, bool canVerify, String? displayName,@JsonKey(unknownEnumValue: InvitationStatus.pending) InvitationStatus status,@TimestampConverter() DateTime? createdAt
});




}
/// @nodoc
class __$InvitationCopyWithImpl<$Res>
    implements _$InvitationCopyWith<$Res> {
  __$InvitationCopyWithImpl(this._self, this._then);

  final _Invitation _self;
  final $Res Function(_Invitation) _then;

/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? schoolId = null,Object? schoolName = null,Object? role = null,Object? units = null,Object? canVerify = null,Object? displayName = freezed,Object? status = null,Object? createdAt = freezed,}) {
  return _then(_Invitation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,schoolId: null == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String,schoolName: null == schoolName ? _self.schoolName : schoolName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as SchoolRole,units: null == units ? _self._units : units // ignore: cast_nullable_to_non_nullable
as List<String>,canVerify: null == canVerify ? _self.canVerify : canVerify // ignore: cast_nullable_to_non_nullable
as bool,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InvitationStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
