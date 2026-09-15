// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TicketAttachment {

 String get path; String get name; String get contentType; int get size;
/// Create a copy of TicketAttachment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketAttachmentCopyWith<TicketAttachment> get copyWith => _$TicketAttachmentCopyWithImpl<TicketAttachment>(this as TicketAttachment, _$identity);

  /// Serializes this TicketAttachment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketAttachment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketAttachment&&(identical(other.path, _this.path) || other.path == _this.path)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.contentType, _this.contentType) || other.contentType == _this.contentType)&&(identical(other.size, _this.size) || other.size == _this.size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketAttachment;
  return Object.hash(runtimeType,_this.path,_this.name,_this.contentType,_this.size);
}

@override
String toString() {
  final _this = this as TicketAttachment;
  return 'TicketAttachment(path: ${_this.path}, name: ${_this.name}, contentType: ${_this.contentType}, size: ${_this.size})';
}


}

/// @nodoc
abstract mixin class $TicketAttachmentCopyWith<$Res>  {
  factory $TicketAttachmentCopyWith(TicketAttachment value, $Res Function(TicketAttachment) _then) = _$TicketAttachmentCopyWithImpl;
@useResult
$Res call({
 String path, String name, String contentType, int size
});




}
/// @nodoc
class _$TicketAttachmentCopyWithImpl<$Res>
    implements $TicketAttachmentCopyWith<$Res> {
  _$TicketAttachmentCopyWithImpl(this._self, this._then);

  final TicketAttachment _self;
  final $Res Function(TicketAttachment) _then;

/// Create a copy of TicketAttachment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? path = null,Object? name = null,Object? contentType = null,Object? size = null,}) {
  return _then(TicketAttachment(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketAttachment].
extension TicketAttachmentPatterns on TicketAttachment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketAttachment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketAttachment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketAttachment value)  $default,){
final _that = this;
switch (_that) {
case _TicketAttachment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketAttachment value)?  $default,){
final _that = this;
switch (_that) {
case _TicketAttachment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String path,  String name,  String contentType,  int size)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketAttachment() when $default != null:
return $default(_that.path,_that.name,_that.contentType,_that.size);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String path,  String name,  String contentType,  int size)  $default,) {final _that = this;
switch (_that) {
case _TicketAttachment():
return $default(_that.path,_that.name,_that.contentType,_that.size);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String path,  String name,  String contentType,  int size)?  $default,) {final _that = this;
switch (_that) {
case _TicketAttachment() when $default != null:
return $default(_that.path,_that.name,_that.contentType,_that.size);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketAttachment extends TicketAttachment {
  const _TicketAttachment({required this.path, required this.name, this.contentType = 'application/octet-stream', this.size = 0}): super._();
  factory _TicketAttachment.fromJson(Map<String, dynamic> json) => _$TicketAttachmentFromJson(json);

@override final  String path;
@override final  String name;
@override@JsonKey() final  String contentType;
@override@JsonKey() final  int size;

/// Create a copy of TicketAttachment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketAttachmentCopyWith<_TicketAttachment> get copyWith => __$TicketAttachmentCopyWithImpl<_TicketAttachment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketAttachmentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketAttachment&&(identical(other.path, path) || other.path == path)&&(identical(other.name, name) || other.name == name)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,path,name,contentType,size);
}

@override
String toString() {
    return 'TicketAttachment(path: $path, name: $name, contentType: $contentType, size: $size)';
}


}

/// @nodoc
abstract mixin class _$TicketAttachmentCopyWith<$Res> implements $TicketAttachmentCopyWith<$Res> {
  factory _$TicketAttachmentCopyWith(_TicketAttachment value, $Res Function(_TicketAttachment) _then) = __$TicketAttachmentCopyWithImpl;
@override @useResult
$Res call({
 String path, String name, String contentType, int size
});




}
/// @nodoc
class __$TicketAttachmentCopyWithImpl<$Res>
    implements _$TicketAttachmentCopyWith<$Res> {
  __$TicketAttachmentCopyWithImpl(this._self, this._then);

  final _TicketAttachment _self;
  final $Res Function(_TicketAttachment) _then;

/// Create a copy of TicketAttachment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? path = null,Object? name = null,Object? contentType = null,Object? size = null,}) {
  return _then(_TicketAttachment(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TicketDetails {

 String? get role; String? get frequency; String? get involved;
/// Create a copy of TicketDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketDetailsCopyWith<TicketDetails> get copyWith => _$TicketDetailsCopyWithImpl<TicketDetails>(this as TicketDetails, _$identity);

  /// Serializes this TicketDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketDetails;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketDetails&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.frequency, _this.frequency) || other.frequency == _this.frequency)&&(identical(other.involved, _this.involved) || other.involved == _this.involved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketDetails;
  return Object.hash(runtimeType,_this.role,_this.frequency,_this.involved);
}

@override
String toString() {
  final _this = this as TicketDetails;
  return 'TicketDetails(role: ${_this.role}, frequency: ${_this.frequency}, involved: ${_this.involved})';
}


}

/// @nodoc
abstract mixin class $TicketDetailsCopyWith<$Res>  {
  factory $TicketDetailsCopyWith(TicketDetails value, $Res Function(TicketDetails) _then) = _$TicketDetailsCopyWithImpl;
@useResult
$Res call({
 String? role, String? frequency, String? involved
});




}
/// @nodoc
class _$TicketDetailsCopyWithImpl<$Res>
    implements $TicketDetailsCopyWith<$Res> {
  _$TicketDetailsCopyWithImpl(this._self, this._then);

  final TicketDetails _self;
  final $Res Function(TicketDetails) _then;

/// Create a copy of TicketDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? role = freezed,Object? frequency = freezed,Object? involved = freezed,}) {
  return _then(TicketDetails(
role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,frequency: freezed == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as String?,involved: freezed == involved ? _self.involved : involved // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketDetails].
extension TicketDetailsPatterns on TicketDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketDetails value)  $default,){
final _that = this;
switch (_that) {
case _TicketDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketDetails value)?  $default,){
final _that = this;
switch (_that) {
case _TicketDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? role,  String? frequency,  String? involved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketDetails() when $default != null:
return $default(_that.role,_that.frequency,_that.involved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? role,  String? frequency,  String? involved)  $default,) {final _that = this;
switch (_that) {
case _TicketDetails():
return $default(_that.role,_that.frequency,_that.involved);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? role,  String? frequency,  String? involved)?  $default,) {final _that = this;
switch (_that) {
case _TicketDetails() when $default != null:
return $default(_that.role,_that.frequency,_that.involved);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketDetails implements TicketDetails {
  const _TicketDetails({this.role, this.frequency, this.involved});
  factory _TicketDetails.fromJson(Map<String, dynamic> json) => _$TicketDetailsFromJson(json);

@override final  String? role;
@override final  String? frequency;
@override final  String? involved;

/// Create a copy of TicketDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketDetailsCopyWith<_TicketDetails> get copyWith => __$TicketDetailsCopyWithImpl<_TicketDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketDetails&&(identical(other.role, role) || other.role == role)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.involved, involved) || other.involved == involved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,role,frequency,involved);
}

@override
String toString() {
    return 'TicketDetails(role: $role, frequency: $frequency, involved: $involved)';
}


}

/// @nodoc
abstract mixin class _$TicketDetailsCopyWith<$Res> implements $TicketDetailsCopyWith<$Res> {
  factory _$TicketDetailsCopyWith(_TicketDetails value, $Res Function(_TicketDetails) _then) = __$TicketDetailsCopyWithImpl;
@override @useResult
$Res call({
 String? role, String? frequency, String? involved
});




}
/// @nodoc
class __$TicketDetailsCopyWithImpl<$Res>
    implements _$TicketDetailsCopyWith<$Res> {
  __$TicketDetailsCopyWithImpl(this._self, this._then);

  final _TicketDetails _self;
  final $Res Function(_TicketDetails) _then;

/// Create a copy of TicketDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = freezed,Object? frequency = freezed,Object? involved = freezed,}) {
  return _then(_TicketDetails(
role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,frequency: freezed == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as String?,involved: freezed == involved ? _self.involved : involved // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TicketReporter {

 String get name; String? get kelas;
/// Create a copy of TicketReporter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketReporterCopyWith<TicketReporter> get copyWith => _$TicketReporterCopyWithImpl<TicketReporter>(this as TicketReporter, _$identity);

  /// Serializes this TicketReporter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketReporter;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketReporter&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.kelas, _this.kelas) || other.kelas == _this.kelas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketReporter;
  return Object.hash(runtimeType,_this.name,_this.kelas);
}

@override
String toString() {
  final _this = this as TicketReporter;
  return 'TicketReporter(name: ${_this.name}, kelas: ${_this.kelas})';
}


}

/// @nodoc
abstract mixin class $TicketReporterCopyWith<$Res>  {
  factory $TicketReporterCopyWith(TicketReporter value, $Res Function(TicketReporter) _then) = _$TicketReporterCopyWithImpl;
@useResult
$Res call({
 String name, String? kelas
});




}
/// @nodoc
class _$TicketReporterCopyWithImpl<$Res>
    implements $TicketReporterCopyWith<$Res> {
  _$TicketReporterCopyWithImpl(this._self, this._then);

  final TicketReporter _self;
  final $Res Function(TicketReporter) _then;

/// Create a copy of TicketReporter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? kelas = freezed,}) {
  return _then(TicketReporter(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kelas: freezed == kelas ? _self.kelas : kelas // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketReporter].
extension TicketReporterPatterns on TicketReporter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketReporter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketReporter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketReporter value)  $default,){
final _that = this;
switch (_that) {
case _TicketReporter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketReporter value)?  $default,){
final _that = this;
switch (_that) {
case _TicketReporter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? kelas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketReporter() when $default != null:
return $default(_that.name,_that.kelas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? kelas)  $default,) {final _that = this;
switch (_that) {
case _TicketReporter():
return $default(_that.name,_that.kelas);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? kelas)?  $default,) {final _that = this;
switch (_that) {
case _TicketReporter() when $default != null:
return $default(_that.name,_that.kelas);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketReporter implements TicketReporter {
  const _TicketReporter({required this.name, this.kelas});
  factory _TicketReporter.fromJson(Map<String, dynamic> json) => _$TicketReporterFromJson(json);

@override final  String name;
@override final  String? kelas;

/// Create a copy of TicketReporter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketReporterCopyWith<_TicketReporter> get copyWith => __$TicketReporterCopyWithImpl<_TicketReporter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketReporterToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketReporter&&(identical(other.name, name) || other.name == name)&&(identical(other.kelas, kelas) || other.kelas == kelas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,kelas);
}

@override
String toString() {
    return 'TicketReporter(name: $name, kelas: $kelas)';
}


}

/// @nodoc
abstract mixin class _$TicketReporterCopyWith<$Res> implements $TicketReporterCopyWith<$Res> {
  factory _$TicketReporterCopyWith(_TicketReporter value, $Res Function(_TicketReporter) _then) = __$TicketReporterCopyWithImpl;
@override @useResult
$Res call({
 String name, String? kelas
});




}
/// @nodoc
class __$TicketReporterCopyWithImpl<$Res>
    implements _$TicketReporterCopyWith<$Res> {
  __$TicketReporterCopyWithImpl(this._self, this._then);

  final _TicketReporter _self;
  final $Res Function(_TicketReporter) _then;

/// Create a copy of TicketReporter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? kelas = freezed,}) {
  return _then(_TicketReporter(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kelas: freezed == kelas ? _self.kelas : kelas // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$InfoRequest {

 String get message;@TimestampConverter() DateTime? get requestedAt;
/// Create a copy of InfoRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InfoRequestCopyWith<InfoRequest> get copyWith => _$InfoRequestCopyWithImpl<InfoRequest>(this as InfoRequest, _$identity);

  /// Serializes this InfoRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as InfoRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InfoRequest&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.requestedAt, _this.requestedAt) || other.requestedAt == _this.requestedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as InfoRequest;
  return Object.hash(runtimeType,_this.message,_this.requestedAt);
}

@override
String toString() {
  final _this = this as InfoRequest;
  return 'InfoRequest(message: ${_this.message}, requestedAt: ${_this.requestedAt})';
}


}

/// @nodoc
abstract mixin class $InfoRequestCopyWith<$Res>  {
  factory $InfoRequestCopyWith(InfoRequest value, $Res Function(InfoRequest) _then) = _$InfoRequestCopyWithImpl;
@useResult
$Res call({
 String message,@TimestampConverter() DateTime? requestedAt
});




}
/// @nodoc
class _$InfoRequestCopyWithImpl<$Res>
    implements $InfoRequestCopyWith<$Res> {
  _$InfoRequestCopyWithImpl(this._self, this._then);

  final InfoRequest _self;
  final $Res Function(InfoRequest) _then;

/// Create a copy of InfoRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? requestedAt = freezed,}) {
  return _then(InfoRequest(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [InfoRequest].
extension InfoRequestPatterns on InfoRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InfoRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InfoRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InfoRequest value)  $default,){
final _that = this;
switch (_that) {
case _InfoRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InfoRequest value)?  $default,){
final _that = this;
switch (_that) {
case _InfoRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message, @TimestampConverter()  DateTime? requestedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InfoRequest() when $default != null:
return $default(_that.message,_that.requestedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message, @TimestampConverter()  DateTime? requestedAt)  $default,) {final _that = this;
switch (_that) {
case _InfoRequest():
return $default(_that.message,_that.requestedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message, @TimestampConverter()  DateTime? requestedAt)?  $default,) {final _that = this;
switch (_that) {
case _InfoRequest() when $default != null:
return $default(_that.message,_that.requestedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InfoRequest implements InfoRequest {
  const _InfoRequest({required this.message, @TimestampConverter() this.requestedAt});
  factory _InfoRequest.fromJson(Map<String, dynamic> json) => _$InfoRequestFromJson(json);

@override final  String message;
@override@TimestampConverter() final  DateTime? requestedAt;

/// Create a copy of InfoRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InfoRequestCopyWith<_InfoRequest> get copyWith => __$InfoRequestCopyWithImpl<_InfoRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InfoRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InfoRequest&&(identical(other.message, message) || other.message == message)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,message,requestedAt);
}

@override
String toString() {
    return 'InfoRequest(message: $message, requestedAt: $requestedAt)';
}


}

/// @nodoc
abstract mixin class _$InfoRequestCopyWith<$Res> implements $InfoRequestCopyWith<$Res> {
  factory _$InfoRequestCopyWith(_InfoRequest value, $Res Function(_InfoRequest) _then) = __$InfoRequestCopyWithImpl;
@override @useResult
$Res call({
 String message,@TimestampConverter() DateTime? requestedAt
});




}
/// @nodoc
class __$InfoRequestCopyWithImpl<$Res>
    implements _$InfoRequestCopyWith<$Res> {
  __$InfoRequestCopyWithImpl(this._self, this._then);

  final _InfoRequest _self;
  final $Res Function(_InfoRequest) _then;

/// Create a copy of InfoRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? requestedAt = freezed,}) {
  return _then(_InfoRequest(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$TicketResolution {

 String get note; List<TicketAttachment> get attachments; String get resolvedByName;@TimestampConverter() DateTime? get resolvedAt;
/// Create a copy of TicketResolution
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketResolutionCopyWith<TicketResolution> get copyWith => _$TicketResolutionCopyWithImpl<TicketResolution>(this as TicketResolution, _$identity);

  /// Serializes this TicketResolution to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketResolution;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketResolution&&(identical(other.note, _this.note) || other.note == _this.note)&&const DeepCollectionEquality().equals(other.attachments, _this.attachments)&&(identical(other.resolvedByName, _this.resolvedByName) || other.resolvedByName == _this.resolvedByName)&&(identical(other.resolvedAt, _this.resolvedAt) || other.resolvedAt == _this.resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketResolution;
  return Object.hash(runtimeType,_this.note,const DeepCollectionEquality().hash(_this.attachments),_this.resolvedByName,_this.resolvedAt);
}

@override
String toString() {
  final _this = this as TicketResolution;
  return 'TicketResolution(note: ${_this.note}, attachments: ${_this.attachments}, resolvedByName: ${_this.resolvedByName}, resolvedAt: ${_this.resolvedAt})';
}


}

/// @nodoc
abstract mixin class $TicketResolutionCopyWith<$Res>  {
  factory $TicketResolutionCopyWith(TicketResolution value, $Res Function(TicketResolution) _then) = _$TicketResolutionCopyWithImpl;
@useResult
$Res call({
 String note, List<TicketAttachment> attachments, String resolvedByName,@TimestampConverter() DateTime? resolvedAt
});




}
/// @nodoc
class _$TicketResolutionCopyWithImpl<$Res>
    implements $TicketResolutionCopyWith<$Res> {
  _$TicketResolutionCopyWithImpl(this._self, this._then);

  final TicketResolution _self;
  final $Res Function(TicketResolution) _then;

/// Create a copy of TicketResolution
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? note = null,Object? attachments = null,Object? resolvedByName = null,Object? resolvedAt = freezed,}) {
  return _then(TicketResolution(
note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,attachments: null == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<TicketAttachment>,resolvedByName: null == resolvedByName ? _self.resolvedByName : resolvedByName // ignore: cast_nullable_to_non_nullable
as String,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketResolution].
extension TicketResolutionPatterns on TicketResolution {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketResolution value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketResolution() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketResolution value)  $default,){
final _that = this;
switch (_that) {
case _TicketResolution():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketResolution value)?  $default,){
final _that = this;
switch (_that) {
case _TicketResolution() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String note,  List<TicketAttachment> attachments,  String resolvedByName, @TimestampConverter()  DateTime? resolvedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketResolution() when $default != null:
return $default(_that.note,_that.attachments,_that.resolvedByName,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String note,  List<TicketAttachment> attachments,  String resolvedByName, @TimestampConverter()  DateTime? resolvedAt)  $default,) {final _that = this;
switch (_that) {
case _TicketResolution():
return $default(_that.note,_that.attachments,_that.resolvedByName,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String note,  List<TicketAttachment> attachments,  String resolvedByName, @TimestampConverter()  DateTime? resolvedAt)?  $default,) {final _that = this;
switch (_that) {
case _TicketResolution() when $default != null:
return $default(_that.note,_that.attachments,_that.resolvedByName,_that.resolvedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketResolution implements TicketResolution {
  const _TicketResolution({required this.note,  List<TicketAttachment> attachments = const <TicketAttachment>[], this.resolvedByName = '', @TimestampConverter() this.resolvedAt}): _attachments = attachments;
  factory _TicketResolution.fromJson(Map<String, dynamic> json) => _$TicketResolutionFromJson(json);

@override final  String note;
 final  List<TicketAttachment> _attachments;
@override@JsonKey() List<TicketAttachment> get attachments {
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachments);
}

@override@JsonKey() final  String resolvedByName;
@override@TimestampConverter() final  DateTime? resolvedAt;

/// Create a copy of TicketResolution
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketResolutionCopyWith<_TicketResolution> get copyWith => __$TicketResolutionCopyWithImpl<_TicketResolution>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketResolutionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketResolution&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other.attachments, _attachments)&&(identical(other.resolvedByName, resolvedByName) || other.resolvedByName == resolvedByName)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,note,const DeepCollectionEquality().hash(_attachments),resolvedByName,resolvedAt);
}

@override
String toString() {
    return 'TicketResolution(note: $note, attachments: $attachments, resolvedByName: $resolvedByName, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class _$TicketResolutionCopyWith<$Res> implements $TicketResolutionCopyWith<$Res> {
  factory _$TicketResolutionCopyWith(_TicketResolution value, $Res Function(_TicketResolution) _then) = __$TicketResolutionCopyWithImpl;
@override @useResult
$Res call({
 String note, List<TicketAttachment> attachments, String resolvedByName,@TimestampConverter() DateTime? resolvedAt
});




}
/// @nodoc
class __$TicketResolutionCopyWithImpl<$Res>
    implements _$TicketResolutionCopyWith<$Res> {
  __$TicketResolutionCopyWithImpl(this._self, this._then);

  final _TicketResolution _self;
  final $Res Function(_TicketResolution) _then;

/// Create a copy of TicketResolution
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? note = null,Object? attachments = null,Object? resolvedByName = null,Object? resolvedAt = freezed,}) {
  return _then(_TicketResolution(
note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<TicketAttachment>,resolvedByName: null == resolvedByName ? _self.resolvedByName : resolvedByName // ignore: cast_nullable_to_non_nullable
as String,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$TicketRejection {

@JsonKey(unknownEnumValue: RejectReason.lainnya) RejectReason get reason; String? get note;
/// Create a copy of TicketRejection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketRejectionCopyWith<TicketRejection> get copyWith => _$TicketRejectionCopyWithImpl<TicketRejection>(this as TicketRejection, _$identity);

  /// Serializes this TicketRejection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketRejection;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketRejection&&(identical(other.reason, _this.reason) || other.reason == _this.reason)&&(identical(other.note, _this.note) || other.note == _this.note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketRejection;
  return Object.hash(runtimeType,_this.reason,_this.note);
}

@override
String toString() {
  final _this = this as TicketRejection;
  return 'TicketRejection(reason: ${_this.reason}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $TicketRejectionCopyWith<$Res>  {
  factory $TicketRejectionCopyWith(TicketRejection value, $Res Function(TicketRejection) _then) = _$TicketRejectionCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: RejectReason.lainnya) RejectReason reason, String? note
});




}
/// @nodoc
class _$TicketRejectionCopyWithImpl<$Res>
    implements $TicketRejectionCopyWith<$Res> {
  _$TicketRejectionCopyWithImpl(this._self, this._then);

  final TicketRejection _self;
  final $Res Function(TicketRejection) _then;

/// Create a copy of TicketRejection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reason = null,Object? note = freezed,}) {
  return _then(TicketRejection(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as RejectReason,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketRejection].
extension TicketRejectionPatterns on TicketRejection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketRejection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketRejection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketRejection value)  $default,){
final _that = this;
switch (_that) {
case _TicketRejection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketRejection value)?  $default,){
final _that = this;
switch (_that) {
case _TicketRejection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: RejectReason.lainnya)  RejectReason reason,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketRejection() when $default != null:
return $default(_that.reason,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: RejectReason.lainnya)  RejectReason reason,  String? note)  $default,) {final _that = this;
switch (_that) {
case _TicketRejection():
return $default(_that.reason,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: RejectReason.lainnya)  RejectReason reason,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _TicketRejection() when $default != null:
return $default(_that.reason,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketRejection implements TicketRejection {
  const _TicketRejection({@JsonKey(unknownEnumValue: RejectReason.lainnya) this.reason = RejectReason.lainnya, this.note});
  factory _TicketRejection.fromJson(Map<String, dynamic> json) => _$TicketRejectionFromJson(json);

@override@JsonKey(unknownEnumValue: RejectReason.lainnya) final  RejectReason reason;
@override final  String? note;

/// Create a copy of TicketRejection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketRejectionCopyWith<_TicketRejection> get copyWith => __$TicketRejectionCopyWithImpl<_TicketRejection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketRejectionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketRejection&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,reason,note);
}

@override
String toString() {
    return 'TicketRejection(reason: $reason, note: $note)';
}


}

/// @nodoc
abstract mixin class _$TicketRejectionCopyWith<$Res> implements $TicketRejectionCopyWith<$Res> {
  factory _$TicketRejectionCopyWith(_TicketRejection value, $Res Function(_TicketRejection) _then) = __$TicketRejectionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: RejectReason.lainnya) RejectReason reason, String? note
});




}
/// @nodoc
class __$TicketRejectionCopyWithImpl<$Res>
    implements _$TicketRejectionCopyWith<$Res> {
  __$TicketRejectionCopyWithImpl(this._self, this._then);

  final _TicketRejection _self;
  final $Res Function(_TicketRejection) _then;

/// Create a copy of TicketRejection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reason = null,Object? note = freezed,}) {
  return _then(_TicketRejection(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as RejectReason,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TicketRating {

 int get score; String? get comment;@TimestampConverter() DateTime? get ratedAt;
/// Create a copy of TicketRating
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketRatingCopyWith<TicketRating> get copyWith => _$TicketRatingCopyWithImpl<TicketRating>(this as TicketRating, _$identity);

  /// Serializes this TicketRating to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketRating;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketRating&&(identical(other.score, _this.score) || other.score == _this.score)&&(identical(other.comment, _this.comment) || other.comment == _this.comment)&&(identical(other.ratedAt, _this.ratedAt) || other.ratedAt == _this.ratedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketRating;
  return Object.hash(runtimeType,_this.score,_this.comment,_this.ratedAt);
}

@override
String toString() {
  final _this = this as TicketRating;
  return 'TicketRating(score: ${_this.score}, comment: ${_this.comment}, ratedAt: ${_this.ratedAt})';
}


}

/// @nodoc
abstract mixin class $TicketRatingCopyWith<$Res>  {
  factory $TicketRatingCopyWith(TicketRating value, $Res Function(TicketRating) _then) = _$TicketRatingCopyWithImpl;
@useResult
$Res call({
 int score, String? comment,@TimestampConverter() DateTime? ratedAt
});




}
/// @nodoc
class _$TicketRatingCopyWithImpl<$Res>
    implements $TicketRatingCopyWith<$Res> {
  _$TicketRatingCopyWithImpl(this._self, this._then);

  final TicketRating _self;
  final $Res Function(TicketRating) _then;

/// Create a copy of TicketRating
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? score = null,Object? comment = freezed,Object? ratedAt = freezed,}) {
  return _then(TicketRating(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,ratedAt: freezed == ratedAt ? _self.ratedAt : ratedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketRating].
extension TicketRatingPatterns on TicketRating {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketRating value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketRating() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketRating value)  $default,){
final _that = this;
switch (_that) {
case _TicketRating():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketRating value)?  $default,){
final _that = this;
switch (_that) {
case _TicketRating() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int score,  String? comment, @TimestampConverter()  DateTime? ratedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketRating() when $default != null:
return $default(_that.score,_that.comment,_that.ratedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int score,  String? comment, @TimestampConverter()  DateTime? ratedAt)  $default,) {final _that = this;
switch (_that) {
case _TicketRating():
return $default(_that.score,_that.comment,_that.ratedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int score,  String? comment, @TimestampConverter()  DateTime? ratedAt)?  $default,) {final _that = this;
switch (_that) {
case _TicketRating() when $default != null:
return $default(_that.score,_that.comment,_that.ratedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketRating implements TicketRating {
  const _TicketRating({required this.score, this.comment, @TimestampConverter() this.ratedAt});
  factory _TicketRating.fromJson(Map<String, dynamic> json) => _$TicketRatingFromJson(json);

@override final  int score;
@override final  String? comment;
@override@TimestampConverter() final  DateTime? ratedAt;

/// Create a copy of TicketRating
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketRatingCopyWith<_TicketRating> get copyWith => __$TicketRatingCopyWithImpl<_TicketRating>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketRatingToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketRating&&(identical(other.score, score) || other.score == score)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.ratedAt, ratedAt) || other.ratedAt == ratedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,score,comment,ratedAt);
}

@override
String toString() {
    return 'TicketRating(score: $score, comment: $comment, ratedAt: $ratedAt)';
}


}

/// @nodoc
abstract mixin class _$TicketRatingCopyWith<$Res> implements $TicketRatingCopyWith<$Res> {
  factory _$TicketRatingCopyWith(_TicketRating value, $Res Function(_TicketRating) _then) = __$TicketRatingCopyWithImpl;
@override @useResult
$Res call({
 int score, String? comment,@TimestampConverter() DateTime? ratedAt
});




}
/// @nodoc
class __$TicketRatingCopyWithImpl<$Res>
    implements _$TicketRatingCopyWith<$Res> {
  __$TicketRatingCopyWithImpl(this._self, this._then);

  final _TicketRating _self;
  final $Res Function(_TicketRating) _then;

/// Create a copy of TicketRating
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? score = null,Object? comment = freezed,Object? ratedAt = freezed,}) {
  return _then(_TicketRating(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,ratedAt: freezed == ratedAt ? _self.ratedAt : ratedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$TicketSla {

@TimestampConverter() DateTime? get verifyDueAt;@TimestampConverter() DateTime? get resolveDueAt;
/// Create a copy of TicketSla
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketSlaCopyWith<TicketSla> get copyWith => _$TicketSlaCopyWithImpl<TicketSla>(this as TicketSla, _$identity);

  /// Serializes this TicketSla to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketSla;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketSla&&(identical(other.verifyDueAt, _this.verifyDueAt) || other.verifyDueAt == _this.verifyDueAt)&&(identical(other.resolveDueAt, _this.resolveDueAt) || other.resolveDueAt == _this.resolveDueAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketSla;
  return Object.hash(runtimeType,_this.verifyDueAt,_this.resolveDueAt);
}

@override
String toString() {
  final _this = this as TicketSla;
  return 'TicketSla(verifyDueAt: ${_this.verifyDueAt}, resolveDueAt: ${_this.resolveDueAt})';
}


}

/// @nodoc
abstract mixin class $TicketSlaCopyWith<$Res>  {
  factory $TicketSlaCopyWith(TicketSla value, $Res Function(TicketSla) _then) = _$TicketSlaCopyWithImpl;
@useResult
$Res call({
@TimestampConverter() DateTime? verifyDueAt,@TimestampConverter() DateTime? resolveDueAt
});




}
/// @nodoc
class _$TicketSlaCopyWithImpl<$Res>
    implements $TicketSlaCopyWith<$Res> {
  _$TicketSlaCopyWithImpl(this._self, this._then);

  final TicketSla _self;
  final $Res Function(TicketSla) _then;

/// Create a copy of TicketSla
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? verifyDueAt = freezed,Object? resolveDueAt = freezed,}) {
  return _then(TicketSla(
verifyDueAt: freezed == verifyDueAt ? _self.verifyDueAt : verifyDueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resolveDueAt: freezed == resolveDueAt ? _self.resolveDueAt : resolveDueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketSla].
extension TicketSlaPatterns on TicketSla {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketSla value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketSla() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketSla value)  $default,){
final _that = this;
switch (_that) {
case _TicketSla():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketSla value)?  $default,){
final _that = this;
switch (_that) {
case _TicketSla() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@TimestampConverter()  DateTime? verifyDueAt, @TimestampConverter()  DateTime? resolveDueAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketSla() when $default != null:
return $default(_that.verifyDueAt,_that.resolveDueAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@TimestampConverter()  DateTime? verifyDueAt, @TimestampConverter()  DateTime? resolveDueAt)  $default,) {final _that = this;
switch (_that) {
case _TicketSla():
return $default(_that.verifyDueAt,_that.resolveDueAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@TimestampConverter()  DateTime? verifyDueAt, @TimestampConverter()  DateTime? resolveDueAt)?  $default,) {final _that = this;
switch (_that) {
case _TicketSla() when $default != null:
return $default(_that.verifyDueAt,_that.resolveDueAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketSla implements TicketSla {
  const _TicketSla({@TimestampConverter() this.verifyDueAt, @TimestampConverter() this.resolveDueAt});
  factory _TicketSla.fromJson(Map<String, dynamic> json) => _$TicketSlaFromJson(json);

@override@TimestampConverter() final  DateTime? verifyDueAt;
@override@TimestampConverter() final  DateTime? resolveDueAt;

/// Create a copy of TicketSla
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketSlaCopyWith<_TicketSla> get copyWith => __$TicketSlaCopyWithImpl<_TicketSla>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketSlaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketSla&&(identical(other.verifyDueAt, verifyDueAt) || other.verifyDueAt == verifyDueAt)&&(identical(other.resolveDueAt, resolveDueAt) || other.resolveDueAt == resolveDueAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,verifyDueAt,resolveDueAt);
}

@override
String toString() {
    return 'TicketSla(verifyDueAt: $verifyDueAt, resolveDueAt: $resolveDueAt)';
}


}

/// @nodoc
abstract mixin class _$TicketSlaCopyWith<$Res> implements $TicketSlaCopyWith<$Res> {
  factory _$TicketSlaCopyWith(_TicketSla value, $Res Function(_TicketSla) _then) = __$TicketSlaCopyWithImpl;
@override @useResult
$Res call({
@TimestampConverter() DateTime? verifyDueAt,@TimestampConverter() DateTime? resolveDueAt
});




}
/// @nodoc
class __$TicketSlaCopyWithImpl<$Res>
    implements _$TicketSlaCopyWith<$Res> {
  __$TicketSlaCopyWithImpl(this._self, this._then);

  final _TicketSla _self;
  final $Res Function(_TicketSla) _then;

/// Create a copy of TicketSla
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? verifyDueAt = freezed,Object? resolveDueAt = freezed,}) {
  return _then(_TicketSla(
verifyDueAt: freezed == verifyDueAt ? _self.verifyDueAt : verifyDueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resolveDueAt: freezed == resolveDueAt ? _self.resolveDueAt : resolveDueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$Ticket {

 String get id; String get number; String get schoolId; String get category; String get categoryLabel; String get subcategory; String get subcategoryLabel; String get title; String get description; String get location; String? get incidentDate; String? get incidentTime; TicketDetails get details; List<TicketAttachment> get attachments; bool get anonymous; TicketReporter? get reporter; String? get contactWhatsapp;@JsonKey(unknownEnumValue: TicketPriority.normal) TicketPriority get priority; String? get priorityReason; String? get suggestedCategory; String? get possibleDuplicateOf;@JsonKey(unknownEnumValue: TicketStatus.menungguVerifikasi) TicketStatus get status; String? get unitId; String? get unitName; InfoRequest? get infoRequest; TicketResolution? get resolution; TicketRejection? get rejection; TicketRating? get rating; TicketSla get sla;@TimestampConverter() DateTime? get createdAt;@TimestampConverter() DateTime? get updatedAt;@TimestampConverter() DateTime? get verifiedAt;@TimestampConverter() DateTime? get resolvedAt;
/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketCopyWith<Ticket> get copyWith => _$TicketCopyWithImpl<Ticket>(this as Ticket, _$identity);

  /// Serializes this Ticket to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Ticket;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Ticket&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.schoolId, _this.schoolId) || other.schoolId == _this.schoolId)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.categoryLabel, _this.categoryLabel) || other.categoryLabel == _this.categoryLabel)&&(identical(other.subcategory, _this.subcategory) || other.subcategory == _this.subcategory)&&(identical(other.subcategoryLabel, _this.subcategoryLabel) || other.subcategoryLabel == _this.subcategoryLabel)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.incidentDate, _this.incidentDate) || other.incidentDate == _this.incidentDate)&&(identical(other.incidentTime, _this.incidentTime) || other.incidentTime == _this.incidentTime)&&(identical(other.details, _this.details) || other.details == _this.details)&&const DeepCollectionEquality().equals(other.attachments, _this.attachments)&&(identical(other.anonymous, _this.anonymous) || other.anonymous == _this.anonymous)&&(identical(other.reporter, _this.reporter) || other.reporter == _this.reporter)&&(identical(other.contactWhatsapp, _this.contactWhatsapp) || other.contactWhatsapp == _this.contactWhatsapp)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.priorityReason, _this.priorityReason) || other.priorityReason == _this.priorityReason)&&(identical(other.suggestedCategory, _this.suggestedCategory) || other.suggestedCategory == _this.suggestedCategory)&&(identical(other.possibleDuplicateOf, _this.possibleDuplicateOf) || other.possibleDuplicateOf == _this.possibleDuplicateOf)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.unitId, _this.unitId) || other.unitId == _this.unitId)&&(identical(other.unitName, _this.unitName) || other.unitName == _this.unitName)&&(identical(other.infoRequest, _this.infoRequest) || other.infoRequest == _this.infoRequest)&&(identical(other.resolution, _this.resolution) || other.resolution == _this.resolution)&&(identical(other.rejection, _this.rejection) || other.rejection == _this.rejection)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.sla, _this.sla) || other.sla == _this.sla)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.verifiedAt, _this.verifiedAt) || other.verifiedAt == _this.verifiedAt)&&(identical(other.resolvedAt, _this.resolvedAt) || other.resolvedAt == _this.resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Ticket;
  return Object.hashAll([runtimeType,_this.id,_this.number,_this.schoolId,_this.category,_this.categoryLabel,_this.subcategory,_this.subcategoryLabel,_this.title,_this.description,_this.location,_this.incidentDate,_this.incidentTime,_this.details,const DeepCollectionEquality().hash(_this.attachments),_this.anonymous,_this.reporter,_this.contactWhatsapp,_this.priority,_this.priorityReason,_this.suggestedCategory,_this.possibleDuplicateOf,_this.status,_this.unitId,_this.unitName,_this.infoRequest,_this.resolution,_this.rejection,_this.rating,_this.sla,_this.createdAt,_this.updatedAt,_this.verifiedAt,_this.resolvedAt]);
}

@override
String toString() {
  final _this = this as Ticket;
  return 'Ticket(id: ${_this.id}, number: ${_this.number}, schoolId: ${_this.schoolId}, category: ${_this.category}, categoryLabel: ${_this.categoryLabel}, subcategory: ${_this.subcategory}, subcategoryLabel: ${_this.subcategoryLabel}, title: ${_this.title}, description: ${_this.description}, location: ${_this.location}, incidentDate: ${_this.incidentDate}, incidentTime: ${_this.incidentTime}, details: ${_this.details}, attachments: ${_this.attachments}, anonymous: ${_this.anonymous}, reporter: ${_this.reporter}, contactWhatsapp: ${_this.contactWhatsapp}, priority: ${_this.priority}, priorityReason: ${_this.priorityReason}, suggestedCategory: ${_this.suggestedCategory}, possibleDuplicateOf: ${_this.possibleDuplicateOf}, status: ${_this.status}, unitId: ${_this.unitId}, unitName: ${_this.unitName}, infoRequest: ${_this.infoRequest}, resolution: ${_this.resolution}, rejection: ${_this.rejection}, rating: ${_this.rating}, sla: ${_this.sla}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, verifiedAt: ${_this.verifiedAt}, resolvedAt: ${_this.resolvedAt})';
}


}

/// @nodoc
abstract mixin class $TicketCopyWith<$Res>  {
  factory $TicketCopyWith(Ticket value, $Res Function(Ticket) _then) = _$TicketCopyWithImpl;
@useResult
$Res call({
 String id, String number, String schoolId, String category, String categoryLabel, String subcategory, String subcategoryLabel, String title, String description, String location, String? incidentDate, String? incidentTime, TicketDetails details, List<TicketAttachment> attachments, bool anonymous, TicketReporter? reporter, String? contactWhatsapp,@JsonKey(unknownEnumValue: TicketPriority.normal) TicketPriority priority, String? priorityReason, String? suggestedCategory, String? possibleDuplicateOf,@JsonKey(unknownEnumValue: TicketStatus.menungguVerifikasi) TicketStatus status, String? unitId, String? unitName, InfoRequest? infoRequest, TicketResolution? resolution, TicketRejection? rejection, TicketRating? rating, TicketSla sla,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt,@TimestampConverter() DateTime? verifiedAt,@TimestampConverter() DateTime? resolvedAt
});


$TicketDetailsCopyWith<$Res> get details;$TicketReporterCopyWith<$Res>? get reporter;$InfoRequestCopyWith<$Res>? get infoRequest;$TicketResolutionCopyWith<$Res>? get resolution;$TicketRejectionCopyWith<$Res>? get rejection;$TicketRatingCopyWith<$Res>? get rating;$TicketSlaCopyWith<$Res> get sla;

}
/// @nodoc
class _$TicketCopyWithImpl<$Res>
    implements $TicketCopyWith<$Res> {
  _$TicketCopyWithImpl(this._self, this._then);

  final Ticket _self;
  final $Res Function(Ticket) _then;

/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? number = null,Object? schoolId = null,Object? category = null,Object? categoryLabel = null,Object? subcategory = null,Object? subcategoryLabel = null,Object? title = null,Object? description = null,Object? location = null,Object? incidentDate = freezed,Object? incidentTime = freezed,Object? details = null,Object? attachments = null,Object? anonymous = null,Object? reporter = freezed,Object? contactWhatsapp = freezed,Object? priority = null,Object? priorityReason = freezed,Object? suggestedCategory = freezed,Object? possibleDuplicateOf = freezed,Object? status = null,Object? unitId = freezed,Object? unitName = freezed,Object? infoRequest = freezed,Object? resolution = freezed,Object? rejection = freezed,Object? rating = freezed,Object? sla = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? verifiedAt = freezed,Object? resolvedAt = freezed,}) {
  return _then(Ticket(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,schoolId: null == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,categoryLabel: null == categoryLabel ? _self.categoryLabel : categoryLabel // ignore: cast_nullable_to_non_nullable
as String,subcategory: null == subcategory ? _self.subcategory : subcategory // ignore: cast_nullable_to_non_nullable
as String,subcategoryLabel: null == subcategoryLabel ? _self.subcategoryLabel : subcategoryLabel // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,incidentDate: freezed == incidentDate ? _self.incidentDate : incidentDate // ignore: cast_nullable_to_non_nullable
as String?,incidentTime: freezed == incidentTime ? _self.incidentTime : incidentTime // ignore: cast_nullable_to_non_nullable
as String?,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as TicketDetails,attachments: null == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<TicketAttachment>,anonymous: null == anonymous ? _self.anonymous : anonymous // ignore: cast_nullable_to_non_nullable
as bool,reporter: freezed == reporter ? _self.reporter : reporter // ignore: cast_nullable_to_non_nullable
as TicketReporter?,contactWhatsapp: freezed == contactWhatsapp ? _self.contactWhatsapp : contactWhatsapp // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TicketPriority,priorityReason: freezed == priorityReason ? _self.priorityReason : priorityReason // ignore: cast_nullable_to_non_nullable
as String?,suggestedCategory: freezed == suggestedCategory ? _self.suggestedCategory : suggestedCategory // ignore: cast_nullable_to_non_nullable
as String?,possibleDuplicateOf: freezed == possibleDuplicateOf ? _self.possibleDuplicateOf : possibleDuplicateOf // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TicketStatus,unitId: freezed == unitId ? _self.unitId : unitId // ignore: cast_nullable_to_non_nullable
as String?,unitName: freezed == unitName ? _self.unitName : unitName // ignore: cast_nullable_to_non_nullable
as String?,infoRequest: freezed == infoRequest ? _self.infoRequest : infoRequest // ignore: cast_nullable_to_non_nullable
as InfoRequest?,resolution: freezed == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as TicketResolution?,rejection: freezed == rejection ? _self.rejection : rejection // ignore: cast_nullable_to_non_nullable
as TicketRejection?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as TicketRating?,sla: null == sla ? _self.sla : sla // ignore: cast_nullable_to_non_nullable
as TicketSla,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketDetailsCopyWith<$Res> get details {
  
  return $TicketDetailsCopyWith<$Res>(_self.details, (value) {
    return _then(_self.copyWith(details: value));
  });
}/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketReporterCopyWith<$Res>? get reporter {
    if (_self.reporter == null) {
    return null;
  }

  return $TicketReporterCopyWith<$Res>(_self.reporter!, (value) {
    return _then(_self.copyWith(reporter: value));
  });
}/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InfoRequestCopyWith<$Res>? get infoRequest {
    if (_self.infoRequest == null) {
    return null;
  }

  return $InfoRequestCopyWith<$Res>(_self.infoRequest!, (value) {
    return _then(_self.copyWith(infoRequest: value));
  });
}/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketResolutionCopyWith<$Res>? get resolution {
    if (_self.resolution == null) {
    return null;
  }

  return $TicketResolutionCopyWith<$Res>(_self.resolution!, (value) {
    return _then(_self.copyWith(resolution: value));
  });
}/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketRejectionCopyWith<$Res>? get rejection {
    if (_self.rejection == null) {
    return null;
  }

  return $TicketRejectionCopyWith<$Res>(_self.rejection!, (value) {
    return _then(_self.copyWith(rejection: value));
  });
}/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketRatingCopyWith<$Res>? get rating {
    if (_self.rating == null) {
    return null;
  }

  return $TicketRatingCopyWith<$Res>(_self.rating!, (value) {
    return _then(_self.copyWith(rating: value));
  });
}/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketSlaCopyWith<$Res> get sla {
  
  return $TicketSlaCopyWith<$Res>(_self.sla, (value) {
    return _then(_self.copyWith(sla: value));
  });
}
}


/// Adds pattern-matching-related methods to [Ticket].
extension TicketPatterns on Ticket {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Ticket value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Ticket() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Ticket value)  $default,){
final _that = this;
switch (_that) {
case _Ticket():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Ticket value)?  $default,){
final _that = this;
switch (_that) {
case _Ticket() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String number,  String schoolId,  String category,  String categoryLabel,  String subcategory,  String subcategoryLabel,  String title,  String description,  String location,  String? incidentDate,  String? incidentTime,  TicketDetails details,  List<TicketAttachment> attachments,  bool anonymous,  TicketReporter? reporter,  String? contactWhatsapp, @JsonKey(unknownEnumValue: TicketPriority.normal)  TicketPriority priority,  String? priorityReason,  String? suggestedCategory,  String? possibleDuplicateOf, @JsonKey(unknownEnumValue: TicketStatus.menungguVerifikasi)  TicketStatus status,  String? unitId,  String? unitName,  InfoRequest? infoRequest,  TicketResolution? resolution,  TicketRejection? rejection,  TicketRating? rating,  TicketSla sla, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt, @TimestampConverter()  DateTime? verifiedAt, @TimestampConverter()  DateTime? resolvedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Ticket() when $default != null:
return $default(_that.id,_that.number,_that.schoolId,_that.category,_that.categoryLabel,_that.subcategory,_that.subcategoryLabel,_that.title,_that.description,_that.location,_that.incidentDate,_that.incidentTime,_that.details,_that.attachments,_that.anonymous,_that.reporter,_that.contactWhatsapp,_that.priority,_that.priorityReason,_that.suggestedCategory,_that.possibleDuplicateOf,_that.status,_that.unitId,_that.unitName,_that.infoRequest,_that.resolution,_that.rejection,_that.rating,_that.sla,_that.createdAt,_that.updatedAt,_that.verifiedAt,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String number,  String schoolId,  String category,  String categoryLabel,  String subcategory,  String subcategoryLabel,  String title,  String description,  String location,  String? incidentDate,  String? incidentTime,  TicketDetails details,  List<TicketAttachment> attachments,  bool anonymous,  TicketReporter? reporter,  String? contactWhatsapp, @JsonKey(unknownEnumValue: TicketPriority.normal)  TicketPriority priority,  String? priorityReason,  String? suggestedCategory,  String? possibleDuplicateOf, @JsonKey(unknownEnumValue: TicketStatus.menungguVerifikasi)  TicketStatus status,  String? unitId,  String? unitName,  InfoRequest? infoRequest,  TicketResolution? resolution,  TicketRejection? rejection,  TicketRating? rating,  TicketSla sla, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt, @TimestampConverter()  DateTime? verifiedAt, @TimestampConverter()  DateTime? resolvedAt)  $default,) {final _that = this;
switch (_that) {
case _Ticket():
return $default(_that.id,_that.number,_that.schoolId,_that.category,_that.categoryLabel,_that.subcategory,_that.subcategoryLabel,_that.title,_that.description,_that.location,_that.incidentDate,_that.incidentTime,_that.details,_that.attachments,_that.anonymous,_that.reporter,_that.contactWhatsapp,_that.priority,_that.priorityReason,_that.suggestedCategory,_that.possibleDuplicateOf,_that.status,_that.unitId,_that.unitName,_that.infoRequest,_that.resolution,_that.rejection,_that.rating,_that.sla,_that.createdAt,_that.updatedAt,_that.verifiedAt,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String number,  String schoolId,  String category,  String categoryLabel,  String subcategory,  String subcategoryLabel,  String title,  String description,  String location,  String? incidentDate,  String? incidentTime,  TicketDetails details,  List<TicketAttachment> attachments,  bool anonymous,  TicketReporter? reporter,  String? contactWhatsapp, @JsonKey(unknownEnumValue: TicketPriority.normal)  TicketPriority priority,  String? priorityReason,  String? suggestedCategory,  String? possibleDuplicateOf, @JsonKey(unknownEnumValue: TicketStatus.menungguVerifikasi)  TicketStatus status,  String? unitId,  String? unitName,  InfoRequest? infoRequest,  TicketResolution? resolution,  TicketRejection? rejection,  TicketRating? rating,  TicketSla sla, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt, @TimestampConverter()  DateTime? verifiedAt, @TimestampConverter()  DateTime? resolvedAt)?  $default,) {final _that = this;
switch (_that) {
case _Ticket() when $default != null:
return $default(_that.id,_that.number,_that.schoolId,_that.category,_that.categoryLabel,_that.subcategory,_that.subcategoryLabel,_that.title,_that.description,_that.location,_that.incidentDate,_that.incidentTime,_that.details,_that.attachments,_that.anonymous,_that.reporter,_that.contactWhatsapp,_that.priority,_that.priorityReason,_that.suggestedCategory,_that.possibleDuplicateOf,_that.status,_that.unitId,_that.unitName,_that.infoRequest,_that.resolution,_that.rejection,_that.rating,_that.sla,_that.createdAt,_that.updatedAt,_that.verifiedAt,_that.resolvedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Ticket extends Ticket {
  const _Ticket({required this.id, this.number = '', this.schoolId = '', this.category = 'lainnya', this.categoryLabel = '', this.subcategory = 'lainnya', this.subcategoryLabel = '', this.title = '', this.description = '', this.location = '', this.incidentDate, this.incidentTime, this.details = const TicketDetails(),  List<TicketAttachment> attachments = const <TicketAttachment>[], this.anonymous = false, this.reporter, this.contactWhatsapp, @JsonKey(unknownEnumValue: TicketPriority.normal) this.priority = TicketPriority.normal, this.priorityReason, this.suggestedCategory, this.possibleDuplicateOf, @JsonKey(unknownEnumValue: TicketStatus.menungguVerifikasi) this.status = TicketStatus.menungguVerifikasi, this.unitId, this.unitName, this.infoRequest, this.resolution, this.rejection, this.rating, this.sla = const TicketSla(), @TimestampConverter() this.createdAt, @TimestampConverter() this.updatedAt, @TimestampConverter() this.verifiedAt, @TimestampConverter() this.resolvedAt}): _attachments = attachments,super._();
  factory _Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

@override final  String id;
@override@JsonKey() final  String number;
@override@JsonKey() final  String schoolId;
@override@JsonKey() final  String category;
@override@JsonKey() final  String categoryLabel;
@override@JsonKey() final  String subcategory;
@override@JsonKey() final  String subcategoryLabel;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  String location;
@override final  String? incidentDate;
@override final  String? incidentTime;
@override@JsonKey() final  TicketDetails details;
 final  List<TicketAttachment> _attachments;
@override@JsonKey() List<TicketAttachment> get attachments {
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachments);
}

@override@JsonKey() final  bool anonymous;
@override final  TicketReporter? reporter;
@override final  String? contactWhatsapp;
@override@JsonKey(unknownEnumValue: TicketPriority.normal) final  TicketPriority priority;
@override final  String? priorityReason;
@override final  String? suggestedCategory;
@override final  String? possibleDuplicateOf;
@override@JsonKey(unknownEnumValue: TicketStatus.menungguVerifikasi) final  TicketStatus status;
@override final  String? unitId;
@override final  String? unitName;
@override final  InfoRequest? infoRequest;
@override final  TicketResolution? resolution;
@override final  TicketRejection? rejection;
@override final  TicketRating? rating;
@override@JsonKey() final  TicketSla sla;
@override@TimestampConverter() final  DateTime? createdAt;
@override@TimestampConverter() final  DateTime? updatedAt;
@override@TimestampConverter() final  DateTime? verifiedAt;
@override@TimestampConverter() final  DateTime? resolvedAt;

/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketCopyWith<_Ticket> get copyWith => __$TicketCopyWithImpl<_Ticket>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ticket&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.schoolId, schoolId) || other.schoolId == schoolId)&&(identical(other.category, category) || other.category == category)&&(identical(other.categoryLabel, categoryLabel) || other.categoryLabel == categoryLabel)&&(identical(other.subcategory, subcategory) || other.subcategory == subcategory)&&(identical(other.subcategoryLabel, subcategoryLabel) || other.subcategoryLabel == subcategoryLabel)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.incidentDate, incidentDate) || other.incidentDate == incidentDate)&&(identical(other.incidentTime, incidentTime) || other.incidentTime == incidentTime)&&(identical(other.details, details) || other.details == details)&&const DeepCollectionEquality().equals(other.attachments, _attachments)&&(identical(other.anonymous, anonymous) || other.anonymous == anonymous)&&(identical(other.reporter, reporter) || other.reporter == reporter)&&(identical(other.contactWhatsapp, contactWhatsapp) || other.contactWhatsapp == contactWhatsapp)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.priorityReason, priorityReason) || other.priorityReason == priorityReason)&&(identical(other.suggestedCategory, suggestedCategory) || other.suggestedCategory == suggestedCategory)&&(identical(other.possibleDuplicateOf, possibleDuplicateOf) || other.possibleDuplicateOf == possibleDuplicateOf)&&(identical(other.status, status) || other.status == status)&&(identical(other.unitId, unitId) || other.unitId == unitId)&&(identical(other.unitName, unitName) || other.unitName == unitName)&&(identical(other.infoRequest, infoRequest) || other.infoRequest == infoRequest)&&(identical(other.resolution, resolution) || other.resolution == resolution)&&(identical(other.rejection, rejection) || other.rejection == rejection)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.sla, sla) || other.sla == sla)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,number,schoolId,category,categoryLabel,subcategory,subcategoryLabel,title,description,location,incidentDate,incidentTime,details,const DeepCollectionEquality().hash(_attachments),anonymous,reporter,contactWhatsapp,priority,priorityReason,suggestedCategory,possibleDuplicateOf,status,unitId,unitName,infoRequest,resolution,rejection,rating,sla,createdAt,updatedAt,verifiedAt,resolvedAt]);
}

@override
String toString() {
    return 'Ticket(id: $id, number: $number, schoolId: $schoolId, category: $category, categoryLabel: $categoryLabel, subcategory: $subcategory, subcategoryLabel: $subcategoryLabel, title: $title, description: $description, location: $location, incidentDate: $incidentDate, incidentTime: $incidentTime, details: $details, attachments: $attachments, anonymous: $anonymous, reporter: $reporter, contactWhatsapp: $contactWhatsapp, priority: $priority, priorityReason: $priorityReason, suggestedCategory: $suggestedCategory, possibleDuplicateOf: $possibleDuplicateOf, status: $status, unitId: $unitId, unitName: $unitName, infoRequest: $infoRequest, resolution: $resolution, rejection: $rejection, rating: $rating, sla: $sla, createdAt: $createdAt, updatedAt: $updatedAt, verifiedAt: $verifiedAt, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class _$TicketCopyWith<$Res> implements $TicketCopyWith<$Res> {
  factory _$TicketCopyWith(_Ticket value, $Res Function(_Ticket) _then) = __$TicketCopyWithImpl;
@override @useResult
$Res call({
 String id, String number, String schoolId, String category, String categoryLabel, String subcategory, String subcategoryLabel, String title, String description, String location, String? incidentDate, String? incidentTime, TicketDetails details, List<TicketAttachment> attachments, bool anonymous, TicketReporter? reporter, String? contactWhatsapp,@JsonKey(unknownEnumValue: TicketPriority.normal) TicketPriority priority, String? priorityReason, String? suggestedCategory, String? possibleDuplicateOf,@JsonKey(unknownEnumValue: TicketStatus.menungguVerifikasi) TicketStatus status, String? unitId, String? unitName, InfoRequest? infoRequest, TicketResolution? resolution, TicketRejection? rejection, TicketRating? rating, TicketSla sla,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt,@TimestampConverter() DateTime? verifiedAt,@TimestampConverter() DateTime? resolvedAt
});


@override $TicketDetailsCopyWith<$Res> get details;@override $TicketReporterCopyWith<$Res>? get reporter;@override $InfoRequestCopyWith<$Res>? get infoRequest;@override $TicketResolutionCopyWith<$Res>? get resolution;@override $TicketRejectionCopyWith<$Res>? get rejection;@override $TicketRatingCopyWith<$Res>? get rating;@override $TicketSlaCopyWith<$Res> get sla;

}
/// @nodoc
class __$TicketCopyWithImpl<$Res>
    implements _$TicketCopyWith<$Res> {
  __$TicketCopyWithImpl(this._self, this._then);

  final _Ticket _self;
  final $Res Function(_Ticket) _then;

/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? number = null,Object? schoolId = null,Object? category = null,Object? categoryLabel = null,Object? subcategory = null,Object? subcategoryLabel = null,Object? title = null,Object? description = null,Object? location = null,Object? incidentDate = freezed,Object? incidentTime = freezed,Object? details = null,Object? attachments = null,Object? anonymous = null,Object? reporter = freezed,Object? contactWhatsapp = freezed,Object? priority = null,Object? priorityReason = freezed,Object? suggestedCategory = freezed,Object? possibleDuplicateOf = freezed,Object? status = null,Object? unitId = freezed,Object? unitName = freezed,Object? infoRequest = freezed,Object? resolution = freezed,Object? rejection = freezed,Object? rating = freezed,Object? sla = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? verifiedAt = freezed,Object? resolvedAt = freezed,}) {
  return _then(_Ticket(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,schoolId: null == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,categoryLabel: null == categoryLabel ? _self.categoryLabel : categoryLabel // ignore: cast_nullable_to_non_nullable
as String,subcategory: null == subcategory ? _self.subcategory : subcategory // ignore: cast_nullable_to_non_nullable
as String,subcategoryLabel: null == subcategoryLabel ? _self.subcategoryLabel : subcategoryLabel // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,incidentDate: freezed == incidentDate ? _self.incidentDate : incidentDate // ignore: cast_nullable_to_non_nullable
as String?,incidentTime: freezed == incidentTime ? _self.incidentTime : incidentTime // ignore: cast_nullable_to_non_nullable
as String?,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as TicketDetails,attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<TicketAttachment>,anonymous: null == anonymous ? _self.anonymous : anonymous // ignore: cast_nullable_to_non_nullable
as bool,reporter: freezed == reporter ? _self.reporter : reporter // ignore: cast_nullable_to_non_nullable
as TicketReporter?,contactWhatsapp: freezed == contactWhatsapp ? _self.contactWhatsapp : contactWhatsapp // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TicketPriority,priorityReason: freezed == priorityReason ? _self.priorityReason : priorityReason // ignore: cast_nullable_to_non_nullable
as String?,suggestedCategory: freezed == suggestedCategory ? _self.suggestedCategory : suggestedCategory // ignore: cast_nullable_to_non_nullable
as String?,possibleDuplicateOf: freezed == possibleDuplicateOf ? _self.possibleDuplicateOf : possibleDuplicateOf // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TicketStatus,unitId: freezed == unitId ? _self.unitId : unitId // ignore: cast_nullable_to_non_nullable
as String?,unitName: freezed == unitName ? _self.unitName : unitName // ignore: cast_nullable_to_non_nullable
as String?,infoRequest: freezed == infoRequest ? _self.infoRequest : infoRequest // ignore: cast_nullable_to_non_nullable
as InfoRequest?,resolution: freezed == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as TicketResolution?,rejection: freezed == rejection ? _self.rejection : rejection // ignore: cast_nullable_to_non_nullable
as TicketRejection?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as TicketRating?,sla: null == sla ? _self.sla : sla // ignore: cast_nullable_to_non_nullable
as TicketSla,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketDetailsCopyWith<$Res> get details {
  
  return $TicketDetailsCopyWith<$Res>(_self.details, (value) {
    return _then(_self.copyWith(details: value));
  });
}/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketReporterCopyWith<$Res>? get reporter {
    if (_self.reporter == null) {
    return null;
  }

  return $TicketReporterCopyWith<$Res>(_self.reporter!, (value) {
    return _then(_self.copyWith(reporter: value));
  });
}/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InfoRequestCopyWith<$Res>? get infoRequest {
    if (_self.infoRequest == null) {
    return null;
  }

  return $InfoRequestCopyWith<$Res>(_self.infoRequest!, (value) {
    return _then(_self.copyWith(infoRequest: value));
  });
}/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketResolutionCopyWith<$Res>? get resolution {
    if (_self.resolution == null) {
    return null;
  }

  return $TicketResolutionCopyWith<$Res>(_self.resolution!, (value) {
    return _then(_self.copyWith(resolution: value));
  });
}/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketRejectionCopyWith<$Res>? get rejection {
    if (_self.rejection == null) {
    return null;
  }

  return $TicketRejectionCopyWith<$Res>(_self.rejection!, (value) {
    return _then(_self.copyWith(rejection: value));
  });
}/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketRatingCopyWith<$Res>? get rating {
    if (_self.rating == null) {
    return null;
  }

  return $TicketRatingCopyWith<$Res>(_self.rating!, (value) {
    return _then(_self.copyWith(rating: value));
  });
}/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketSlaCopyWith<$Res> get sla {
  
  return $TicketSlaCopyWith<$Res>(_self.sla, (value) {
    return _then(_self.copyWith(sla: value));
  });
}
}


/// @nodoc
mixin _$TimelineEvent {

 String get id;@JsonKey(unknownEnumValue: TimelineType.progres) TimelineType get type;@JsonKey(unknownEnumValue: TimelineVisibility.internal) TimelineVisibility get visibility; String? get message; String get actorRole; String? get actorName; List<TicketAttachment> get attachments;@TimestampConverter() DateTime? get createdAt;
/// Create a copy of TimelineEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineEventCopyWith<TimelineEvent> get copyWith => _$TimelineEventCopyWithImpl<TimelineEvent>(this as TimelineEvent, _$identity);

  /// Serializes this TimelineEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TimelineEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineEvent&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.visibility, _this.visibility) || other.visibility == _this.visibility)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.actorRole, _this.actorRole) || other.actorRole == _this.actorRole)&&(identical(other.actorName, _this.actorName) || other.actorName == _this.actorName)&&const DeepCollectionEquality().equals(other.attachments, _this.attachments)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TimelineEvent;
  return Object.hash(runtimeType,_this.id,_this.type,_this.visibility,_this.message,_this.actorRole,_this.actorName,const DeepCollectionEquality().hash(_this.attachments),_this.createdAt);
}

@override
String toString() {
  final _this = this as TimelineEvent;
  return 'TimelineEvent(id: ${_this.id}, type: ${_this.type}, visibility: ${_this.visibility}, message: ${_this.message}, actorRole: ${_this.actorRole}, actorName: ${_this.actorName}, attachments: ${_this.attachments}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $TimelineEventCopyWith<$Res>  {
  factory $TimelineEventCopyWith(TimelineEvent value, $Res Function(TimelineEvent) _then) = _$TimelineEventCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(unknownEnumValue: TimelineType.progres) TimelineType type,@JsonKey(unknownEnumValue: TimelineVisibility.internal) TimelineVisibility visibility, String? message, String actorRole, String? actorName, List<TicketAttachment> attachments,@TimestampConverter() DateTime? createdAt
});




}
/// @nodoc
class _$TimelineEventCopyWithImpl<$Res>
    implements $TimelineEventCopyWith<$Res> {
  _$TimelineEventCopyWithImpl(this._self, this._then);

  final TimelineEvent _self;
  final $Res Function(TimelineEvent) _then;

/// Create a copy of TimelineEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? visibility = null,Object? message = freezed,Object? actorRole = null,Object? actorName = freezed,Object? attachments = null,Object? createdAt = freezed,}) {
  return _then(TimelineEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TimelineType,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as TimelineVisibility,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,actorRole: null == actorRole ? _self.actorRole : actorRole // ignore: cast_nullable_to_non_nullable
as String,actorName: freezed == actorName ? _self.actorName : actorName // ignore: cast_nullable_to_non_nullable
as String?,attachments: null == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<TicketAttachment>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TimelineEvent].
extension TimelineEventPatterns on TimelineEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimelineEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimelineEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimelineEvent value)  $default,){
final _that = this;
switch (_that) {
case _TimelineEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimelineEvent value)?  $default,){
final _that = this;
switch (_that) {
case _TimelineEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(unknownEnumValue: TimelineType.progres)  TimelineType type, @JsonKey(unknownEnumValue: TimelineVisibility.internal)  TimelineVisibility visibility,  String? message,  String actorRole,  String? actorName,  List<TicketAttachment> attachments, @TimestampConverter()  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimelineEvent() when $default != null:
return $default(_that.id,_that.type,_that.visibility,_that.message,_that.actorRole,_that.actorName,_that.attachments,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(unknownEnumValue: TimelineType.progres)  TimelineType type, @JsonKey(unknownEnumValue: TimelineVisibility.internal)  TimelineVisibility visibility,  String? message,  String actorRole,  String? actorName,  List<TicketAttachment> attachments, @TimestampConverter()  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _TimelineEvent():
return $default(_that.id,_that.type,_that.visibility,_that.message,_that.actorRole,_that.actorName,_that.attachments,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(unknownEnumValue: TimelineType.progres)  TimelineType type, @JsonKey(unknownEnumValue: TimelineVisibility.internal)  TimelineVisibility visibility,  String? message,  String actorRole,  String? actorName,  List<TicketAttachment> attachments, @TimestampConverter()  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TimelineEvent() when $default != null:
return $default(_that.id,_that.type,_that.visibility,_that.message,_that.actorRole,_that.actorName,_that.attachments,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TimelineEvent implements TimelineEvent {
  const _TimelineEvent({required this.id, @JsonKey(unknownEnumValue: TimelineType.progres) this.type = TimelineType.progres, @JsonKey(unknownEnumValue: TimelineVisibility.internal) this.visibility = TimelineVisibility.public, this.message, this.actorRole = 'sistem', this.actorName,  List<TicketAttachment> attachments = const <TicketAttachment>[], @TimestampConverter() this.createdAt}): _attachments = attachments;
  factory _TimelineEvent.fromJson(Map<String, dynamic> json) => _$TimelineEventFromJson(json);

@override final  String id;
@override@JsonKey(unknownEnumValue: TimelineType.progres) final  TimelineType type;
@override@JsonKey(unknownEnumValue: TimelineVisibility.internal) final  TimelineVisibility visibility;
@override final  String? message;
@override@JsonKey() final  String actorRole;
@override final  String? actorName;
 final  List<TicketAttachment> _attachments;
@override@JsonKey() List<TicketAttachment> get attachments {
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachments);
}

@override@TimestampConverter() final  DateTime? createdAt;

/// Create a copy of TimelineEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimelineEventCopyWith<_TimelineEvent> get copyWith => __$TimelineEventCopyWithImpl<_TimelineEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimelineEventToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimelineEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.message, message) || other.message == message)&&(identical(other.actorRole, actorRole) || other.actorRole == actorRole)&&(identical(other.actorName, actorName) || other.actorName == actorName)&&const DeepCollectionEquality().equals(other.attachments, _attachments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,type,visibility,message,actorRole,actorName,const DeepCollectionEquality().hash(_attachments),createdAt);
}

@override
String toString() {
    return 'TimelineEvent(id: $id, type: $type, visibility: $visibility, message: $message, actorRole: $actorRole, actorName: $actorName, attachments: $attachments, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TimelineEventCopyWith<$Res> implements $TimelineEventCopyWith<$Res> {
  factory _$TimelineEventCopyWith(_TimelineEvent value, $Res Function(_TimelineEvent) _then) = __$TimelineEventCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(unknownEnumValue: TimelineType.progres) TimelineType type,@JsonKey(unknownEnumValue: TimelineVisibility.internal) TimelineVisibility visibility, String? message, String actorRole, String? actorName, List<TicketAttachment> attachments,@TimestampConverter() DateTime? createdAt
});




}
/// @nodoc
class __$TimelineEventCopyWithImpl<$Res>
    implements _$TimelineEventCopyWith<$Res> {
  __$TimelineEventCopyWithImpl(this._self, this._then);

  final _TimelineEvent _self;
  final $Res Function(_TimelineEvent) _then;

/// Create a copy of TimelineEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? visibility = null,Object? message = freezed,Object? actorRole = null,Object? actorName = freezed,Object? attachments = null,Object? createdAt = freezed,}) {
  return _then(_TimelineEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TimelineType,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as TimelineVisibility,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,actorRole: null == actorRole ? _self.actorRole : actorRole // ignore: cast_nullable_to_non_nullable
as String,actorName: freezed == actorName ? _self.actorName : actorName // ignore: cast_nullable_to_non_nullable
as String?,attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<TicketAttachment>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$TicketOwner {

 String get id; String get uid; bool get anonymous;@TimestampConverter() DateTime? get createdAt;
/// Create a copy of TicketOwner
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketOwnerCopyWith<TicketOwner> get copyWith => _$TicketOwnerCopyWithImpl<TicketOwner>(this as TicketOwner, _$identity);

  /// Serializes this TicketOwner to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketOwner;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketOwner&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.uid, _this.uid) || other.uid == _this.uid)&&(identical(other.anonymous, _this.anonymous) || other.anonymous == _this.anonymous)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketOwner;
  return Object.hash(runtimeType,_this.id,_this.uid,_this.anonymous,_this.createdAt);
}

@override
String toString() {
  final _this = this as TicketOwner;
  return 'TicketOwner(id: ${_this.id}, uid: ${_this.uid}, anonymous: ${_this.anonymous}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $TicketOwnerCopyWith<$Res>  {
  factory $TicketOwnerCopyWith(TicketOwner value, $Res Function(TicketOwner) _then) = _$TicketOwnerCopyWithImpl;
@useResult
$Res call({
 String id, String uid, bool anonymous,@TimestampConverter() DateTime? createdAt
});




}
/// @nodoc
class _$TicketOwnerCopyWithImpl<$Res>
    implements $TicketOwnerCopyWith<$Res> {
  _$TicketOwnerCopyWithImpl(this._self, this._then);

  final TicketOwner _self;
  final $Res Function(TicketOwner) _then;

/// Create a copy of TicketOwner
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? uid = null,Object? anonymous = null,Object? createdAt = freezed,}) {
  return _then(TicketOwner(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,anonymous: null == anonymous ? _self.anonymous : anonymous // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketOwner].
extension TicketOwnerPatterns on TicketOwner {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketOwner value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketOwner() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketOwner value)  $default,){
final _that = this;
switch (_that) {
case _TicketOwner():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketOwner value)?  $default,){
final _that = this;
switch (_that) {
case _TicketOwner() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String uid,  bool anonymous, @TimestampConverter()  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketOwner() when $default != null:
return $default(_that.id,_that.uid,_that.anonymous,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String uid,  bool anonymous, @TimestampConverter()  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _TicketOwner():
return $default(_that.id,_that.uid,_that.anonymous,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String uid,  bool anonymous, @TimestampConverter()  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TicketOwner() when $default != null:
return $default(_that.id,_that.uid,_that.anonymous,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketOwner implements TicketOwner {
  const _TicketOwner({required this.id, required this.uid, this.anonymous = false, @TimestampConverter() this.createdAt});
  factory _TicketOwner.fromJson(Map<String, dynamic> json) => _$TicketOwnerFromJson(json);

@override final  String id;
@override final  String uid;
@override@JsonKey() final  bool anonymous;
@override@TimestampConverter() final  DateTime? createdAt;

/// Create a copy of TicketOwner
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketOwnerCopyWith<_TicketOwner> get copyWith => __$TicketOwnerCopyWithImpl<_TicketOwner>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketOwnerToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketOwner&&(identical(other.id, id) || other.id == id)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.anonymous, anonymous) || other.anonymous == anonymous)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,uid,anonymous,createdAt);
}

@override
String toString() {
    return 'TicketOwner(id: $id, uid: $uid, anonymous: $anonymous, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TicketOwnerCopyWith<$Res> implements $TicketOwnerCopyWith<$Res> {
  factory _$TicketOwnerCopyWith(_TicketOwner value, $Res Function(_TicketOwner) _then) = __$TicketOwnerCopyWithImpl;
@override @useResult
$Res call({
 String id, String uid, bool anonymous,@TimestampConverter() DateTime? createdAt
});




}
/// @nodoc
class __$TicketOwnerCopyWithImpl<$Res>
    implements _$TicketOwnerCopyWith<$Res> {
  __$TicketOwnerCopyWithImpl(this._self, this._then);

  final _TicketOwner _self;
  final $Res Function(_TicketOwner) _then;

/// Create a copy of TicketOwner
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? uid = null,Object? anonymous = null,Object? createdAt = freezed,}) {
  return _then(_TicketOwner(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,anonymous: null == anonymous ? _self.anonymous : anonymous // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
