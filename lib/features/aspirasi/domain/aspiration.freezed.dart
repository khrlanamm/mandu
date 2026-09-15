// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'aspiration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AspirationResponse {

 String get message; String get respondedByName;@TimestampConverter() DateTime? get respondedAt;
/// Create a copy of AspirationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AspirationResponseCopyWith<AspirationResponse> get copyWith => _$AspirationResponseCopyWithImpl<AspirationResponse>(this as AspirationResponse, _$identity);

  /// Serializes this AspirationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AspirationResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AspirationResponse&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.respondedByName, _this.respondedByName) || other.respondedByName == _this.respondedByName)&&(identical(other.respondedAt, _this.respondedAt) || other.respondedAt == _this.respondedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AspirationResponse;
  return Object.hash(runtimeType,_this.message,_this.respondedByName,_this.respondedAt);
}

@override
String toString() {
  final _this = this as AspirationResponse;
  return 'AspirationResponse(message: ${_this.message}, respondedByName: ${_this.respondedByName}, respondedAt: ${_this.respondedAt})';
}


}

/// @nodoc
abstract mixin class $AspirationResponseCopyWith<$Res>  {
  factory $AspirationResponseCopyWith(AspirationResponse value, $Res Function(AspirationResponse) _then) = _$AspirationResponseCopyWithImpl;
@useResult
$Res call({
 String message, String respondedByName,@TimestampConverter() DateTime? respondedAt
});




}
/// @nodoc
class _$AspirationResponseCopyWithImpl<$Res>
    implements $AspirationResponseCopyWith<$Res> {
  _$AspirationResponseCopyWithImpl(this._self, this._then);

  final AspirationResponse _self;
  final $Res Function(AspirationResponse) _then;

/// Create a copy of AspirationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? respondedByName = null,Object? respondedAt = freezed,}) {
  return _then(AspirationResponse(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,respondedByName: null == respondedByName ? _self.respondedByName : respondedByName // ignore: cast_nullable_to_non_nullable
as String,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AspirationResponse].
extension AspirationResponsePatterns on AspirationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AspirationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AspirationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AspirationResponse value)  $default,){
final _that = this;
switch (_that) {
case _AspirationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AspirationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AspirationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  String respondedByName, @TimestampConverter()  DateTime? respondedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AspirationResponse() when $default != null:
return $default(_that.message,_that.respondedByName,_that.respondedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  String respondedByName, @TimestampConverter()  DateTime? respondedAt)  $default,) {final _that = this;
switch (_that) {
case _AspirationResponse():
return $default(_that.message,_that.respondedByName,_that.respondedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  String respondedByName, @TimestampConverter()  DateTime? respondedAt)?  $default,) {final _that = this;
switch (_that) {
case _AspirationResponse() when $default != null:
return $default(_that.message,_that.respondedByName,_that.respondedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AspirationResponse implements AspirationResponse {
  const _AspirationResponse({required this.message, this.respondedByName = '', @TimestampConverter() this.respondedAt});
  factory _AspirationResponse.fromJson(Map<String, dynamic> json) => _$AspirationResponseFromJson(json);

@override final  String message;
@override@JsonKey() final  String respondedByName;
@override@TimestampConverter() final  DateTime? respondedAt;

/// Create a copy of AspirationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AspirationResponseCopyWith<_AspirationResponse> get copyWith => __$AspirationResponseCopyWithImpl<_AspirationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AspirationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AspirationResponse&&(identical(other.message, message) || other.message == message)&&(identical(other.respondedByName, respondedByName) || other.respondedByName == respondedByName)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,message,respondedByName,respondedAt);
}

@override
String toString() {
    return 'AspirationResponse(message: $message, respondedByName: $respondedByName, respondedAt: $respondedAt)';
}


}

/// @nodoc
abstract mixin class _$AspirationResponseCopyWith<$Res> implements $AspirationResponseCopyWith<$Res> {
  factory _$AspirationResponseCopyWith(_AspirationResponse value, $Res Function(_AspirationResponse) _then) = __$AspirationResponseCopyWithImpl;
@override @useResult
$Res call({
 String message, String respondedByName,@TimestampConverter() DateTime? respondedAt
});




}
/// @nodoc
class __$AspirationResponseCopyWithImpl<$Res>
    implements _$AspirationResponseCopyWith<$Res> {
  __$AspirationResponseCopyWithImpl(this._self, this._then);

  final _AspirationResponse _self;
  final $Res Function(_AspirationResponse) _then;

/// Create a copy of AspirationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? respondedByName = null,Object? respondedAt = freezed,}) {
  return _then(_AspirationResponse(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,respondedByName: null == respondedByName ? _self.respondedByName : respondedByName // ignore: cast_nullable_to_non_nullable
as String,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$Aspiration {

 String get id; String get number; String get schoolId;@JsonKey(unknownEnumValue: AspirationType.saran) AspirationType get type; String get topic; String get topicLabel; String get title; String get content; String get source; bool get anonymous; bool get flagged;@JsonKey(unknownEnumValue: AspirationStatus.diterima) AspirationStatus get status; AspirationResponse? get response;@JsonKey(unknownEnumValue: BoardState.none) BoardState get board;@TimestampConverter() DateTime? get publishedAt; int get supportCount;@TimestampConverter() DateTime? get createdAt;@TimestampConverter() DateTime? get updatedAt;
/// Create a copy of Aspiration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AspirationCopyWith<Aspiration> get copyWith => _$AspirationCopyWithImpl<Aspiration>(this as Aspiration, _$identity);

  /// Serializes this Aspiration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Aspiration;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Aspiration&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.schoolId, _this.schoolId) || other.schoolId == _this.schoolId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.topic, _this.topic) || other.topic == _this.topic)&&(identical(other.topicLabel, _this.topicLabel) || other.topicLabel == _this.topicLabel)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.content, _this.content) || other.content == _this.content)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.anonymous, _this.anonymous) || other.anonymous == _this.anonymous)&&(identical(other.flagged, _this.flagged) || other.flagged == _this.flagged)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.response, _this.response) || other.response == _this.response)&&(identical(other.board, _this.board) || other.board == _this.board)&&(identical(other.publishedAt, _this.publishedAt) || other.publishedAt == _this.publishedAt)&&(identical(other.supportCount, _this.supportCount) || other.supportCount == _this.supportCount)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Aspiration;
  return Object.hash(runtimeType,_this.id,_this.number,_this.schoolId,_this.type,_this.topic,_this.topicLabel,_this.title,_this.content,_this.source,_this.anonymous,_this.flagged,_this.status,_this.response,_this.board,_this.publishedAt,_this.supportCount,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as Aspiration;
  return 'Aspiration(id: ${_this.id}, number: ${_this.number}, schoolId: ${_this.schoolId}, type: ${_this.type}, topic: ${_this.topic}, topicLabel: ${_this.topicLabel}, title: ${_this.title}, content: ${_this.content}, source: ${_this.source}, anonymous: ${_this.anonymous}, flagged: ${_this.flagged}, status: ${_this.status}, response: ${_this.response}, board: ${_this.board}, publishedAt: ${_this.publishedAt}, supportCount: ${_this.supportCount}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $AspirationCopyWith<$Res>  {
  factory $AspirationCopyWith(Aspiration value, $Res Function(Aspiration) _then) = _$AspirationCopyWithImpl;
@useResult
$Res call({
 String id, String number, String schoolId,@JsonKey(unknownEnumValue: AspirationType.saran) AspirationType type, String topic, String topicLabel, String title, String content, String source, bool anonymous, bool flagged,@JsonKey(unknownEnumValue: AspirationStatus.diterima) AspirationStatus status, AspirationResponse? response,@JsonKey(unknownEnumValue: BoardState.none) BoardState board,@TimestampConverter() DateTime? publishedAt, int supportCount,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt
});


$AspirationResponseCopyWith<$Res>? get response;

}
/// @nodoc
class _$AspirationCopyWithImpl<$Res>
    implements $AspirationCopyWith<$Res> {
  _$AspirationCopyWithImpl(this._self, this._then);

  final Aspiration _self;
  final $Res Function(Aspiration) _then;

/// Create a copy of Aspiration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? number = null,Object? schoolId = null,Object? type = null,Object? topic = null,Object? topicLabel = null,Object? title = null,Object? content = null,Object? source = null,Object? anonymous = null,Object? flagged = null,Object? status = null,Object? response = freezed,Object? board = null,Object? publishedAt = freezed,Object? supportCount = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(Aspiration(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,schoolId: null == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AspirationType,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,topicLabel: null == topicLabel ? _self.topicLabel : topicLabel // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,anonymous: null == anonymous ? _self.anonymous : anonymous // ignore: cast_nullable_to_non_nullable
as bool,flagged: null == flagged ? _self.flagged : flagged // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AspirationStatus,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as AspirationResponse?,board: null == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as BoardState,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,supportCount: null == supportCount ? _self.supportCount : supportCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of Aspiration
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AspirationResponseCopyWith<$Res>? get response {
    if (_self.response == null) {
    return null;
  }

  return $AspirationResponseCopyWith<$Res>(_self.response!, (value) {
    return _then(_self.copyWith(response: value));
  });
}
}


/// Adds pattern-matching-related methods to [Aspiration].
extension AspirationPatterns on Aspiration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Aspiration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Aspiration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Aspiration value)  $default,){
final _that = this;
switch (_that) {
case _Aspiration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Aspiration value)?  $default,){
final _that = this;
switch (_that) {
case _Aspiration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String number,  String schoolId, @JsonKey(unknownEnumValue: AspirationType.saran)  AspirationType type,  String topic,  String topicLabel,  String title,  String content,  String source,  bool anonymous,  bool flagged, @JsonKey(unknownEnumValue: AspirationStatus.diterima)  AspirationStatus status,  AspirationResponse? response, @JsonKey(unknownEnumValue: BoardState.none)  BoardState board, @TimestampConverter()  DateTime? publishedAt,  int supportCount, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Aspiration() when $default != null:
return $default(_that.id,_that.number,_that.schoolId,_that.type,_that.topic,_that.topicLabel,_that.title,_that.content,_that.source,_that.anonymous,_that.flagged,_that.status,_that.response,_that.board,_that.publishedAt,_that.supportCount,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String number,  String schoolId, @JsonKey(unknownEnumValue: AspirationType.saran)  AspirationType type,  String topic,  String topicLabel,  String title,  String content,  String source,  bool anonymous,  bool flagged, @JsonKey(unknownEnumValue: AspirationStatus.diterima)  AspirationStatus status,  AspirationResponse? response, @JsonKey(unknownEnumValue: BoardState.none)  BoardState board, @TimestampConverter()  DateTime? publishedAt,  int supportCount, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Aspiration():
return $default(_that.id,_that.number,_that.schoolId,_that.type,_that.topic,_that.topicLabel,_that.title,_that.content,_that.source,_that.anonymous,_that.flagged,_that.status,_that.response,_that.board,_that.publishedAt,_that.supportCount,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String number,  String schoolId, @JsonKey(unknownEnumValue: AspirationType.saran)  AspirationType type,  String topic,  String topicLabel,  String title,  String content,  String source,  bool anonymous,  bool flagged, @JsonKey(unknownEnumValue: AspirationStatus.diterima)  AspirationStatus status,  AspirationResponse? response, @JsonKey(unknownEnumValue: BoardState.none)  BoardState board, @TimestampConverter()  DateTime? publishedAt,  int supportCount, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Aspiration() when $default != null:
return $default(_that.id,_that.number,_that.schoolId,_that.type,_that.topic,_that.topicLabel,_that.title,_that.content,_that.source,_that.anonymous,_that.flagged,_that.status,_that.response,_that.board,_that.publishedAt,_that.supportCount,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Aspiration extends Aspiration {
  const _Aspiration({required this.id, this.number = '', this.schoolId = '', @JsonKey(unknownEnumValue: AspirationType.saran) this.type = AspirationType.saran, this.topic = 'lainnya', this.topicLabel = '', this.title = '', this.content = '', this.source = 'siswa', this.anonymous = false, this.flagged = false, @JsonKey(unknownEnumValue: AspirationStatus.diterima) this.status = AspirationStatus.diterima, this.response, @JsonKey(unknownEnumValue: BoardState.none) this.board = BoardState.none, @TimestampConverter() this.publishedAt, this.supportCount = 0, @TimestampConverter() this.createdAt, @TimestampConverter() this.updatedAt}): super._();
  factory _Aspiration.fromJson(Map<String, dynamic> json) => _$AspirationFromJson(json);

@override final  String id;
@override@JsonKey() final  String number;
@override@JsonKey() final  String schoolId;
@override@JsonKey(unknownEnumValue: AspirationType.saran) final  AspirationType type;
@override@JsonKey() final  String topic;
@override@JsonKey() final  String topicLabel;
@override@JsonKey() final  String title;
@override@JsonKey() final  String content;
@override@JsonKey() final  String source;
@override@JsonKey() final  bool anonymous;
@override@JsonKey() final  bool flagged;
@override@JsonKey(unknownEnumValue: AspirationStatus.diterima) final  AspirationStatus status;
@override final  AspirationResponse? response;
@override@JsonKey(unknownEnumValue: BoardState.none) final  BoardState board;
@override@TimestampConverter() final  DateTime? publishedAt;
@override@JsonKey() final  int supportCount;
@override@TimestampConverter() final  DateTime? createdAt;
@override@TimestampConverter() final  DateTime? updatedAt;

/// Create a copy of Aspiration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AspirationCopyWith<_Aspiration> get copyWith => __$AspirationCopyWithImpl<_Aspiration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AspirationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Aspiration&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.schoolId, schoolId) || other.schoolId == schoolId)&&(identical(other.type, type) || other.type == type)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.topicLabel, topicLabel) || other.topicLabel == topicLabel)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.source, source) || other.source == source)&&(identical(other.anonymous, anonymous) || other.anonymous == anonymous)&&(identical(other.flagged, flagged) || other.flagged == flagged)&&(identical(other.status, status) || other.status == status)&&(identical(other.response, response) || other.response == response)&&(identical(other.board, board) || other.board == board)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.supportCount, supportCount) || other.supportCount == supportCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,number,schoolId,type,topic,topicLabel,title,content,source,anonymous,flagged,status,response,board,publishedAt,supportCount,createdAt,updatedAt);
}

@override
String toString() {
    return 'Aspiration(id: $id, number: $number, schoolId: $schoolId, type: $type, topic: $topic, topicLabel: $topicLabel, title: $title, content: $content, source: $source, anonymous: $anonymous, flagged: $flagged, status: $status, response: $response, board: $board, publishedAt: $publishedAt, supportCount: $supportCount, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$AspirationCopyWith<$Res> implements $AspirationCopyWith<$Res> {
  factory _$AspirationCopyWith(_Aspiration value, $Res Function(_Aspiration) _then) = __$AspirationCopyWithImpl;
@override @useResult
$Res call({
 String id, String number, String schoolId,@JsonKey(unknownEnumValue: AspirationType.saran) AspirationType type, String topic, String topicLabel, String title, String content, String source, bool anonymous, bool flagged,@JsonKey(unknownEnumValue: AspirationStatus.diterima) AspirationStatus status, AspirationResponse? response,@JsonKey(unknownEnumValue: BoardState.none) BoardState board,@TimestampConverter() DateTime? publishedAt, int supportCount,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt
});


@override $AspirationResponseCopyWith<$Res>? get response;

}
/// @nodoc
class __$AspirationCopyWithImpl<$Res>
    implements _$AspirationCopyWith<$Res> {
  __$AspirationCopyWithImpl(this._self, this._then);

  final _Aspiration _self;
  final $Res Function(_Aspiration) _then;

/// Create a copy of Aspiration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? number = null,Object? schoolId = null,Object? type = null,Object? topic = null,Object? topicLabel = null,Object? title = null,Object? content = null,Object? source = null,Object? anonymous = null,Object? flagged = null,Object? status = null,Object? response = freezed,Object? board = null,Object? publishedAt = freezed,Object? supportCount = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Aspiration(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,schoolId: null == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AspirationType,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,topicLabel: null == topicLabel ? _self.topicLabel : topicLabel // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,anonymous: null == anonymous ? _self.anonymous : anonymous // ignore: cast_nullable_to_non_nullable
as bool,flagged: null == flagged ? _self.flagged : flagged // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AspirationStatus,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as AspirationResponse?,board: null == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as BoardState,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,supportCount: null == supportCount ? _self.supportCount : supportCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Aspiration
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AspirationResponseCopyWith<$Res>? get response {
    if (_self.response == null) {
    return null;
  }

  return $AspirationResponseCopyWith<$Res>(_self.response!, (value) {
    return _then(_self.copyWith(response: value));
  });
}
}


/// @nodoc
mixin _$AspirationIdentity {

 String get name; String? get kelas;
/// Create a copy of AspirationIdentity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AspirationIdentityCopyWith<AspirationIdentity> get copyWith => _$AspirationIdentityCopyWithImpl<AspirationIdentity>(this as AspirationIdentity, _$identity);

  /// Serializes this AspirationIdentity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AspirationIdentity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AspirationIdentity&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.kelas, _this.kelas) || other.kelas == _this.kelas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AspirationIdentity;
  return Object.hash(runtimeType,_this.name,_this.kelas);
}

@override
String toString() {
  final _this = this as AspirationIdentity;
  return 'AspirationIdentity(name: ${_this.name}, kelas: ${_this.kelas})';
}


}

/// @nodoc
abstract mixin class $AspirationIdentityCopyWith<$Res>  {
  factory $AspirationIdentityCopyWith(AspirationIdentity value, $Res Function(AspirationIdentity) _then) = _$AspirationIdentityCopyWithImpl;
@useResult
$Res call({
 String name, String? kelas
});




}
/// @nodoc
class _$AspirationIdentityCopyWithImpl<$Res>
    implements $AspirationIdentityCopyWith<$Res> {
  _$AspirationIdentityCopyWithImpl(this._self, this._then);

  final AspirationIdentity _self;
  final $Res Function(AspirationIdentity) _then;

/// Create a copy of AspirationIdentity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? kelas = freezed,}) {
  return _then(AspirationIdentity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kelas: freezed == kelas ? _self.kelas : kelas // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AspirationIdentity].
extension AspirationIdentityPatterns on AspirationIdentity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AspirationIdentity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AspirationIdentity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AspirationIdentity value)  $default,){
final _that = this;
switch (_that) {
case _AspirationIdentity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AspirationIdentity value)?  $default,){
final _that = this;
switch (_that) {
case _AspirationIdentity() when $default != null:
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
case _AspirationIdentity() when $default != null:
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
case _AspirationIdentity():
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
case _AspirationIdentity() when $default != null:
return $default(_that.name,_that.kelas);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AspirationIdentity implements AspirationIdentity {
  const _AspirationIdentity({required this.name, this.kelas});
  factory _AspirationIdentity.fromJson(Map<String, dynamic> json) => _$AspirationIdentityFromJson(json);

@override final  String name;
@override final  String? kelas;

/// Create a copy of AspirationIdentity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AspirationIdentityCopyWith<_AspirationIdentity> get copyWith => __$AspirationIdentityCopyWithImpl<_AspirationIdentity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AspirationIdentityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AspirationIdentity&&(identical(other.name, name) || other.name == name)&&(identical(other.kelas, kelas) || other.kelas == kelas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,kelas);
}

@override
String toString() {
    return 'AspirationIdentity(name: $name, kelas: $kelas)';
}


}

/// @nodoc
abstract mixin class _$AspirationIdentityCopyWith<$Res> implements $AspirationIdentityCopyWith<$Res> {
  factory _$AspirationIdentityCopyWith(_AspirationIdentity value, $Res Function(_AspirationIdentity) _then) = __$AspirationIdentityCopyWithImpl;
@override @useResult
$Res call({
 String name, String? kelas
});




}
/// @nodoc
class __$AspirationIdentityCopyWithImpl<$Res>
    implements _$AspirationIdentityCopyWith<$Res> {
  __$AspirationIdentityCopyWithImpl(this._self, this._then);

  final _AspirationIdentity _self;
  final $Res Function(_AspirationIdentity) _then;

/// Create a copy of AspirationIdentity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? kelas = freezed,}) {
  return _then(_AspirationIdentity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kelas: freezed == kelas ? _self.kelas : kelas // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AspirationOwner {

 String get id; String get uid;@TimestampConverter() DateTime? get createdAt;
/// Create a copy of AspirationOwner
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AspirationOwnerCopyWith<AspirationOwner> get copyWith => _$AspirationOwnerCopyWithImpl<AspirationOwner>(this as AspirationOwner, _$identity);

  /// Serializes this AspirationOwner to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AspirationOwner;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AspirationOwner&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.uid, _this.uid) || other.uid == _this.uid)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AspirationOwner;
  return Object.hash(runtimeType,_this.id,_this.uid,_this.createdAt);
}

@override
String toString() {
  final _this = this as AspirationOwner;
  return 'AspirationOwner(id: ${_this.id}, uid: ${_this.uid}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $AspirationOwnerCopyWith<$Res>  {
  factory $AspirationOwnerCopyWith(AspirationOwner value, $Res Function(AspirationOwner) _then) = _$AspirationOwnerCopyWithImpl;
@useResult
$Res call({
 String id, String uid,@TimestampConverter() DateTime? createdAt
});




}
/// @nodoc
class _$AspirationOwnerCopyWithImpl<$Res>
    implements $AspirationOwnerCopyWith<$Res> {
  _$AspirationOwnerCopyWithImpl(this._self, this._then);

  final AspirationOwner _self;
  final $Res Function(AspirationOwner) _then;

/// Create a copy of AspirationOwner
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? uid = null,Object? createdAt = freezed,}) {
  return _then(AspirationOwner(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AspirationOwner].
extension AspirationOwnerPatterns on AspirationOwner {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AspirationOwner value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AspirationOwner() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AspirationOwner value)  $default,){
final _that = this;
switch (_that) {
case _AspirationOwner():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AspirationOwner value)?  $default,){
final _that = this;
switch (_that) {
case _AspirationOwner() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String uid, @TimestampConverter()  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AspirationOwner() when $default != null:
return $default(_that.id,_that.uid,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String uid, @TimestampConverter()  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _AspirationOwner():
return $default(_that.id,_that.uid,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String uid, @TimestampConverter()  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AspirationOwner() when $default != null:
return $default(_that.id,_that.uid,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AspirationOwner implements AspirationOwner {
  const _AspirationOwner({required this.id, required this.uid, @TimestampConverter() this.createdAt});
  factory _AspirationOwner.fromJson(Map<String, dynamic> json) => _$AspirationOwnerFromJson(json);

@override final  String id;
@override final  String uid;
@override@TimestampConverter() final  DateTime? createdAt;

/// Create a copy of AspirationOwner
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AspirationOwnerCopyWith<_AspirationOwner> get copyWith => __$AspirationOwnerCopyWithImpl<_AspirationOwner>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AspirationOwnerToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AspirationOwner&&(identical(other.id, id) || other.id == id)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,uid,createdAt);
}

@override
String toString() {
    return 'AspirationOwner(id: $id, uid: $uid, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AspirationOwnerCopyWith<$Res> implements $AspirationOwnerCopyWith<$Res> {
  factory _$AspirationOwnerCopyWith(_AspirationOwner value, $Res Function(_AspirationOwner) _then) = __$AspirationOwnerCopyWithImpl;
@override @useResult
$Res call({
 String id, String uid,@TimestampConverter() DateTime? createdAt
});




}
/// @nodoc
class __$AspirationOwnerCopyWithImpl<$Res>
    implements _$AspirationOwnerCopyWith<$Res> {
  __$AspirationOwnerCopyWithImpl(this._self, this._then);

  final _AspirationOwner _self;
  final $Res Function(_AspirationOwner) _then;

/// Create a copy of AspirationOwner
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? uid = null,Object? createdAt = freezed,}) {
  return _then(_AspirationOwner(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
