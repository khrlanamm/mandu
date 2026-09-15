// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'care.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HelpRequest {

 String get id; String get number; String get schoolId; String get studentUid; HelpStudent get student; List<String> get needs;@JsonKey(unknownEnumValue: HelpUrgency.biasa) HelpUrgency get urgency;@JsonKey(unknownEnumValue: ContactMethod.chat) ContactMethod get contactMethod;@JsonKey(unknownEnumValue: ContactTime.kapanSaja) ContactTime get contactTime; String? get whatsapp; String? get note;@JsonKey(unknownEnumValue: HelpStatus.menunggu) HelpStatus get status; String? get counselorUid; String? get counselorName; String? get conversationId; String? get closingNote;@TimestampConverter() DateTime? get createdAt;@TimestampConverter() DateTime? get claimedAt;@TimestampConverter() DateTime? get closedAt;
/// Create a copy of HelpRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HelpRequestCopyWith<HelpRequest> get copyWith => _$HelpRequestCopyWithImpl<HelpRequest>(this as HelpRequest, _$identity);

  /// Serializes this HelpRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as HelpRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HelpRequest&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.schoolId, _this.schoolId) || other.schoolId == _this.schoolId)&&(identical(other.studentUid, _this.studentUid) || other.studentUid == _this.studentUid)&&(identical(other.student, _this.student) || other.student == _this.student)&&const DeepCollectionEquality().equals(other.needs, _this.needs)&&(identical(other.urgency, _this.urgency) || other.urgency == _this.urgency)&&(identical(other.contactMethod, _this.contactMethod) || other.contactMethod == _this.contactMethod)&&(identical(other.contactTime, _this.contactTime) || other.contactTime == _this.contactTime)&&(identical(other.whatsapp, _this.whatsapp) || other.whatsapp == _this.whatsapp)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.counselorUid, _this.counselorUid) || other.counselorUid == _this.counselorUid)&&(identical(other.counselorName, _this.counselorName) || other.counselorName == _this.counselorName)&&(identical(other.conversationId, _this.conversationId) || other.conversationId == _this.conversationId)&&(identical(other.closingNote, _this.closingNote) || other.closingNote == _this.closingNote)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.claimedAt, _this.claimedAt) || other.claimedAt == _this.claimedAt)&&(identical(other.closedAt, _this.closedAt) || other.closedAt == _this.closedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as HelpRequest;
  return Object.hashAll([runtimeType,_this.id,_this.number,_this.schoolId,_this.studentUid,_this.student,const DeepCollectionEquality().hash(_this.needs),_this.urgency,_this.contactMethod,_this.contactTime,_this.whatsapp,_this.note,_this.status,_this.counselorUid,_this.counselorName,_this.conversationId,_this.closingNote,_this.createdAt,_this.claimedAt,_this.closedAt]);
}

@override
String toString() {
  final _this = this as HelpRequest;
  return 'HelpRequest(id: ${_this.id}, number: ${_this.number}, schoolId: ${_this.schoolId}, studentUid: ${_this.studentUid}, student: ${_this.student}, needs: ${_this.needs}, urgency: ${_this.urgency}, contactMethod: ${_this.contactMethod}, contactTime: ${_this.contactTime}, whatsapp: ${_this.whatsapp}, note: ${_this.note}, status: ${_this.status}, counselorUid: ${_this.counselorUid}, counselorName: ${_this.counselorName}, conversationId: ${_this.conversationId}, closingNote: ${_this.closingNote}, createdAt: ${_this.createdAt}, claimedAt: ${_this.claimedAt}, closedAt: ${_this.closedAt})';
}


}

/// @nodoc
abstract mixin class $HelpRequestCopyWith<$Res>  {
  factory $HelpRequestCopyWith(HelpRequest value, $Res Function(HelpRequest) _then) = _$HelpRequestCopyWithImpl;
@useResult
$Res call({
 String id, String number, String schoolId, String studentUid, HelpStudent student, List<String> needs,@JsonKey(unknownEnumValue: HelpUrgency.biasa) HelpUrgency urgency,@JsonKey(unknownEnumValue: ContactMethod.chat) ContactMethod contactMethod,@JsonKey(unknownEnumValue: ContactTime.kapanSaja) ContactTime contactTime, String? whatsapp, String? note,@JsonKey(unknownEnumValue: HelpStatus.menunggu) HelpStatus status, String? counselorUid, String? counselorName, String? conversationId, String? closingNote,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? claimedAt,@TimestampConverter() DateTime? closedAt
});


$HelpStudentCopyWith<$Res> get student;

}
/// @nodoc
class _$HelpRequestCopyWithImpl<$Res>
    implements $HelpRequestCopyWith<$Res> {
  _$HelpRequestCopyWithImpl(this._self, this._then);

  final HelpRequest _self;
  final $Res Function(HelpRequest) _then;

/// Create a copy of HelpRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? number = null,Object? schoolId = null,Object? studentUid = null,Object? student = null,Object? needs = null,Object? urgency = null,Object? contactMethod = null,Object? contactTime = null,Object? whatsapp = freezed,Object? note = freezed,Object? status = null,Object? counselorUid = freezed,Object? counselorName = freezed,Object? conversationId = freezed,Object? closingNote = freezed,Object? createdAt = freezed,Object? claimedAt = freezed,Object? closedAt = freezed,}) {
  return _then(HelpRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,schoolId: null == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String,studentUid: null == studentUid ? _self.studentUid : studentUid // ignore: cast_nullable_to_non_nullable
as String,student: null == student ? _self.student : student // ignore: cast_nullable_to_non_nullable
as HelpStudent,needs: null == needs ? _self.needs : needs // ignore: cast_nullable_to_non_nullable
as List<String>,urgency: null == urgency ? _self.urgency : urgency // ignore: cast_nullable_to_non_nullable
as HelpUrgency,contactMethod: null == contactMethod ? _self.contactMethod : contactMethod // ignore: cast_nullable_to_non_nullable
as ContactMethod,contactTime: null == contactTime ? _self.contactTime : contactTime // ignore: cast_nullable_to_non_nullable
as ContactTime,whatsapp: freezed == whatsapp ? _self.whatsapp : whatsapp // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HelpStatus,counselorUid: freezed == counselorUid ? _self.counselorUid : counselorUid // ignore: cast_nullable_to_non_nullable
as String?,counselorName: freezed == counselorName ? _self.counselorName : counselorName // ignore: cast_nullable_to_non_nullable
as String?,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String?,closingNote: freezed == closingNote ? _self.closingNote : closingNote // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimedAt: freezed == claimedAt ? _self.claimedAt : claimedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of HelpRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HelpStudentCopyWith<$Res> get student {
  
  return $HelpStudentCopyWith<$Res>(_self.student, (value) {
    return _then(_self.copyWith(student: value));
  });
}
}


/// Adds pattern-matching-related methods to [HelpRequest].
extension HelpRequestPatterns on HelpRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HelpRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HelpRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HelpRequest value)  $default,){
final _that = this;
switch (_that) {
case _HelpRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HelpRequest value)?  $default,){
final _that = this;
switch (_that) {
case _HelpRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String number,  String schoolId,  String studentUid,  HelpStudent student,  List<String> needs, @JsonKey(unknownEnumValue: HelpUrgency.biasa)  HelpUrgency urgency, @JsonKey(unknownEnumValue: ContactMethod.chat)  ContactMethod contactMethod, @JsonKey(unknownEnumValue: ContactTime.kapanSaja)  ContactTime contactTime,  String? whatsapp,  String? note, @JsonKey(unknownEnumValue: HelpStatus.menunggu)  HelpStatus status,  String? counselorUid,  String? counselorName,  String? conversationId,  String? closingNote, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? claimedAt, @TimestampConverter()  DateTime? closedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HelpRequest() when $default != null:
return $default(_that.id,_that.number,_that.schoolId,_that.studentUid,_that.student,_that.needs,_that.urgency,_that.contactMethod,_that.contactTime,_that.whatsapp,_that.note,_that.status,_that.counselorUid,_that.counselorName,_that.conversationId,_that.closingNote,_that.createdAt,_that.claimedAt,_that.closedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String number,  String schoolId,  String studentUid,  HelpStudent student,  List<String> needs, @JsonKey(unknownEnumValue: HelpUrgency.biasa)  HelpUrgency urgency, @JsonKey(unknownEnumValue: ContactMethod.chat)  ContactMethod contactMethod, @JsonKey(unknownEnumValue: ContactTime.kapanSaja)  ContactTime contactTime,  String? whatsapp,  String? note, @JsonKey(unknownEnumValue: HelpStatus.menunggu)  HelpStatus status,  String? counselorUid,  String? counselorName,  String? conversationId,  String? closingNote, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? claimedAt, @TimestampConverter()  DateTime? closedAt)  $default,) {final _that = this;
switch (_that) {
case _HelpRequest():
return $default(_that.id,_that.number,_that.schoolId,_that.studentUid,_that.student,_that.needs,_that.urgency,_that.contactMethod,_that.contactTime,_that.whatsapp,_that.note,_that.status,_that.counselorUid,_that.counselorName,_that.conversationId,_that.closingNote,_that.createdAt,_that.claimedAt,_that.closedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String number,  String schoolId,  String studentUid,  HelpStudent student,  List<String> needs, @JsonKey(unknownEnumValue: HelpUrgency.biasa)  HelpUrgency urgency, @JsonKey(unknownEnumValue: ContactMethod.chat)  ContactMethod contactMethod, @JsonKey(unknownEnumValue: ContactTime.kapanSaja)  ContactTime contactTime,  String? whatsapp,  String? note, @JsonKey(unknownEnumValue: HelpStatus.menunggu)  HelpStatus status,  String? counselorUid,  String? counselorName,  String? conversationId,  String? closingNote, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? claimedAt, @TimestampConverter()  DateTime? closedAt)?  $default,) {final _that = this;
switch (_that) {
case _HelpRequest() when $default != null:
return $default(_that.id,_that.number,_that.schoolId,_that.studentUid,_that.student,_that.needs,_that.urgency,_that.contactMethod,_that.contactTime,_that.whatsapp,_that.note,_that.status,_that.counselorUid,_that.counselorName,_that.conversationId,_that.closingNote,_that.createdAt,_that.claimedAt,_that.closedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HelpRequest extends HelpRequest {
  const _HelpRequest({required this.id, this.number = '', this.schoolId = '', this.studentUid = '', this.student = const HelpStudent(),  List<String> needs = const <String>[], @JsonKey(unknownEnumValue: HelpUrgency.biasa) this.urgency = HelpUrgency.biasa, @JsonKey(unknownEnumValue: ContactMethod.chat) this.contactMethod = ContactMethod.chat, @JsonKey(unknownEnumValue: ContactTime.kapanSaja) this.contactTime = ContactTime.kapanSaja, this.whatsapp, this.note, @JsonKey(unknownEnumValue: HelpStatus.menunggu) this.status = HelpStatus.menunggu, this.counselorUid, this.counselorName, this.conversationId, this.closingNote, @TimestampConverter() this.createdAt, @TimestampConverter() this.claimedAt, @TimestampConverter() this.closedAt}): _needs = needs,super._();
  factory _HelpRequest.fromJson(Map<String, dynamic> json) => _$HelpRequestFromJson(json);

@override final  String id;
@override@JsonKey() final  String number;
@override@JsonKey() final  String schoolId;
@override@JsonKey() final  String studentUid;
@override@JsonKey() final  HelpStudent student;
 final  List<String> _needs;
@override@JsonKey() List<String> get needs {
  if (_needs is EqualUnmodifiableListView) return _needs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_needs);
}

@override@JsonKey(unknownEnumValue: HelpUrgency.biasa) final  HelpUrgency urgency;
@override@JsonKey(unknownEnumValue: ContactMethod.chat) final  ContactMethod contactMethod;
@override@JsonKey(unknownEnumValue: ContactTime.kapanSaja) final  ContactTime contactTime;
@override final  String? whatsapp;
@override final  String? note;
@override@JsonKey(unknownEnumValue: HelpStatus.menunggu) final  HelpStatus status;
@override final  String? counselorUid;
@override final  String? counselorName;
@override final  String? conversationId;
@override final  String? closingNote;
@override@TimestampConverter() final  DateTime? createdAt;
@override@TimestampConverter() final  DateTime? claimedAt;
@override@TimestampConverter() final  DateTime? closedAt;

/// Create a copy of HelpRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HelpRequestCopyWith<_HelpRequest> get copyWith => __$HelpRequestCopyWithImpl<_HelpRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HelpRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HelpRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.schoolId, schoolId) || other.schoolId == schoolId)&&(identical(other.studentUid, studentUid) || other.studentUid == studentUid)&&(identical(other.student, student) || other.student == student)&&const DeepCollectionEquality().equals(other.needs, _needs)&&(identical(other.urgency, urgency) || other.urgency == urgency)&&(identical(other.contactMethod, contactMethod) || other.contactMethod == contactMethod)&&(identical(other.contactTime, contactTime) || other.contactTime == contactTime)&&(identical(other.whatsapp, whatsapp) || other.whatsapp == whatsapp)&&(identical(other.note, note) || other.note == note)&&(identical(other.status, status) || other.status == status)&&(identical(other.counselorUid, counselorUid) || other.counselorUid == counselorUid)&&(identical(other.counselorName, counselorName) || other.counselorName == counselorName)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.closingNote, closingNote) || other.closingNote == closingNote)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.claimedAt, claimedAt) || other.claimedAt == claimedAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,number,schoolId,studentUid,student,const DeepCollectionEquality().hash(_needs),urgency,contactMethod,contactTime,whatsapp,note,status,counselorUid,counselorName,conversationId,closingNote,createdAt,claimedAt,closedAt]);
}

@override
String toString() {
    return 'HelpRequest(id: $id, number: $number, schoolId: $schoolId, studentUid: $studentUid, student: $student, needs: $needs, urgency: $urgency, contactMethod: $contactMethod, contactTime: $contactTime, whatsapp: $whatsapp, note: $note, status: $status, counselorUid: $counselorUid, counselorName: $counselorName, conversationId: $conversationId, closingNote: $closingNote, createdAt: $createdAt, claimedAt: $claimedAt, closedAt: $closedAt)';
}


}

/// @nodoc
abstract mixin class _$HelpRequestCopyWith<$Res> implements $HelpRequestCopyWith<$Res> {
  factory _$HelpRequestCopyWith(_HelpRequest value, $Res Function(_HelpRequest) _then) = __$HelpRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String number, String schoolId, String studentUid, HelpStudent student, List<String> needs,@JsonKey(unknownEnumValue: HelpUrgency.biasa) HelpUrgency urgency,@JsonKey(unknownEnumValue: ContactMethod.chat) ContactMethod contactMethod,@JsonKey(unknownEnumValue: ContactTime.kapanSaja) ContactTime contactTime, String? whatsapp, String? note,@JsonKey(unknownEnumValue: HelpStatus.menunggu) HelpStatus status, String? counselorUid, String? counselorName, String? conversationId, String? closingNote,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? claimedAt,@TimestampConverter() DateTime? closedAt
});


@override $HelpStudentCopyWith<$Res> get student;

}
/// @nodoc
class __$HelpRequestCopyWithImpl<$Res>
    implements _$HelpRequestCopyWith<$Res> {
  __$HelpRequestCopyWithImpl(this._self, this._then);

  final _HelpRequest _self;
  final $Res Function(_HelpRequest) _then;

/// Create a copy of HelpRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? number = null,Object? schoolId = null,Object? studentUid = null,Object? student = null,Object? needs = null,Object? urgency = null,Object? contactMethod = null,Object? contactTime = null,Object? whatsapp = freezed,Object? note = freezed,Object? status = null,Object? counselorUid = freezed,Object? counselorName = freezed,Object? conversationId = freezed,Object? closingNote = freezed,Object? createdAt = freezed,Object? claimedAt = freezed,Object? closedAt = freezed,}) {
  return _then(_HelpRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,schoolId: null == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String,studentUid: null == studentUid ? _self.studentUid : studentUid // ignore: cast_nullable_to_non_nullable
as String,student: null == student ? _self.student : student // ignore: cast_nullable_to_non_nullable
as HelpStudent,needs: null == needs ? _self._needs : needs // ignore: cast_nullable_to_non_nullable
as List<String>,urgency: null == urgency ? _self.urgency : urgency // ignore: cast_nullable_to_non_nullable
as HelpUrgency,contactMethod: null == contactMethod ? _self.contactMethod : contactMethod // ignore: cast_nullable_to_non_nullable
as ContactMethod,contactTime: null == contactTime ? _self.contactTime : contactTime // ignore: cast_nullable_to_non_nullable
as ContactTime,whatsapp: freezed == whatsapp ? _self.whatsapp : whatsapp // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HelpStatus,counselorUid: freezed == counselorUid ? _self.counselorUid : counselorUid // ignore: cast_nullable_to_non_nullable
as String?,counselorName: freezed == counselorName ? _self.counselorName : counselorName // ignore: cast_nullable_to_non_nullable
as String?,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String?,closingNote: freezed == closingNote ? _self.closingNote : closingNote // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimedAt: freezed == claimedAt ? _self.claimedAt : claimedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of HelpRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HelpStudentCopyWith<$Res> get student {
  
  return $HelpStudentCopyWith<$Res>(_self.student, (value) {
    return _then(_self.copyWith(student: value));
  });
}
}


/// @nodoc
mixin _$HelpStudent {

 String get name; String? get kelas;
/// Create a copy of HelpStudent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HelpStudentCopyWith<HelpStudent> get copyWith => _$HelpStudentCopyWithImpl<HelpStudent>(this as HelpStudent, _$identity);

  /// Serializes this HelpStudent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as HelpStudent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HelpStudent&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.kelas, _this.kelas) || other.kelas == _this.kelas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as HelpStudent;
  return Object.hash(runtimeType,_this.name,_this.kelas);
}

@override
String toString() {
  final _this = this as HelpStudent;
  return 'HelpStudent(name: ${_this.name}, kelas: ${_this.kelas})';
}


}

/// @nodoc
abstract mixin class $HelpStudentCopyWith<$Res>  {
  factory $HelpStudentCopyWith(HelpStudent value, $Res Function(HelpStudent) _then) = _$HelpStudentCopyWithImpl;
@useResult
$Res call({
 String name, String? kelas
});




}
/// @nodoc
class _$HelpStudentCopyWithImpl<$Res>
    implements $HelpStudentCopyWith<$Res> {
  _$HelpStudentCopyWithImpl(this._self, this._then);

  final HelpStudent _self;
  final $Res Function(HelpStudent) _then;

/// Create a copy of HelpStudent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? kelas = freezed,}) {
  return _then(HelpStudent(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kelas: freezed == kelas ? _self.kelas : kelas // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HelpStudent].
extension HelpStudentPatterns on HelpStudent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HelpStudent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HelpStudent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HelpStudent value)  $default,){
final _that = this;
switch (_that) {
case _HelpStudent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HelpStudent value)?  $default,){
final _that = this;
switch (_that) {
case _HelpStudent() when $default != null:
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
case _HelpStudent() when $default != null:
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
case _HelpStudent():
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
case _HelpStudent() when $default != null:
return $default(_that.name,_that.kelas);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HelpStudent implements HelpStudent {
  const _HelpStudent({this.name = '', this.kelas});
  factory _HelpStudent.fromJson(Map<String, dynamic> json) => _$HelpStudentFromJson(json);

@override@JsonKey() final  String name;
@override final  String? kelas;

/// Create a copy of HelpStudent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HelpStudentCopyWith<_HelpStudent> get copyWith => __$HelpStudentCopyWithImpl<_HelpStudent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HelpStudentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HelpStudent&&(identical(other.name, name) || other.name == name)&&(identical(other.kelas, kelas) || other.kelas == kelas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,kelas);
}

@override
String toString() {
    return 'HelpStudent(name: $name, kelas: $kelas)';
}


}

/// @nodoc
abstract mixin class _$HelpStudentCopyWith<$Res> implements $HelpStudentCopyWith<$Res> {
  factory _$HelpStudentCopyWith(_HelpStudent value, $Res Function(_HelpStudent) _then) = __$HelpStudentCopyWithImpl;
@override @useResult
$Res call({
 String name, String? kelas
});




}
/// @nodoc
class __$HelpStudentCopyWithImpl<$Res>
    implements _$HelpStudentCopyWith<$Res> {
  __$HelpStudentCopyWithImpl(this._self, this._then);

  final _HelpStudent _self;
  final $Res Function(_HelpStudent) _then;

/// Create a copy of HelpStudent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? kelas = freezed,}) {
  return _then(_HelpStudent(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kelas: freezed == kelas ? _self.kelas : kelas // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$LastMessage {

 String get text;@JsonKey(unknownEnumValue: MessageRole.sistem) MessageRole get senderRole;@TimestampConverter() DateTime? get at;
/// Create a copy of LastMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LastMessageCopyWith<LastMessage> get copyWith => _$LastMessageCopyWithImpl<LastMessage>(this as LastMessage, _$identity);

  /// Serializes this LastMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LastMessage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LastMessage&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.senderRole, _this.senderRole) || other.senderRole == _this.senderRole)&&(identical(other.at, _this.at) || other.at == _this.at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LastMessage;
  return Object.hash(runtimeType,_this.text,_this.senderRole,_this.at);
}

@override
String toString() {
  final _this = this as LastMessage;
  return 'LastMessage(text: ${_this.text}, senderRole: ${_this.senderRole}, at: ${_this.at})';
}


}

/// @nodoc
abstract mixin class $LastMessageCopyWith<$Res>  {
  factory $LastMessageCopyWith(LastMessage value, $Res Function(LastMessage) _then) = _$LastMessageCopyWithImpl;
@useResult
$Res call({
 String text,@JsonKey(unknownEnumValue: MessageRole.sistem) MessageRole senderRole,@TimestampConverter() DateTime? at
});




}
/// @nodoc
class _$LastMessageCopyWithImpl<$Res>
    implements $LastMessageCopyWith<$Res> {
  _$LastMessageCopyWithImpl(this._self, this._then);

  final LastMessage _self;
  final $Res Function(LastMessage) _then;

/// Create a copy of LastMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? senderRole = null,Object? at = freezed,}) {
  return _then(LastMessage(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,senderRole: null == senderRole ? _self.senderRole : senderRole // ignore: cast_nullable_to_non_nullable
as MessageRole,at: freezed == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [LastMessage].
extension LastMessagePatterns on LastMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LastMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LastMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LastMessage value)  $default,){
final _that = this;
switch (_that) {
case _LastMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LastMessage value)?  $default,){
final _that = this;
switch (_that) {
case _LastMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text, @JsonKey(unknownEnumValue: MessageRole.sistem)  MessageRole senderRole, @TimestampConverter()  DateTime? at)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LastMessage() when $default != null:
return $default(_that.text,_that.senderRole,_that.at);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text, @JsonKey(unknownEnumValue: MessageRole.sistem)  MessageRole senderRole, @TimestampConverter()  DateTime? at)  $default,) {final _that = this;
switch (_that) {
case _LastMessage():
return $default(_that.text,_that.senderRole,_that.at);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text, @JsonKey(unknownEnumValue: MessageRole.sistem)  MessageRole senderRole, @TimestampConverter()  DateTime? at)?  $default,) {final _that = this;
switch (_that) {
case _LastMessage() when $default != null:
return $default(_that.text,_that.senderRole,_that.at);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LastMessage implements LastMessage {
  const _LastMessage({this.text = '', @JsonKey(unknownEnumValue: MessageRole.sistem) this.senderRole = MessageRole.sistem, @TimestampConverter() this.at});
  factory _LastMessage.fromJson(Map<String, dynamic> json) => _$LastMessageFromJson(json);

@override@JsonKey() final  String text;
@override@JsonKey(unknownEnumValue: MessageRole.sistem) final  MessageRole senderRole;
@override@TimestampConverter() final  DateTime? at;

/// Create a copy of LastMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LastMessageCopyWith<_LastMessage> get copyWith => __$LastMessageCopyWithImpl<_LastMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LastMessageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LastMessage&&(identical(other.text, text) || other.text == text)&&(identical(other.senderRole, senderRole) || other.senderRole == senderRole)&&(identical(other.at, at) || other.at == at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,text,senderRole,at);
}

@override
String toString() {
    return 'LastMessage(text: $text, senderRole: $senderRole, at: $at)';
}


}

/// @nodoc
abstract mixin class _$LastMessageCopyWith<$Res> implements $LastMessageCopyWith<$Res> {
  factory _$LastMessageCopyWith(_LastMessage value, $Res Function(_LastMessage) _then) = __$LastMessageCopyWithImpl;
@override @useResult
$Res call({
 String text,@JsonKey(unknownEnumValue: MessageRole.sistem) MessageRole senderRole,@TimestampConverter() DateTime? at
});




}
/// @nodoc
class __$LastMessageCopyWithImpl<$Res>
    implements _$LastMessageCopyWith<$Res> {
  __$LastMessageCopyWithImpl(this._self, this._then);

  final _LastMessage _self;
  final $Res Function(_LastMessage) _then;

/// Create a copy of LastMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? senderRole = null,Object? at = freezed,}) {
  return _then(_LastMessage(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,senderRole: null == senderRole ? _self.senderRole : senderRole // ignore: cast_nullable_to_non_nullable
as MessageRole,at: freezed == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$MeetingPlan {

@TimestampConverter() DateTime? get at; String get place; String get status;
/// Create a copy of MeetingPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingPlanCopyWith<MeetingPlan> get copyWith => _$MeetingPlanCopyWithImpl<MeetingPlan>(this as MeetingPlan, _$identity);

  /// Serializes this MeetingPlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MeetingPlan;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingPlan&&(identical(other.at, _this.at) || other.at == _this.at)&&(identical(other.place, _this.place) || other.place == _this.place)&&(identical(other.status, _this.status) || other.status == _this.status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MeetingPlan;
  return Object.hash(runtimeType,_this.at,_this.place,_this.status);
}

@override
String toString() {
  final _this = this as MeetingPlan;
  return 'MeetingPlan(at: ${_this.at}, place: ${_this.place}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $MeetingPlanCopyWith<$Res>  {
  factory $MeetingPlanCopyWith(MeetingPlan value, $Res Function(MeetingPlan) _then) = _$MeetingPlanCopyWithImpl;
@useResult
$Res call({
@TimestampConverter() DateTime? at, String place, String status
});




}
/// @nodoc
class _$MeetingPlanCopyWithImpl<$Res>
    implements $MeetingPlanCopyWith<$Res> {
  _$MeetingPlanCopyWithImpl(this._self, this._then);

  final MeetingPlan _self;
  final $Res Function(MeetingPlan) _then;

/// Create a copy of MeetingPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? at = freezed,Object? place = null,Object? status = null,}) {
  return _then(MeetingPlan(
at: freezed == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime?,place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MeetingPlan].
extension MeetingPlanPatterns on MeetingPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingPlan value)  $default,){
final _that = this;
switch (_that) {
case _MeetingPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingPlan value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@TimestampConverter()  DateTime? at,  String place,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingPlan() when $default != null:
return $default(_that.at,_that.place,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@TimestampConverter()  DateTime? at,  String place,  String status)  $default,) {final _that = this;
switch (_that) {
case _MeetingPlan():
return $default(_that.at,_that.place,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@TimestampConverter()  DateTime? at,  String place,  String status)?  $default,) {final _that = this;
switch (_that) {
case _MeetingPlan() when $default != null:
return $default(_that.at,_that.place,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeetingPlan implements MeetingPlan {
  const _MeetingPlan({@TimestampConverter() this.at, this.place = '', this.status = 'diusulkan'});
  factory _MeetingPlan.fromJson(Map<String, dynamic> json) => _$MeetingPlanFromJson(json);

@override@TimestampConverter() final  DateTime? at;
@override@JsonKey() final  String place;
@override@JsonKey() final  String status;

/// Create a copy of MeetingPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingPlanCopyWith<_MeetingPlan> get copyWith => __$MeetingPlanCopyWithImpl<_MeetingPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeetingPlanToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingPlan&&(identical(other.at, at) || other.at == at)&&(identical(other.place, place) || other.place == place)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,at,place,status);
}

@override
String toString() {
    return 'MeetingPlan(at: $at, place: $place, status: $status)';
}


}

/// @nodoc
abstract mixin class _$MeetingPlanCopyWith<$Res> implements $MeetingPlanCopyWith<$Res> {
  factory _$MeetingPlanCopyWith(_MeetingPlan value, $Res Function(_MeetingPlan) _then) = __$MeetingPlanCopyWithImpl;
@override @useResult
$Res call({
@TimestampConverter() DateTime? at, String place, String status
});




}
/// @nodoc
class __$MeetingPlanCopyWithImpl<$Res>
    implements _$MeetingPlanCopyWith<$Res> {
  __$MeetingPlanCopyWithImpl(this._self, this._then);

  final _MeetingPlan _self;
  final $Res Function(_MeetingPlan) _then;

/// Create a copy of MeetingPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? at = freezed,Object? place = null,Object? status = null,}) {
  return _then(_MeetingPlan(
at: freezed == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime?,place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Conversation {

 String get id; String get schoolId; String get studentUid; String get displayName; bool get usesAlias; bool get identityRevealed; String? get counselorUid; String? get counselorName;@JsonKey(unknownEnumValue: ConversationStatus.menunggu) ConversationStatus get status; String? get topic; LastMessage? get lastMessage; int get unreadStudent; int get unreadCounselor; MeetingPlan? get meeting; String? get helpRequestId;@TimestampConverter() DateTime? get createdAt;@TimestampConverter() DateTime? get updatedAt;@TimestampConverter() DateTime? get closedAt;
/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationCopyWith<Conversation> get copyWith => _$ConversationCopyWithImpl<Conversation>(this as Conversation, _$identity);

  /// Serializes this Conversation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Conversation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Conversation&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.schoolId, _this.schoolId) || other.schoolId == _this.schoolId)&&(identical(other.studentUid, _this.studentUid) || other.studentUid == _this.studentUid)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.usesAlias, _this.usesAlias) || other.usesAlias == _this.usesAlias)&&(identical(other.identityRevealed, _this.identityRevealed) || other.identityRevealed == _this.identityRevealed)&&(identical(other.counselorUid, _this.counselorUid) || other.counselorUid == _this.counselorUid)&&(identical(other.counselorName, _this.counselorName) || other.counselorName == _this.counselorName)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.topic, _this.topic) || other.topic == _this.topic)&&(identical(other.lastMessage, _this.lastMessage) || other.lastMessage == _this.lastMessage)&&(identical(other.unreadStudent, _this.unreadStudent) || other.unreadStudent == _this.unreadStudent)&&(identical(other.unreadCounselor, _this.unreadCounselor) || other.unreadCounselor == _this.unreadCounselor)&&(identical(other.meeting, _this.meeting) || other.meeting == _this.meeting)&&(identical(other.helpRequestId, _this.helpRequestId) || other.helpRequestId == _this.helpRequestId)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.closedAt, _this.closedAt) || other.closedAt == _this.closedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Conversation;
  return Object.hash(runtimeType,_this.id,_this.schoolId,_this.studentUid,_this.displayName,_this.usesAlias,_this.identityRevealed,_this.counselorUid,_this.counselorName,_this.status,_this.topic,_this.lastMessage,_this.unreadStudent,_this.unreadCounselor,_this.meeting,_this.helpRequestId,_this.createdAt,_this.updatedAt,_this.closedAt);
}

@override
String toString() {
  final _this = this as Conversation;
  return 'Conversation(id: ${_this.id}, schoolId: ${_this.schoolId}, studentUid: ${_this.studentUid}, displayName: ${_this.displayName}, usesAlias: ${_this.usesAlias}, identityRevealed: ${_this.identityRevealed}, counselorUid: ${_this.counselorUid}, counselorName: ${_this.counselorName}, status: ${_this.status}, topic: ${_this.topic}, lastMessage: ${_this.lastMessage}, unreadStudent: ${_this.unreadStudent}, unreadCounselor: ${_this.unreadCounselor}, meeting: ${_this.meeting}, helpRequestId: ${_this.helpRequestId}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, closedAt: ${_this.closedAt})';
}


}

/// @nodoc
abstract mixin class $ConversationCopyWith<$Res>  {
  factory $ConversationCopyWith(Conversation value, $Res Function(Conversation) _then) = _$ConversationCopyWithImpl;
@useResult
$Res call({
 String id, String schoolId, String studentUid, String displayName, bool usesAlias, bool identityRevealed, String? counselorUid, String? counselorName,@JsonKey(unknownEnumValue: ConversationStatus.menunggu) ConversationStatus status, String? topic, LastMessage? lastMessage, int unreadStudent, int unreadCounselor, MeetingPlan? meeting, String? helpRequestId,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt,@TimestampConverter() DateTime? closedAt
});


$LastMessageCopyWith<$Res>? get lastMessage;$MeetingPlanCopyWith<$Res>? get meeting;

}
/// @nodoc
class _$ConversationCopyWithImpl<$Res>
    implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._self, this._then);

  final Conversation _self;
  final $Res Function(Conversation) _then;

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? schoolId = null,Object? studentUid = null,Object? displayName = null,Object? usesAlias = null,Object? identityRevealed = null,Object? counselorUid = freezed,Object? counselorName = freezed,Object? status = null,Object? topic = freezed,Object? lastMessage = freezed,Object? unreadStudent = null,Object? unreadCounselor = null,Object? meeting = freezed,Object? helpRequestId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? closedAt = freezed,}) {
  return _then(Conversation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,schoolId: null == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String,studentUid: null == studentUid ? _self.studentUid : studentUid // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,usesAlias: null == usesAlias ? _self.usesAlias : usesAlias // ignore: cast_nullable_to_non_nullable
as bool,identityRevealed: null == identityRevealed ? _self.identityRevealed : identityRevealed // ignore: cast_nullable_to_non_nullable
as bool,counselorUid: freezed == counselorUid ? _self.counselorUid : counselorUid // ignore: cast_nullable_to_non_nullable
as String?,counselorName: freezed == counselorName ? _self.counselorName : counselorName // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ConversationStatus,topic: freezed == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String?,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as LastMessage?,unreadStudent: null == unreadStudent ? _self.unreadStudent : unreadStudent // ignore: cast_nullable_to_non_nullable
as int,unreadCounselor: null == unreadCounselor ? _self.unreadCounselor : unreadCounselor // ignore: cast_nullable_to_non_nullable
as int,meeting: freezed == meeting ? _self.meeting : meeting // ignore: cast_nullable_to_non_nullable
as MeetingPlan?,helpRequestId: freezed == helpRequestId ? _self.helpRequestId : helpRequestId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LastMessageCopyWith<$Res>? get lastMessage {
    if (_self.lastMessage == null) {
    return null;
  }

  return $LastMessageCopyWith<$Res>(_self.lastMessage!, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MeetingPlanCopyWith<$Res>? get meeting {
    if (_self.meeting == null) {
    return null;
  }

  return $MeetingPlanCopyWith<$Res>(_self.meeting!, (value) {
    return _then(_self.copyWith(meeting: value));
  });
}
}


/// Adds pattern-matching-related methods to [Conversation].
extension ConversationPatterns on Conversation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Conversation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Conversation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Conversation value)  $default,){
final _that = this;
switch (_that) {
case _Conversation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Conversation value)?  $default,){
final _that = this;
switch (_that) {
case _Conversation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String schoolId,  String studentUid,  String displayName,  bool usesAlias,  bool identityRevealed,  String? counselorUid,  String? counselorName, @JsonKey(unknownEnumValue: ConversationStatus.menunggu)  ConversationStatus status,  String? topic,  LastMessage? lastMessage,  int unreadStudent,  int unreadCounselor,  MeetingPlan? meeting,  String? helpRequestId, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt, @TimestampConverter()  DateTime? closedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Conversation() when $default != null:
return $default(_that.id,_that.schoolId,_that.studentUid,_that.displayName,_that.usesAlias,_that.identityRevealed,_that.counselorUid,_that.counselorName,_that.status,_that.topic,_that.lastMessage,_that.unreadStudent,_that.unreadCounselor,_that.meeting,_that.helpRequestId,_that.createdAt,_that.updatedAt,_that.closedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String schoolId,  String studentUid,  String displayName,  bool usesAlias,  bool identityRevealed,  String? counselorUid,  String? counselorName, @JsonKey(unknownEnumValue: ConversationStatus.menunggu)  ConversationStatus status,  String? topic,  LastMessage? lastMessage,  int unreadStudent,  int unreadCounselor,  MeetingPlan? meeting,  String? helpRequestId, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt, @TimestampConverter()  DateTime? closedAt)  $default,) {final _that = this;
switch (_that) {
case _Conversation():
return $default(_that.id,_that.schoolId,_that.studentUid,_that.displayName,_that.usesAlias,_that.identityRevealed,_that.counselorUid,_that.counselorName,_that.status,_that.topic,_that.lastMessage,_that.unreadStudent,_that.unreadCounselor,_that.meeting,_that.helpRequestId,_that.createdAt,_that.updatedAt,_that.closedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String schoolId,  String studentUid,  String displayName,  bool usesAlias,  bool identityRevealed,  String? counselorUid,  String? counselorName, @JsonKey(unknownEnumValue: ConversationStatus.menunggu)  ConversationStatus status,  String? topic,  LastMessage? lastMessage,  int unreadStudent,  int unreadCounselor,  MeetingPlan? meeting,  String? helpRequestId, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt, @TimestampConverter()  DateTime? closedAt)?  $default,) {final _that = this;
switch (_that) {
case _Conversation() when $default != null:
return $default(_that.id,_that.schoolId,_that.studentUid,_that.displayName,_that.usesAlias,_that.identityRevealed,_that.counselorUid,_that.counselorName,_that.status,_that.topic,_that.lastMessage,_that.unreadStudent,_that.unreadCounselor,_that.meeting,_that.helpRequestId,_that.createdAt,_that.updatedAt,_that.closedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Conversation extends Conversation {
  const _Conversation({required this.id, this.schoolId = '', this.studentUid = '', this.displayName = '', this.usesAlias = false, this.identityRevealed = false, this.counselorUid, this.counselorName, @JsonKey(unknownEnumValue: ConversationStatus.menunggu) this.status = ConversationStatus.menunggu, this.topic, this.lastMessage, this.unreadStudent = 0, this.unreadCounselor = 0, this.meeting, this.helpRequestId, @TimestampConverter() this.createdAt, @TimestampConverter() this.updatedAt, @TimestampConverter() this.closedAt}): super._();
  factory _Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);

@override final  String id;
@override@JsonKey() final  String schoolId;
@override@JsonKey() final  String studentUid;
@override@JsonKey() final  String displayName;
@override@JsonKey() final  bool usesAlias;
@override@JsonKey() final  bool identityRevealed;
@override final  String? counselorUid;
@override final  String? counselorName;
@override@JsonKey(unknownEnumValue: ConversationStatus.menunggu) final  ConversationStatus status;
@override final  String? topic;
@override final  LastMessage? lastMessage;
@override@JsonKey() final  int unreadStudent;
@override@JsonKey() final  int unreadCounselor;
@override final  MeetingPlan? meeting;
@override final  String? helpRequestId;
@override@TimestampConverter() final  DateTime? createdAt;
@override@TimestampConverter() final  DateTime? updatedAt;
@override@TimestampConverter() final  DateTime? closedAt;

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationCopyWith<_Conversation> get copyWith => __$ConversationCopyWithImpl<_Conversation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConversationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Conversation&&(identical(other.id, id) || other.id == id)&&(identical(other.schoolId, schoolId) || other.schoolId == schoolId)&&(identical(other.studentUid, studentUid) || other.studentUid == studentUid)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.usesAlias, usesAlias) || other.usesAlias == usesAlias)&&(identical(other.identityRevealed, identityRevealed) || other.identityRevealed == identityRevealed)&&(identical(other.counselorUid, counselorUid) || other.counselorUid == counselorUid)&&(identical(other.counselorName, counselorName) || other.counselorName == counselorName)&&(identical(other.status, status) || other.status == status)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.unreadStudent, unreadStudent) || other.unreadStudent == unreadStudent)&&(identical(other.unreadCounselor, unreadCounselor) || other.unreadCounselor == unreadCounselor)&&(identical(other.meeting, meeting) || other.meeting == meeting)&&(identical(other.helpRequestId, helpRequestId) || other.helpRequestId == helpRequestId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,schoolId,studentUid,displayName,usesAlias,identityRevealed,counselorUid,counselorName,status,topic,lastMessage,unreadStudent,unreadCounselor,meeting,helpRequestId,createdAt,updatedAt,closedAt);
}

@override
String toString() {
    return 'Conversation(id: $id, schoolId: $schoolId, studentUid: $studentUid, displayName: $displayName, usesAlias: $usesAlias, identityRevealed: $identityRevealed, counselorUid: $counselorUid, counselorName: $counselorName, status: $status, topic: $topic, lastMessage: $lastMessage, unreadStudent: $unreadStudent, unreadCounselor: $unreadCounselor, meeting: $meeting, helpRequestId: $helpRequestId, createdAt: $createdAt, updatedAt: $updatedAt, closedAt: $closedAt)';
}


}

/// @nodoc
abstract mixin class _$ConversationCopyWith<$Res> implements $ConversationCopyWith<$Res> {
  factory _$ConversationCopyWith(_Conversation value, $Res Function(_Conversation) _then) = __$ConversationCopyWithImpl;
@override @useResult
$Res call({
 String id, String schoolId, String studentUid, String displayName, bool usesAlias, bool identityRevealed, String? counselorUid, String? counselorName,@JsonKey(unknownEnumValue: ConversationStatus.menunggu) ConversationStatus status, String? topic, LastMessage? lastMessage, int unreadStudent, int unreadCounselor, MeetingPlan? meeting, String? helpRequestId,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt,@TimestampConverter() DateTime? closedAt
});


@override $LastMessageCopyWith<$Res>? get lastMessage;@override $MeetingPlanCopyWith<$Res>? get meeting;

}
/// @nodoc
class __$ConversationCopyWithImpl<$Res>
    implements _$ConversationCopyWith<$Res> {
  __$ConversationCopyWithImpl(this._self, this._then);

  final _Conversation _self;
  final $Res Function(_Conversation) _then;

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? schoolId = null,Object? studentUid = null,Object? displayName = null,Object? usesAlias = null,Object? identityRevealed = null,Object? counselorUid = freezed,Object? counselorName = freezed,Object? status = null,Object? topic = freezed,Object? lastMessage = freezed,Object? unreadStudent = null,Object? unreadCounselor = null,Object? meeting = freezed,Object? helpRequestId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? closedAt = freezed,}) {
  return _then(_Conversation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,schoolId: null == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String,studentUid: null == studentUid ? _self.studentUid : studentUid // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,usesAlias: null == usesAlias ? _self.usesAlias : usesAlias // ignore: cast_nullable_to_non_nullable
as bool,identityRevealed: null == identityRevealed ? _self.identityRevealed : identityRevealed // ignore: cast_nullable_to_non_nullable
as bool,counselorUid: freezed == counselorUid ? _self.counselorUid : counselorUid // ignore: cast_nullable_to_non_nullable
as String?,counselorName: freezed == counselorName ? _self.counselorName : counselorName // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ConversationStatus,topic: freezed == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String?,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as LastMessage?,unreadStudent: null == unreadStudent ? _self.unreadStudent : unreadStudent // ignore: cast_nullable_to_non_nullable
as int,unreadCounselor: null == unreadCounselor ? _self.unreadCounselor : unreadCounselor // ignore: cast_nullable_to_non_nullable
as int,meeting: freezed == meeting ? _self.meeting : meeting // ignore: cast_nullable_to_non_nullable
as MeetingPlan?,helpRequestId: freezed == helpRequestId ? _self.helpRequestId : helpRequestId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LastMessageCopyWith<$Res>? get lastMessage {
    if (_self.lastMessage == null) {
    return null;
  }

  return $LastMessageCopyWith<$Res>(_self.lastMessage!, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MeetingPlanCopyWith<$Res>? get meeting {
    if (_self.meeting == null) {
    return null;
  }

  return $MeetingPlanCopyWith<$Res>(_self.meeting!, (value) {
    return _then(_self.copyWith(meeting: value));
  });
}
}


/// @nodoc
mixin _$ChatMessage {

 String get id; String? get senderUid;@JsonKey(unknownEnumValue: MessageRole.sistem) MessageRole get senderRole; String get text; String? get imagePath;@TimestampConverter() DateTime? get createdAt;
/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageCopyWith<ChatMessage> get copyWith => _$ChatMessageCopyWithImpl<ChatMessage>(this as ChatMessage, _$identity);

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatMessage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessage&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.senderUid, _this.senderUid) || other.senderUid == _this.senderUid)&&(identical(other.senderRole, _this.senderRole) || other.senderRole == _this.senderRole)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.imagePath, _this.imagePath) || other.imagePath == _this.imagePath)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatMessage;
  return Object.hash(runtimeType,_this.id,_this.senderUid,_this.senderRole,_this.text,_this.imagePath,_this.createdAt);
}

@override
String toString() {
  final _this = this as ChatMessage;
  return 'ChatMessage(id: ${_this.id}, senderUid: ${_this.senderUid}, senderRole: ${_this.senderRole}, text: ${_this.text}, imagePath: ${_this.imagePath}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $ChatMessageCopyWith<$Res>  {
  factory $ChatMessageCopyWith(ChatMessage value, $Res Function(ChatMessage) _then) = _$ChatMessageCopyWithImpl;
@useResult
$Res call({
 String id, String? senderUid,@JsonKey(unknownEnumValue: MessageRole.sistem) MessageRole senderRole, String text, String? imagePath,@TimestampConverter() DateTime? createdAt
});




}
/// @nodoc
class _$ChatMessageCopyWithImpl<$Res>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._self, this._then);

  final ChatMessage _self;
  final $Res Function(ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? senderUid = freezed,Object? senderRole = null,Object? text = null,Object? imagePath = freezed,Object? createdAt = freezed,}) {
  return _then(ChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderUid: freezed == senderUid ? _self.senderUid : senderUid // ignore: cast_nullable_to_non_nullable
as String?,senderRole: null == senderRole ? _self.senderRole : senderRole // ignore: cast_nullable_to_non_nullable
as MessageRole,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessage].
extension ChatMessagePatterns on ChatMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessage value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? senderUid, @JsonKey(unknownEnumValue: MessageRole.sistem)  MessageRole senderRole,  String text,  String? imagePath, @TimestampConverter()  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.senderUid,_that.senderRole,_that.text,_that.imagePath,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? senderUid, @JsonKey(unknownEnumValue: MessageRole.sistem)  MessageRole senderRole,  String text,  String? imagePath, @TimestampConverter()  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ChatMessage():
return $default(_that.id,_that.senderUid,_that.senderRole,_that.text,_that.imagePath,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? senderUid, @JsonKey(unknownEnumValue: MessageRole.sistem)  MessageRole senderRole,  String text,  String? imagePath, @TimestampConverter()  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.senderUid,_that.senderRole,_that.text,_that.imagePath,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMessage extends ChatMessage {
  const _ChatMessage({required this.id, this.senderUid, @JsonKey(unknownEnumValue: MessageRole.sistem) this.senderRole = MessageRole.sistem, this.text = '', this.imagePath, @TimestampConverter() this.createdAt}): super._();
  factory _ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);

@override final  String id;
@override final  String? senderUid;
@override@JsonKey(unknownEnumValue: MessageRole.sistem) final  MessageRole senderRole;
@override@JsonKey() final  String text;
@override final  String? imagePath;
@override@TimestampConverter() final  DateTime? createdAt;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageCopyWith<_ChatMessage> get copyWith => __$ChatMessageCopyWithImpl<_ChatMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.senderUid, senderUid) || other.senderUid == senderUid)&&(identical(other.senderRole, senderRole) || other.senderRole == senderRole)&&(identical(other.text, text) || other.text == text)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,senderUid,senderRole,text,imagePath,createdAt);
}

@override
String toString() {
    return 'ChatMessage(id: $id, senderUid: $senderUid, senderRole: $senderRole, text: $text, imagePath: $imagePath, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageCopyWith(_ChatMessage value, $Res Function(_ChatMessage) _then) = __$ChatMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String? senderUid,@JsonKey(unknownEnumValue: MessageRole.sistem) MessageRole senderRole, String text, String? imagePath,@TimestampConverter() DateTime? createdAt
});




}
/// @nodoc
class __$ChatMessageCopyWithImpl<$Res>
    implements _$ChatMessageCopyWith<$Res> {
  __$ChatMessageCopyWithImpl(this._self, this._then);

  final _ChatMessage _self;
  final $Res Function(_ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? senderUid = freezed,Object? senderRole = null,Object? text = null,Object? imagePath = freezed,Object? createdAt = freezed,}) {
  return _then(_ChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderUid: freezed == senderUid ? _self.senderUid : senderUid // ignore: cast_nullable_to_non_nullable
as String?,senderRole: null == senderRole ? _self.senderRole : senderRole // ignore: cast_nullable_to_non_nullable
as MessageRole,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$CaseNote {

 String get id; String get text; String get riskLevel; String get authorName;@TimestampConverter() DateTime? get createdAt;
/// Create a copy of CaseNote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CaseNoteCopyWith<CaseNote> get copyWith => _$CaseNoteCopyWithImpl<CaseNote>(this as CaseNote, _$identity);

  /// Serializes this CaseNote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CaseNote;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CaseNote&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.riskLevel, _this.riskLevel) || other.riskLevel == _this.riskLevel)&&(identical(other.authorName, _this.authorName) || other.authorName == _this.authorName)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CaseNote;
  return Object.hash(runtimeType,_this.id,_this.text,_this.riskLevel,_this.authorName,_this.createdAt);
}

@override
String toString() {
  final _this = this as CaseNote;
  return 'CaseNote(id: ${_this.id}, text: ${_this.text}, riskLevel: ${_this.riskLevel}, authorName: ${_this.authorName}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $CaseNoteCopyWith<$Res>  {
  factory $CaseNoteCopyWith(CaseNote value, $Res Function(CaseNote) _then) = _$CaseNoteCopyWithImpl;
@useResult
$Res call({
 String id, String text, String riskLevel, String authorName,@TimestampConverter() DateTime? createdAt
});




}
/// @nodoc
class _$CaseNoteCopyWithImpl<$Res>
    implements $CaseNoteCopyWith<$Res> {
  _$CaseNoteCopyWithImpl(this._self, this._then);

  final CaseNote _self;
  final $Res Function(CaseNote) _then;

/// Create a copy of CaseNote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? riskLevel = null,Object? authorName = null,Object? createdAt = freezed,}) {
  return _then(CaseNote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CaseNote].
extension CaseNotePatterns on CaseNote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CaseNote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CaseNote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CaseNote value)  $default,){
final _that = this;
switch (_that) {
case _CaseNote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CaseNote value)?  $default,){
final _that = this;
switch (_that) {
case _CaseNote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  String riskLevel,  String authorName, @TimestampConverter()  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CaseNote() when $default != null:
return $default(_that.id,_that.text,_that.riskLevel,_that.authorName,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  String riskLevel,  String authorName, @TimestampConverter()  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _CaseNote():
return $default(_that.id,_that.text,_that.riskLevel,_that.authorName,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  String riskLevel,  String authorName, @TimestampConverter()  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CaseNote() when $default != null:
return $default(_that.id,_that.text,_that.riskLevel,_that.authorName,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CaseNote implements CaseNote {
  const _CaseNote({required this.id, this.text = '', this.riskLevel = 'tidak_ada', this.authorName = '', @TimestampConverter() this.createdAt});
  factory _CaseNote.fromJson(Map<String, dynamic> json) => _$CaseNoteFromJson(json);

@override final  String id;
@override@JsonKey() final  String text;
@override@JsonKey() final  String riskLevel;
@override@JsonKey() final  String authorName;
@override@TimestampConverter() final  DateTime? createdAt;

/// Create a copy of CaseNote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CaseNoteCopyWith<_CaseNote> get copyWith => __$CaseNoteCopyWithImpl<_CaseNote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CaseNoteToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CaseNote&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,text,riskLevel,authorName,createdAt);
}

@override
String toString() {
    return 'CaseNote(id: $id, text: $text, riskLevel: $riskLevel, authorName: $authorName, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CaseNoteCopyWith<$Res> implements $CaseNoteCopyWith<$Res> {
  factory _$CaseNoteCopyWith(_CaseNote value, $Res Function(_CaseNote) _then) = __$CaseNoteCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, String riskLevel, String authorName,@TimestampConverter() DateTime? createdAt
});




}
/// @nodoc
class __$CaseNoteCopyWithImpl<$Res>
    implements _$CaseNoteCopyWith<$Res> {
  __$CaseNoteCopyWithImpl(this._self, this._then);

  final _CaseNote _self;
  final $Res Function(_CaseNote) _then;

/// Create a copy of CaseNote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? riskLevel = null,Object? authorName = null,Object? createdAt = freezed,}) {
  return _then(_CaseNote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
