// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'public_school.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PublicSchool {

 String get schoolId; String get code; String get name; String get level; String get city; String get province; String? get logoUrl; ServiceToggles get services; bool get publicAspiration;
/// Create a copy of PublicSchool
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicSchoolCopyWith<PublicSchool> get copyWith => _$PublicSchoolCopyWithImpl<PublicSchool>(this as PublicSchool, _$identity);

  /// Serializes this PublicSchool to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PublicSchool;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicSchool&&(identical(other.schoolId, _this.schoolId) || other.schoolId == _this.schoolId)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.level, _this.level) || other.level == _this.level)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.province, _this.province) || other.province == _this.province)&&(identical(other.logoUrl, _this.logoUrl) || other.logoUrl == _this.logoUrl)&&(identical(other.services, _this.services) || other.services == _this.services)&&(identical(other.publicAspiration, _this.publicAspiration) || other.publicAspiration == _this.publicAspiration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PublicSchool;
  return Object.hash(runtimeType,_this.schoolId,_this.code,_this.name,_this.level,_this.city,_this.province,_this.logoUrl,_this.services,_this.publicAspiration);
}

@override
String toString() {
  final _this = this as PublicSchool;
  return 'PublicSchool(schoolId: ${_this.schoolId}, code: ${_this.code}, name: ${_this.name}, level: ${_this.level}, city: ${_this.city}, province: ${_this.province}, logoUrl: ${_this.logoUrl}, services: ${_this.services}, publicAspiration: ${_this.publicAspiration})';
}


}

/// @nodoc
abstract mixin class $PublicSchoolCopyWith<$Res>  {
  factory $PublicSchoolCopyWith(PublicSchool value, $Res Function(PublicSchool) _then) = _$PublicSchoolCopyWithImpl;
@useResult
$Res call({
 String schoolId, String code, String name, String level, String city, String province, String? logoUrl, ServiceToggles services, bool publicAspiration
});


$ServiceTogglesCopyWith<$Res> get services;

}
/// @nodoc
class _$PublicSchoolCopyWithImpl<$Res>
    implements $PublicSchoolCopyWith<$Res> {
  _$PublicSchoolCopyWithImpl(this._self, this._then);

  final PublicSchool _self;
  final $Res Function(PublicSchool) _then;

/// Create a copy of PublicSchool
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schoolId = null,Object? code = null,Object? name = null,Object? level = null,Object? city = null,Object? province = null,Object? logoUrl = freezed,Object? services = null,Object? publicAspiration = null,}) {
  return _then(PublicSchool(
schoolId: null == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,services: null == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as ServiceToggles,publicAspiration: null == publicAspiration ? _self.publicAspiration : publicAspiration // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of PublicSchool
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceTogglesCopyWith<$Res> get services {
  
  return $ServiceTogglesCopyWith<$Res>(_self.services, (value) {
    return _then(_self.copyWith(services: value));
  });
}
}


/// Adds pattern-matching-related methods to [PublicSchool].
extension PublicSchoolPatterns on PublicSchool {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublicSchool value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublicSchool() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublicSchool value)  $default,){
final _that = this;
switch (_that) {
case _PublicSchool():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublicSchool value)?  $default,){
final _that = this;
switch (_that) {
case _PublicSchool() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String schoolId,  String code,  String name,  String level,  String city,  String province,  String? logoUrl,  ServiceToggles services,  bool publicAspiration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublicSchool() when $default != null:
return $default(_that.schoolId,_that.code,_that.name,_that.level,_that.city,_that.province,_that.logoUrl,_that.services,_that.publicAspiration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String schoolId,  String code,  String name,  String level,  String city,  String province,  String? logoUrl,  ServiceToggles services,  bool publicAspiration)  $default,) {final _that = this;
switch (_that) {
case _PublicSchool():
return $default(_that.schoolId,_that.code,_that.name,_that.level,_that.city,_that.province,_that.logoUrl,_that.services,_that.publicAspiration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String schoolId,  String code,  String name,  String level,  String city,  String province,  String? logoUrl,  ServiceToggles services,  bool publicAspiration)?  $default,) {final _that = this;
switch (_that) {
case _PublicSchool() when $default != null:
return $default(_that.schoolId,_that.code,_that.name,_that.level,_that.city,_that.province,_that.logoUrl,_that.services,_that.publicAspiration);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PublicSchool implements PublicSchool {
  const _PublicSchool({required this.schoolId, required this.code, required this.name, this.level = '', this.city = '', this.province = '', this.logoUrl, this.services = const ServiceToggles(), this.publicAspiration = false});
  factory _PublicSchool.fromJson(Map<String, dynamic> json) => _$PublicSchoolFromJson(json);

@override final  String schoolId;
@override final  String code;
@override final  String name;
@override@JsonKey() final  String level;
@override@JsonKey() final  String city;
@override@JsonKey() final  String province;
@override final  String? logoUrl;
@override@JsonKey() final  ServiceToggles services;
@override@JsonKey() final  bool publicAspiration;

/// Create a copy of PublicSchool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicSchoolCopyWith<_PublicSchool> get copyWith => __$PublicSchoolCopyWithImpl<_PublicSchool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicSchoolToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicSchool&&(identical(other.schoolId, schoolId) || other.schoolId == schoolId)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.level, level) || other.level == level)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.services, services) || other.services == services)&&(identical(other.publicAspiration, publicAspiration) || other.publicAspiration == publicAspiration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,schoolId,code,name,level,city,province,logoUrl,services,publicAspiration);
}

@override
String toString() {
    return 'PublicSchool(schoolId: $schoolId, code: $code, name: $name, level: $level, city: $city, province: $province, logoUrl: $logoUrl, services: $services, publicAspiration: $publicAspiration)';
}


}

/// @nodoc
abstract mixin class _$PublicSchoolCopyWith<$Res> implements $PublicSchoolCopyWith<$Res> {
  factory _$PublicSchoolCopyWith(_PublicSchool value, $Res Function(_PublicSchool) _then) = __$PublicSchoolCopyWithImpl;
@override @useResult
$Res call({
 String schoolId, String code, String name, String level, String city, String province, String? logoUrl, ServiceToggles services, bool publicAspiration
});


@override $ServiceTogglesCopyWith<$Res> get services;

}
/// @nodoc
class __$PublicSchoolCopyWithImpl<$Res>
    implements _$PublicSchoolCopyWith<$Res> {
  __$PublicSchoolCopyWithImpl(this._self, this._then);

  final _PublicSchool _self;
  final $Res Function(_PublicSchool) _then;

/// Create a copy of PublicSchool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schoolId = null,Object? code = null,Object? name = null,Object? level = null,Object? city = null,Object? province = null,Object? logoUrl = freezed,Object? services = null,Object? publicAspiration = null,}) {
  return _then(_PublicSchool(
schoolId: null == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,services: null == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as ServiceToggles,publicAspiration: null == publicAspiration ? _self.publicAspiration : publicAspiration // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of PublicSchool
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceTogglesCopyWith<$Res> get services {
  
  return $ServiceTogglesCopyWith<$Res>(_self.services, (value) {
    return _then(_self.copyWith(services: value));
  });
}
}

// dart format on
