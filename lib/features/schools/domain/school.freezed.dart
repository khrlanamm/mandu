// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'school.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServiceToggles {

 bool get lapor; bool get curhat; bool get aspirasi; bool get bantuan; bool get edukasi;
/// Create a copy of ServiceToggles
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceTogglesCopyWith<ServiceToggles> get copyWith => _$ServiceTogglesCopyWithImpl<ServiceToggles>(this as ServiceToggles, _$identity);

  /// Serializes this ServiceToggles to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ServiceToggles;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceToggles&&(identical(other.lapor, _this.lapor) || other.lapor == _this.lapor)&&(identical(other.curhat, _this.curhat) || other.curhat == _this.curhat)&&(identical(other.aspirasi, _this.aspirasi) || other.aspirasi == _this.aspirasi)&&(identical(other.bantuan, _this.bantuan) || other.bantuan == _this.bantuan)&&(identical(other.edukasi, _this.edukasi) || other.edukasi == _this.edukasi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ServiceToggles;
  return Object.hash(runtimeType,_this.lapor,_this.curhat,_this.aspirasi,_this.bantuan,_this.edukasi);
}

@override
String toString() {
  final _this = this as ServiceToggles;
  return 'ServiceToggles(lapor: ${_this.lapor}, curhat: ${_this.curhat}, aspirasi: ${_this.aspirasi}, bantuan: ${_this.bantuan}, edukasi: ${_this.edukasi})';
}


}

/// @nodoc
abstract mixin class $ServiceTogglesCopyWith<$Res>  {
  factory $ServiceTogglesCopyWith(ServiceToggles value, $Res Function(ServiceToggles) _then) = _$ServiceTogglesCopyWithImpl;
@useResult
$Res call({
 bool lapor, bool curhat, bool aspirasi, bool bantuan, bool edukasi
});




}
/// @nodoc
class _$ServiceTogglesCopyWithImpl<$Res>
    implements $ServiceTogglesCopyWith<$Res> {
  _$ServiceTogglesCopyWithImpl(this._self, this._then);

  final ServiceToggles _self;
  final $Res Function(ServiceToggles) _then;

/// Create a copy of ServiceToggles
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lapor = null,Object? curhat = null,Object? aspirasi = null,Object? bantuan = null,Object? edukasi = null,}) {
  return _then(ServiceToggles(
lapor: null == lapor ? _self.lapor : lapor // ignore: cast_nullable_to_non_nullable
as bool,curhat: null == curhat ? _self.curhat : curhat // ignore: cast_nullable_to_non_nullable
as bool,aspirasi: null == aspirasi ? _self.aspirasi : aspirasi // ignore: cast_nullable_to_non_nullable
as bool,bantuan: null == bantuan ? _self.bantuan : bantuan // ignore: cast_nullable_to_non_nullable
as bool,edukasi: null == edukasi ? _self.edukasi : edukasi // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceToggles].
extension ServiceTogglesPatterns on ServiceToggles {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceToggles value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceToggles() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceToggles value)  $default,){
final _that = this;
switch (_that) {
case _ServiceToggles():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceToggles value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceToggles() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool lapor,  bool curhat,  bool aspirasi,  bool bantuan,  bool edukasi)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceToggles() when $default != null:
return $default(_that.lapor,_that.curhat,_that.aspirasi,_that.bantuan,_that.edukasi);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool lapor,  bool curhat,  bool aspirasi,  bool bantuan,  bool edukasi)  $default,) {final _that = this;
switch (_that) {
case _ServiceToggles():
return $default(_that.lapor,_that.curhat,_that.aspirasi,_that.bantuan,_that.edukasi);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool lapor,  bool curhat,  bool aspirasi,  bool bantuan,  bool edukasi)?  $default,) {final _that = this;
switch (_that) {
case _ServiceToggles() when $default != null:
return $default(_that.lapor,_that.curhat,_that.aspirasi,_that.bantuan,_that.edukasi);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServiceToggles implements ServiceToggles {
  const _ServiceToggles({this.lapor = true, this.curhat = true, this.aspirasi = true, this.bantuan = true, this.edukasi = true});
  factory _ServiceToggles.fromJson(Map<String, dynamic> json) => _$ServiceTogglesFromJson(json);

@override@JsonKey() final  bool lapor;
@override@JsonKey() final  bool curhat;
@override@JsonKey() final  bool aspirasi;
@override@JsonKey() final  bool bantuan;
@override@JsonKey() final  bool edukasi;

/// Create a copy of ServiceToggles
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceTogglesCopyWith<_ServiceToggles> get copyWith => __$ServiceTogglesCopyWithImpl<_ServiceToggles>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceTogglesToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceToggles&&(identical(other.lapor, lapor) || other.lapor == lapor)&&(identical(other.curhat, curhat) || other.curhat == curhat)&&(identical(other.aspirasi, aspirasi) || other.aspirasi == aspirasi)&&(identical(other.bantuan, bantuan) || other.bantuan == bantuan)&&(identical(other.edukasi, edukasi) || other.edukasi == edukasi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,lapor,curhat,aspirasi,bantuan,edukasi);
}

@override
String toString() {
    return 'ServiceToggles(lapor: $lapor, curhat: $curhat, aspirasi: $aspirasi, bantuan: $bantuan, edukasi: $edukasi)';
}


}

/// @nodoc
abstract mixin class _$ServiceTogglesCopyWith<$Res> implements $ServiceTogglesCopyWith<$Res> {
  factory _$ServiceTogglesCopyWith(_ServiceToggles value, $Res Function(_ServiceToggles) _then) = __$ServiceTogglesCopyWithImpl;
@override @useResult
$Res call({
 bool lapor, bool curhat, bool aspirasi, bool bantuan, bool edukasi
});




}
/// @nodoc
class __$ServiceTogglesCopyWithImpl<$Res>
    implements _$ServiceTogglesCopyWith<$Res> {
  __$ServiceTogglesCopyWithImpl(this._self, this._then);

  final _ServiceToggles _self;
  final $Res Function(_ServiceToggles) _then;

/// Create a copy of ServiceToggles
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lapor = null,Object? curhat = null,Object? aspirasi = null,Object? bantuan = null,Object? edukasi = null,}) {
  return _then(_ServiceToggles(
lapor: null == lapor ? _self.lapor : lapor // ignore: cast_nullable_to_non_nullable
as bool,curhat: null == curhat ? _self.curhat : curhat // ignore: cast_nullable_to_non_nullable
as bool,aspirasi: null == aspirasi ? _self.aspirasi : aspirasi // ignore: cast_nullable_to_non_nullable
as bool,bantuan: null == bantuan ? _self.bantuan : bantuan // ignore: cast_nullable_to_non_nullable
as bool,edukasi: null == edukasi ? _self.edukasi : edukasi // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SlaHours {

 int get verifikasi; int get tindakLanjut; int get darurat;
/// Create a copy of SlaHours
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlaHoursCopyWith<SlaHours> get copyWith => _$SlaHoursCopyWithImpl<SlaHours>(this as SlaHours, _$identity);

  /// Serializes this SlaHours to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SlaHours;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlaHours&&(identical(other.verifikasi, _this.verifikasi) || other.verifikasi == _this.verifikasi)&&(identical(other.tindakLanjut, _this.tindakLanjut) || other.tindakLanjut == _this.tindakLanjut)&&(identical(other.darurat, _this.darurat) || other.darurat == _this.darurat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SlaHours;
  return Object.hash(runtimeType,_this.verifikasi,_this.tindakLanjut,_this.darurat);
}

@override
String toString() {
  final _this = this as SlaHours;
  return 'SlaHours(verifikasi: ${_this.verifikasi}, tindakLanjut: ${_this.tindakLanjut}, darurat: ${_this.darurat})';
}


}

/// @nodoc
abstract mixin class $SlaHoursCopyWith<$Res>  {
  factory $SlaHoursCopyWith(SlaHours value, $Res Function(SlaHours) _then) = _$SlaHoursCopyWithImpl;
@useResult
$Res call({
 int verifikasi, int tindakLanjut, int darurat
});




}
/// @nodoc
class _$SlaHoursCopyWithImpl<$Res>
    implements $SlaHoursCopyWith<$Res> {
  _$SlaHoursCopyWithImpl(this._self, this._then);

  final SlaHours _self;
  final $Res Function(SlaHours) _then;

/// Create a copy of SlaHours
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? verifikasi = null,Object? tindakLanjut = null,Object? darurat = null,}) {
  return _then(SlaHours(
verifikasi: null == verifikasi ? _self.verifikasi : verifikasi // ignore: cast_nullable_to_non_nullable
as int,tindakLanjut: null == tindakLanjut ? _self.tindakLanjut : tindakLanjut // ignore: cast_nullable_to_non_nullable
as int,darurat: null == darurat ? _self.darurat : darurat // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SlaHours].
extension SlaHoursPatterns on SlaHours {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SlaHours value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SlaHours() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SlaHours value)  $default,){
final _that = this;
switch (_that) {
case _SlaHours():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SlaHours value)?  $default,){
final _that = this;
switch (_that) {
case _SlaHours() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int verifikasi,  int tindakLanjut,  int darurat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SlaHours() when $default != null:
return $default(_that.verifikasi,_that.tindakLanjut,_that.darurat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int verifikasi,  int tindakLanjut,  int darurat)  $default,) {final _that = this;
switch (_that) {
case _SlaHours():
return $default(_that.verifikasi,_that.tindakLanjut,_that.darurat);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int verifikasi,  int tindakLanjut,  int darurat)?  $default,) {final _that = this;
switch (_that) {
case _SlaHours() when $default != null:
return $default(_that.verifikasi,_that.tindakLanjut,_that.darurat);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SlaHours implements SlaHours {
  const _SlaHours({this.verifikasi = 24, this.tindakLanjut = 72, this.darurat = 2});
  factory _SlaHours.fromJson(Map<String, dynamic> json) => _$SlaHoursFromJson(json);

@override@JsonKey() final  int verifikasi;
@override@JsonKey() final  int tindakLanjut;
@override@JsonKey() final  int darurat;

/// Create a copy of SlaHours
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SlaHoursCopyWith<_SlaHours> get copyWith => __$SlaHoursCopyWithImpl<_SlaHours>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SlaHoursToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SlaHours&&(identical(other.verifikasi, verifikasi) || other.verifikasi == verifikasi)&&(identical(other.tindakLanjut, tindakLanjut) || other.tindakLanjut == tindakLanjut)&&(identical(other.darurat, darurat) || other.darurat == darurat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,verifikasi,tindakLanjut,darurat);
}

@override
String toString() {
    return 'SlaHours(verifikasi: $verifikasi, tindakLanjut: $tindakLanjut, darurat: $darurat)';
}


}

/// @nodoc
abstract mixin class _$SlaHoursCopyWith<$Res> implements $SlaHoursCopyWith<$Res> {
  factory _$SlaHoursCopyWith(_SlaHours value, $Res Function(_SlaHours) _then) = __$SlaHoursCopyWithImpl;
@override @useResult
$Res call({
 int verifikasi, int tindakLanjut, int darurat
});




}
/// @nodoc
class __$SlaHoursCopyWithImpl<$Res>
    implements _$SlaHoursCopyWith<$Res> {
  __$SlaHoursCopyWithImpl(this._self, this._then);

  final _SlaHours _self;
  final $Res Function(_SlaHours) _then;

/// Create a copy of SlaHours
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? verifikasi = null,Object? tindakLanjut = null,Object? darurat = null,}) {
  return _then(_SlaHours(
verifikasi: null == verifikasi ? _self.verifikasi : verifikasi // ignore: cast_nullable_to_non_nullable
as int,tindakLanjut: null == tindakLanjut ? _self.tindakLanjut : tindakLanjut // ignore: cast_nullable_to_non_nullable
as int,darurat: null == darurat ? _self.darurat : darurat // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$School {

 String get id; String get name; String get code; String? get npsn; String get level; String? get address; String get city; String get province; String? get logoUrl; List<String> get allowedDomains; bool get active; ServiceToggles get services; bool get publicAspiration; bool get aspirationBoard; SlaHours get slaHours;@TimestampConverter() DateTime? get createdAt;
/// Create a copy of School
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SchoolCopyWith<School> get copyWith => _$SchoolCopyWithImpl<School>(this as School, _$identity);

  /// Serializes this School to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as School;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is School&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.npsn, _this.npsn) || other.npsn == _this.npsn)&&(identical(other.level, _this.level) || other.level == _this.level)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.province, _this.province) || other.province == _this.province)&&(identical(other.logoUrl, _this.logoUrl) || other.logoUrl == _this.logoUrl)&&const DeepCollectionEquality().equals(other.allowedDomains, _this.allowedDomains)&&(identical(other.active, _this.active) || other.active == _this.active)&&(identical(other.services, _this.services) || other.services == _this.services)&&(identical(other.publicAspiration, _this.publicAspiration) || other.publicAspiration == _this.publicAspiration)&&(identical(other.aspirationBoard, _this.aspirationBoard) || other.aspirationBoard == _this.aspirationBoard)&&(identical(other.slaHours, _this.slaHours) || other.slaHours == _this.slaHours)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as School;
  return Object.hash(runtimeType,_this.id,_this.name,_this.code,_this.npsn,_this.level,_this.address,_this.city,_this.province,_this.logoUrl,const DeepCollectionEquality().hash(_this.allowedDomains),_this.active,_this.services,_this.publicAspiration,_this.aspirationBoard,_this.slaHours,_this.createdAt);
}

@override
String toString() {
  final _this = this as School;
  return 'School(id: ${_this.id}, name: ${_this.name}, code: ${_this.code}, npsn: ${_this.npsn}, level: ${_this.level}, address: ${_this.address}, city: ${_this.city}, province: ${_this.province}, logoUrl: ${_this.logoUrl}, allowedDomains: ${_this.allowedDomains}, active: ${_this.active}, services: ${_this.services}, publicAspiration: ${_this.publicAspiration}, aspirationBoard: ${_this.aspirationBoard}, slaHours: ${_this.slaHours}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $SchoolCopyWith<$Res>  {
  factory $SchoolCopyWith(School value, $Res Function(School) _then) = _$SchoolCopyWithImpl;
@useResult
$Res call({
 String id, String name, String code, String? npsn, String level, String? address, String city, String province, String? logoUrl, List<String> allowedDomains, bool active, ServiceToggles services, bool publicAspiration, bool aspirationBoard, SlaHours slaHours,@TimestampConverter() DateTime? createdAt
});


$ServiceTogglesCopyWith<$Res> get services;$SlaHoursCopyWith<$Res> get slaHours;

}
/// @nodoc
class _$SchoolCopyWithImpl<$Res>
    implements $SchoolCopyWith<$Res> {
  _$SchoolCopyWithImpl(this._self, this._then);

  final School _self;
  final $Res Function(School) _then;

/// Create a copy of School
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? code = null,Object? npsn = freezed,Object? level = null,Object? address = freezed,Object? city = null,Object? province = null,Object? logoUrl = freezed,Object? allowedDomains = null,Object? active = null,Object? services = null,Object? publicAspiration = null,Object? aspirationBoard = null,Object? slaHours = null,Object? createdAt = freezed,}) {
  return _then(School(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,npsn: freezed == npsn ? _self.npsn : npsn // ignore: cast_nullable_to_non_nullable
as String?,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,allowedDomains: null == allowedDomains ? _self.allowedDomains : allowedDomains // ignore: cast_nullable_to_non_nullable
as List<String>,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,services: null == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as ServiceToggles,publicAspiration: null == publicAspiration ? _self.publicAspiration : publicAspiration // ignore: cast_nullable_to_non_nullable
as bool,aspirationBoard: null == aspirationBoard ? _self.aspirationBoard : aspirationBoard // ignore: cast_nullable_to_non_nullable
as bool,slaHours: null == slaHours ? _self.slaHours : slaHours // ignore: cast_nullable_to_non_nullable
as SlaHours,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of School
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceTogglesCopyWith<$Res> get services {
  
  return $ServiceTogglesCopyWith<$Res>(_self.services, (value) {
    return _then(_self.copyWith(services: value));
  });
}/// Create a copy of School
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SlaHoursCopyWith<$Res> get slaHours {
  
  return $SlaHoursCopyWith<$Res>(_self.slaHours, (value) {
    return _then(_self.copyWith(slaHours: value));
  });
}
}


/// Adds pattern-matching-related methods to [School].
extension SchoolPatterns on School {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _School value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _School() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _School value)  $default,){
final _that = this;
switch (_that) {
case _School():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _School value)?  $default,){
final _that = this;
switch (_that) {
case _School() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String code,  String? npsn,  String level,  String? address,  String city,  String province,  String? logoUrl,  List<String> allowedDomains,  bool active,  ServiceToggles services,  bool publicAspiration,  bool aspirationBoard,  SlaHours slaHours, @TimestampConverter()  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _School() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.npsn,_that.level,_that.address,_that.city,_that.province,_that.logoUrl,_that.allowedDomains,_that.active,_that.services,_that.publicAspiration,_that.aspirationBoard,_that.slaHours,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String code,  String? npsn,  String level,  String? address,  String city,  String province,  String? logoUrl,  List<String> allowedDomains,  bool active,  ServiceToggles services,  bool publicAspiration,  bool aspirationBoard,  SlaHours slaHours, @TimestampConverter()  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _School():
return $default(_that.id,_that.name,_that.code,_that.npsn,_that.level,_that.address,_that.city,_that.province,_that.logoUrl,_that.allowedDomains,_that.active,_that.services,_that.publicAspiration,_that.aspirationBoard,_that.slaHours,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String code,  String? npsn,  String level,  String? address,  String city,  String province,  String? logoUrl,  List<String> allowedDomains,  bool active,  ServiceToggles services,  bool publicAspiration,  bool aspirationBoard,  SlaHours slaHours, @TimestampConverter()  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _School() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.npsn,_that.level,_that.address,_that.city,_that.province,_that.logoUrl,_that.allowedDomains,_that.active,_that.services,_that.publicAspiration,_that.aspirationBoard,_that.slaHours,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _School implements School {
  const _School({required this.id, required this.name, required this.code, this.npsn, this.level = 'SMA', this.address, this.city = '', this.province = '', this.logoUrl,  List<String> allowedDomains = const <String>[], this.active = true, this.services = const ServiceToggles(), this.publicAspiration = true, this.aspirationBoard = true, this.slaHours = const SlaHours(), @TimestampConverter() this.createdAt}): _allowedDomains = allowedDomains;
  factory _School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);

@override final  String id;
@override final  String name;
@override final  String code;
@override final  String? npsn;
@override@JsonKey() final  String level;
@override final  String? address;
@override@JsonKey() final  String city;
@override@JsonKey() final  String province;
@override final  String? logoUrl;
 final  List<String> _allowedDomains;
@override@JsonKey() List<String> get allowedDomains {
  if (_allowedDomains is EqualUnmodifiableListView) return _allowedDomains;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allowedDomains);
}

@override@JsonKey() final  bool active;
@override@JsonKey() final  ServiceToggles services;
@override@JsonKey() final  bool publicAspiration;
@override@JsonKey() final  bool aspirationBoard;
@override@JsonKey() final  SlaHours slaHours;
@override@TimestampConverter() final  DateTime? createdAt;

/// Create a copy of School
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SchoolCopyWith<_School> get copyWith => __$SchoolCopyWithImpl<_School>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SchoolToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _School&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.npsn, npsn) || other.npsn == npsn)&&(identical(other.level, level) || other.level == level)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&const DeepCollectionEquality().equals(other.allowedDomains, _allowedDomains)&&(identical(other.active, active) || other.active == active)&&(identical(other.services, services) || other.services == services)&&(identical(other.publicAspiration, publicAspiration) || other.publicAspiration == publicAspiration)&&(identical(other.aspirationBoard, aspirationBoard) || other.aspirationBoard == aspirationBoard)&&(identical(other.slaHours, slaHours) || other.slaHours == slaHours)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,code,npsn,level,address,city,province,logoUrl,const DeepCollectionEquality().hash(_allowedDomains),active,services,publicAspiration,aspirationBoard,slaHours,createdAt);
}

@override
String toString() {
    return 'School(id: $id, name: $name, code: $code, npsn: $npsn, level: $level, address: $address, city: $city, province: $province, logoUrl: $logoUrl, allowedDomains: $allowedDomains, active: $active, services: $services, publicAspiration: $publicAspiration, aspirationBoard: $aspirationBoard, slaHours: $slaHours, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SchoolCopyWith<$Res> implements $SchoolCopyWith<$Res> {
  factory _$SchoolCopyWith(_School value, $Res Function(_School) _then) = __$SchoolCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String code, String? npsn, String level, String? address, String city, String province, String? logoUrl, List<String> allowedDomains, bool active, ServiceToggles services, bool publicAspiration, bool aspirationBoard, SlaHours slaHours,@TimestampConverter() DateTime? createdAt
});


@override $ServiceTogglesCopyWith<$Res> get services;@override $SlaHoursCopyWith<$Res> get slaHours;

}
/// @nodoc
class __$SchoolCopyWithImpl<$Res>
    implements _$SchoolCopyWith<$Res> {
  __$SchoolCopyWithImpl(this._self, this._then);

  final _School _self;
  final $Res Function(_School) _then;

/// Create a copy of School
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? code = null,Object? npsn = freezed,Object? level = null,Object? address = freezed,Object? city = null,Object? province = null,Object? logoUrl = freezed,Object? allowedDomains = null,Object? active = null,Object? services = null,Object? publicAspiration = null,Object? aspirationBoard = null,Object? slaHours = null,Object? createdAt = freezed,}) {
  return _then(_School(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,npsn: freezed == npsn ? _self.npsn : npsn // ignore: cast_nullable_to_non_nullable
as String?,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,allowedDomains: null == allowedDomains ? _self._allowedDomains : allowedDomains // ignore: cast_nullable_to_non_nullable
as List<String>,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,services: null == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as ServiceToggles,publicAspiration: null == publicAspiration ? _self.publicAspiration : publicAspiration // ignore: cast_nullable_to_non_nullable
as bool,aspirationBoard: null == aspirationBoard ? _self.aspirationBoard : aspirationBoard // ignore: cast_nullable_to_non_nullable
as bool,slaHours: null == slaHours ? _self.slaHours : slaHours // ignore: cast_nullable_to_non_nullable
as SlaHours,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of School
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceTogglesCopyWith<$Res> get services {
  
  return $ServiceTogglesCopyWith<$Res>(_self.services, (value) {
    return _then(_self.copyWith(services: value));
  });
}/// Create a copy of School
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SlaHoursCopyWith<$Res> get slaHours {
  
  return $SlaHoursCopyWith<$Res>(_self.slaHours, (value) {
    return _then(_self.copyWith(slaHours: value));
  });
}
}


/// @nodoc
mixin _$SchoolUnit {

 String get id; String get name; String get description; List<String> get categories; bool get active;
/// Create a copy of SchoolUnit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SchoolUnitCopyWith<SchoolUnit> get copyWith => _$SchoolUnitCopyWithImpl<SchoolUnit>(this as SchoolUnit, _$identity);

  /// Serializes this SchoolUnit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SchoolUnit;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SchoolUnit&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&(identical(other.active, _this.active) || other.active == _this.active));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SchoolUnit;
  return Object.hash(runtimeType,_this.id,_this.name,_this.description,const DeepCollectionEquality().hash(_this.categories),_this.active);
}

@override
String toString() {
  final _this = this as SchoolUnit;
  return 'SchoolUnit(id: ${_this.id}, name: ${_this.name}, description: ${_this.description}, categories: ${_this.categories}, active: ${_this.active})';
}


}

/// @nodoc
abstract mixin class $SchoolUnitCopyWith<$Res>  {
  factory $SchoolUnitCopyWith(SchoolUnit value, $Res Function(SchoolUnit) _then) = _$SchoolUnitCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, List<String> categories, bool active
});




}
/// @nodoc
class _$SchoolUnitCopyWithImpl<$Res>
    implements $SchoolUnitCopyWith<$Res> {
  _$SchoolUnitCopyWithImpl(this._self, this._then);

  final SchoolUnit _self;
  final $Res Function(SchoolUnit) _then;

/// Create a copy of SchoolUnit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? categories = null,Object? active = null,}) {
  return _then(SchoolUnit(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SchoolUnit].
extension SchoolUnitPatterns on SchoolUnit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SchoolUnit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SchoolUnit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SchoolUnit value)  $default,){
final _that = this;
switch (_that) {
case _SchoolUnit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SchoolUnit value)?  $default,){
final _that = this;
switch (_that) {
case _SchoolUnit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  List<String> categories,  bool active)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SchoolUnit() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.categories,_that.active);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  List<String> categories,  bool active)  $default,) {final _that = this;
switch (_that) {
case _SchoolUnit():
return $default(_that.id,_that.name,_that.description,_that.categories,_that.active);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  List<String> categories,  bool active)?  $default,) {final _that = this;
switch (_that) {
case _SchoolUnit() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.categories,_that.active);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SchoolUnit implements SchoolUnit {
  const _SchoolUnit({required this.id, required this.name, this.description = '',  List<String> categories = const <String>[], this.active = true}): _categories = categories;
  factory _SchoolUnit.fromJson(Map<String, dynamic> json) => _$SchoolUnitFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  String description;
 final  List<String> _categories;
@override@JsonKey() List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey() final  bool active;

/// Create a copy of SchoolUnit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SchoolUnitCopyWith<_SchoolUnit> get copyWith => __$SchoolUnitCopyWithImpl<_SchoolUnit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SchoolUnitToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SchoolUnit&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.categories, _categories)&&(identical(other.active, active) || other.active == active));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,description,const DeepCollectionEquality().hash(_categories),active);
}

@override
String toString() {
    return 'SchoolUnit(id: $id, name: $name, description: $description, categories: $categories, active: $active)';
}


}

/// @nodoc
abstract mixin class _$SchoolUnitCopyWith<$Res> implements $SchoolUnitCopyWith<$Res> {
  factory _$SchoolUnitCopyWith(_SchoolUnit value, $Res Function(_SchoolUnit) _then) = __$SchoolUnitCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, List<String> categories, bool active
});




}
/// @nodoc
class __$SchoolUnitCopyWithImpl<$Res>
    implements _$SchoolUnitCopyWith<$Res> {
  __$SchoolUnitCopyWithImpl(this._self, this._then);

  final _SchoolUnit _self;
  final $Res Function(_SchoolUnit) _then;

/// Create a copy of SchoolUnit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? categories = null,Object? active = null,}) {
  return _then(_SchoolUnit(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
