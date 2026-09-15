// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'school_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SchoolStats {

 int get months; String get from; TicketStats get tickets; AspirationStats get aspirations; CareStats get care; MemberStats get members; String get updatedAt;
/// Create a copy of SchoolStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SchoolStatsCopyWith<SchoolStats> get copyWith => _$SchoolStatsCopyWithImpl<SchoolStats>(this as SchoolStats, _$identity);

  /// Serializes this SchoolStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SchoolStats;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SchoolStats&&(identical(other.months, _this.months) || other.months == _this.months)&&(identical(other.from, _this.from) || other.from == _this.from)&&(identical(other.tickets, _this.tickets) || other.tickets == _this.tickets)&&(identical(other.aspirations, _this.aspirations) || other.aspirations == _this.aspirations)&&(identical(other.care, _this.care) || other.care == _this.care)&&(identical(other.members, _this.members) || other.members == _this.members)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SchoolStats;
  return Object.hash(runtimeType,_this.months,_this.from,_this.tickets,_this.aspirations,_this.care,_this.members,_this.updatedAt);
}

@override
String toString() {
  final _this = this as SchoolStats;
  return 'SchoolStats(months: ${_this.months}, from: ${_this.from}, tickets: ${_this.tickets}, aspirations: ${_this.aspirations}, care: ${_this.care}, members: ${_this.members}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $SchoolStatsCopyWith<$Res>  {
  factory $SchoolStatsCopyWith(SchoolStats value, $Res Function(SchoolStats) _then) = _$SchoolStatsCopyWithImpl;
@useResult
$Res call({
 int months, String from, TicketStats tickets, AspirationStats aspirations, CareStats care, MemberStats members, String updatedAt
});


$TicketStatsCopyWith<$Res> get tickets;$AspirationStatsCopyWith<$Res> get aspirations;$CareStatsCopyWith<$Res> get care;$MemberStatsCopyWith<$Res> get members;

}
/// @nodoc
class _$SchoolStatsCopyWithImpl<$Res>
    implements $SchoolStatsCopyWith<$Res> {
  _$SchoolStatsCopyWithImpl(this._self, this._then);

  final SchoolStats _self;
  final $Res Function(SchoolStats) _then;

/// Create a copy of SchoolStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? months = null,Object? from = null,Object? tickets = null,Object? aspirations = null,Object? care = null,Object? members = null,Object? updatedAt = null,}) {
  return _then(SchoolStats(
months: null == months ? _self.months : months // ignore: cast_nullable_to_non_nullable
as int,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,tickets: null == tickets ? _self.tickets : tickets // ignore: cast_nullable_to_non_nullable
as TicketStats,aspirations: null == aspirations ? _self.aspirations : aspirations // ignore: cast_nullable_to_non_nullable
as AspirationStats,care: null == care ? _self.care : care // ignore: cast_nullable_to_non_nullable
as CareStats,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as MemberStats,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of SchoolStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketStatsCopyWith<$Res> get tickets {
  
  return $TicketStatsCopyWith<$Res>(_self.tickets, (value) {
    return _then(_self.copyWith(tickets: value));
  });
}/// Create a copy of SchoolStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AspirationStatsCopyWith<$Res> get aspirations {
  
  return $AspirationStatsCopyWith<$Res>(_self.aspirations, (value) {
    return _then(_self.copyWith(aspirations: value));
  });
}/// Create a copy of SchoolStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CareStatsCopyWith<$Res> get care {
  
  return $CareStatsCopyWith<$Res>(_self.care, (value) {
    return _then(_self.copyWith(care: value));
  });
}/// Create a copy of SchoolStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberStatsCopyWith<$Res> get members {
  
  return $MemberStatsCopyWith<$Res>(_self.members, (value) {
    return _then(_self.copyWith(members: value));
  });
}
}


/// Adds pattern-matching-related methods to [SchoolStats].
extension SchoolStatsPatterns on SchoolStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SchoolStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SchoolStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SchoolStats value)  $default,){
final _that = this;
switch (_that) {
case _SchoolStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SchoolStats value)?  $default,){
final _that = this;
switch (_that) {
case _SchoolStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int months,  String from,  TicketStats tickets,  AspirationStats aspirations,  CareStats care,  MemberStats members,  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SchoolStats() when $default != null:
return $default(_that.months,_that.from,_that.tickets,_that.aspirations,_that.care,_that.members,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int months,  String from,  TicketStats tickets,  AspirationStats aspirations,  CareStats care,  MemberStats members,  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SchoolStats():
return $default(_that.months,_that.from,_that.tickets,_that.aspirations,_that.care,_that.members,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int months,  String from,  TicketStats tickets,  AspirationStats aspirations,  CareStats care,  MemberStats members,  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SchoolStats() when $default != null:
return $default(_that.months,_that.from,_that.tickets,_that.aspirations,_that.care,_that.members,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SchoolStats extends SchoolStats {
  const _SchoolStats({this.months = 6, this.from = '', this.tickets = const TicketStats(), this.aspirations = const AspirationStats(), this.care = const CareStats(), this.members = const MemberStats(), this.updatedAt = ''}): super._();
  factory _SchoolStats.fromJson(Map<String, dynamic> json) => _$SchoolStatsFromJson(json);

@override@JsonKey() final  int months;
@override@JsonKey() final  String from;
@override@JsonKey() final  TicketStats tickets;
@override@JsonKey() final  AspirationStats aspirations;
@override@JsonKey() final  CareStats care;
@override@JsonKey() final  MemberStats members;
@override@JsonKey() final  String updatedAt;

/// Create a copy of SchoolStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SchoolStatsCopyWith<_SchoolStats> get copyWith => __$SchoolStatsCopyWithImpl<_SchoolStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SchoolStatsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SchoolStats&&(identical(other.months, months) || other.months == months)&&(identical(other.from, from) || other.from == from)&&(identical(other.tickets, tickets) || other.tickets == tickets)&&(identical(other.aspirations, aspirations) || other.aspirations == aspirations)&&(identical(other.care, care) || other.care == care)&&(identical(other.members, members) || other.members == members)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,months,from,tickets,aspirations,care,members,updatedAt);
}

@override
String toString() {
    return 'SchoolStats(months: $months, from: $from, tickets: $tickets, aspirations: $aspirations, care: $care, members: $members, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SchoolStatsCopyWith<$Res> implements $SchoolStatsCopyWith<$Res> {
  factory _$SchoolStatsCopyWith(_SchoolStats value, $Res Function(_SchoolStats) _then) = __$SchoolStatsCopyWithImpl;
@override @useResult
$Res call({
 int months, String from, TicketStats tickets, AspirationStats aspirations, CareStats care, MemberStats members, String updatedAt
});


@override $TicketStatsCopyWith<$Res> get tickets;@override $AspirationStatsCopyWith<$Res> get aspirations;@override $CareStatsCopyWith<$Res> get care;@override $MemberStatsCopyWith<$Res> get members;

}
/// @nodoc
class __$SchoolStatsCopyWithImpl<$Res>
    implements _$SchoolStatsCopyWith<$Res> {
  __$SchoolStatsCopyWithImpl(this._self, this._then);

  final _SchoolStats _self;
  final $Res Function(_SchoolStats) _then;

/// Create a copy of SchoolStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? months = null,Object? from = null,Object? tickets = null,Object? aspirations = null,Object? care = null,Object? members = null,Object? updatedAt = null,}) {
  return _then(_SchoolStats(
months: null == months ? _self.months : months // ignore: cast_nullable_to_non_nullable
as int,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,tickets: null == tickets ? _self.tickets : tickets // ignore: cast_nullable_to_non_nullable
as TicketStats,aspirations: null == aspirations ? _self.aspirations : aspirations // ignore: cast_nullable_to_non_nullable
as AspirationStats,care: null == care ? _self.care : care // ignore: cast_nullable_to_non_nullable
as CareStats,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as MemberStats,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of SchoolStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketStatsCopyWith<$Res> get tickets {
  
  return $TicketStatsCopyWith<$Res>(_self.tickets, (value) {
    return _then(_self.copyWith(tickets: value));
  });
}/// Create a copy of SchoolStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AspirationStatsCopyWith<$Res> get aspirations {
  
  return $AspirationStatsCopyWith<$Res>(_self.aspirations, (value) {
    return _then(_self.copyWith(aspirations: value));
  });
}/// Create a copy of SchoolStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CareStatsCopyWith<$Res> get care {
  
  return $CareStatsCopyWith<$Res>(_self.care, (value) {
    return _then(_self.copyWith(care: value));
  });
}/// Create a copy of SchoolStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberStatsCopyWith<$Res> get members {
  
  return $MemberStatsCopyWith<$Res>(_self.members, (value) {
    return _then(_self.copyWith(members: value));
  });
}
}


/// @nodoc
mixin _$TicketStats {

 int get total; Map<String, int> get byStatus; Map<String, int> get byCategory; Map<String, int> get byPriority; int get overdue; double? get avgVerifyHours; double? get avgResolveHours; double? get avgRating; int get ratingCount; List<LocationCount> get topLocations; List<MonthlyCount> get monthly; List<UnitPerformance> get units;
/// Create a copy of TicketStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketStatsCopyWith<TicketStats> get copyWith => _$TicketStatsCopyWithImpl<TicketStats>(this as TicketStats, _$identity);

  /// Serializes this TicketStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketStats;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketStats&&(identical(other.total, _this.total) || other.total == _this.total)&&const DeepCollectionEquality().equals(other.byStatus, _this.byStatus)&&const DeepCollectionEquality().equals(other.byCategory, _this.byCategory)&&const DeepCollectionEquality().equals(other.byPriority, _this.byPriority)&&(identical(other.overdue, _this.overdue) || other.overdue == _this.overdue)&&(identical(other.avgVerifyHours, _this.avgVerifyHours) || other.avgVerifyHours == _this.avgVerifyHours)&&(identical(other.avgResolveHours, _this.avgResolveHours) || other.avgResolveHours == _this.avgResolveHours)&&(identical(other.avgRating, _this.avgRating) || other.avgRating == _this.avgRating)&&(identical(other.ratingCount, _this.ratingCount) || other.ratingCount == _this.ratingCount)&&const DeepCollectionEquality().equals(other.topLocations, _this.topLocations)&&const DeepCollectionEquality().equals(other.monthly, _this.monthly)&&const DeepCollectionEquality().equals(other.units, _this.units));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketStats;
  return Object.hash(runtimeType,_this.total,const DeepCollectionEquality().hash(_this.byStatus),const DeepCollectionEquality().hash(_this.byCategory),const DeepCollectionEquality().hash(_this.byPriority),_this.overdue,_this.avgVerifyHours,_this.avgResolveHours,_this.avgRating,_this.ratingCount,const DeepCollectionEquality().hash(_this.topLocations),const DeepCollectionEquality().hash(_this.monthly),const DeepCollectionEquality().hash(_this.units));
}

@override
String toString() {
  final _this = this as TicketStats;
  return 'TicketStats(total: ${_this.total}, byStatus: ${_this.byStatus}, byCategory: ${_this.byCategory}, byPriority: ${_this.byPriority}, overdue: ${_this.overdue}, avgVerifyHours: ${_this.avgVerifyHours}, avgResolveHours: ${_this.avgResolveHours}, avgRating: ${_this.avgRating}, ratingCount: ${_this.ratingCount}, topLocations: ${_this.topLocations}, monthly: ${_this.monthly}, units: ${_this.units})';
}


}

/// @nodoc
abstract mixin class $TicketStatsCopyWith<$Res>  {
  factory $TicketStatsCopyWith(TicketStats value, $Res Function(TicketStats) _then) = _$TicketStatsCopyWithImpl;
@useResult
$Res call({
 int total, Map<String, int> byStatus, Map<String, int> byCategory, Map<String, int> byPriority, int overdue, double? avgVerifyHours, double? avgResolveHours, double? avgRating, int ratingCount, List<LocationCount> topLocations, List<MonthlyCount> monthly, List<UnitPerformance> units
});




}
/// @nodoc
class _$TicketStatsCopyWithImpl<$Res>
    implements $TicketStatsCopyWith<$Res> {
  _$TicketStatsCopyWithImpl(this._self, this._then);

  final TicketStats _self;
  final $Res Function(TicketStats) _then;

/// Create a copy of TicketStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? byStatus = null,Object? byCategory = null,Object? byPriority = null,Object? overdue = null,Object? avgVerifyHours = freezed,Object? avgResolveHours = freezed,Object? avgRating = freezed,Object? ratingCount = null,Object? topLocations = null,Object? monthly = null,Object? units = null,}) {
  return _then(TicketStats(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,byStatus: null == byStatus ? _self.byStatus : byStatus // ignore: cast_nullable_to_non_nullable
as Map<String, int>,byCategory: null == byCategory ? _self.byCategory : byCategory // ignore: cast_nullable_to_non_nullable
as Map<String, int>,byPriority: null == byPriority ? _self.byPriority : byPriority // ignore: cast_nullable_to_non_nullable
as Map<String, int>,overdue: null == overdue ? _self.overdue : overdue // ignore: cast_nullable_to_non_nullable
as int,avgVerifyHours: freezed == avgVerifyHours ? _self.avgVerifyHours : avgVerifyHours // ignore: cast_nullable_to_non_nullable
as double?,avgResolveHours: freezed == avgResolveHours ? _self.avgResolveHours : avgResolveHours // ignore: cast_nullable_to_non_nullable
as double?,avgRating: freezed == avgRating ? _self.avgRating : avgRating // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,topLocations: null == topLocations ? _self.topLocations : topLocations // ignore: cast_nullable_to_non_nullable
as List<LocationCount>,monthly: null == monthly ? _self.monthly : monthly // ignore: cast_nullable_to_non_nullable
as List<MonthlyCount>,units: null == units ? _self.units : units // ignore: cast_nullable_to_non_nullable
as List<UnitPerformance>,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketStats].
extension TicketStatsPatterns on TicketStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketStats value)  $default,){
final _that = this;
switch (_that) {
case _TicketStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketStats value)?  $default,){
final _that = this;
switch (_that) {
case _TicketStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int total,  Map<String, int> byStatus,  Map<String, int> byCategory,  Map<String, int> byPriority,  int overdue,  double? avgVerifyHours,  double? avgResolveHours,  double? avgRating,  int ratingCount,  List<LocationCount> topLocations,  List<MonthlyCount> monthly,  List<UnitPerformance> units)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketStats() when $default != null:
return $default(_that.total,_that.byStatus,_that.byCategory,_that.byPriority,_that.overdue,_that.avgVerifyHours,_that.avgResolveHours,_that.avgRating,_that.ratingCount,_that.topLocations,_that.monthly,_that.units);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int total,  Map<String, int> byStatus,  Map<String, int> byCategory,  Map<String, int> byPriority,  int overdue,  double? avgVerifyHours,  double? avgResolveHours,  double? avgRating,  int ratingCount,  List<LocationCount> topLocations,  List<MonthlyCount> monthly,  List<UnitPerformance> units)  $default,) {final _that = this;
switch (_that) {
case _TicketStats():
return $default(_that.total,_that.byStatus,_that.byCategory,_that.byPriority,_that.overdue,_that.avgVerifyHours,_that.avgResolveHours,_that.avgRating,_that.ratingCount,_that.topLocations,_that.monthly,_that.units);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int total,  Map<String, int> byStatus,  Map<String, int> byCategory,  Map<String, int> byPriority,  int overdue,  double? avgVerifyHours,  double? avgResolveHours,  double? avgRating,  int ratingCount,  List<LocationCount> topLocations,  List<MonthlyCount> monthly,  List<UnitPerformance> units)?  $default,) {final _that = this;
switch (_that) {
case _TicketStats() when $default != null:
return $default(_that.total,_that.byStatus,_that.byCategory,_that.byPriority,_that.overdue,_that.avgVerifyHours,_that.avgResolveHours,_that.avgRating,_that.ratingCount,_that.topLocations,_that.monthly,_that.units);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketStats extends TicketStats {
  const _TicketStats({this.total = 0,  Map<String, int> byStatus = const <String, int>{},  Map<String, int> byCategory = const <String, int>{},  Map<String, int> byPriority = const <String, int>{}, this.overdue = 0, this.avgVerifyHours, this.avgResolveHours, this.avgRating, this.ratingCount = 0,  List<LocationCount> topLocations = const <LocationCount>[],  List<MonthlyCount> monthly = const <MonthlyCount>[],  List<UnitPerformance> units = const <UnitPerformance>[]}): _byStatus = byStatus,_byCategory = byCategory,_byPriority = byPriority,_topLocations = topLocations,_monthly = monthly,_units = units,super._();
  factory _TicketStats.fromJson(Map<String, dynamic> json) => _$TicketStatsFromJson(json);

@override@JsonKey() final  int total;
 final  Map<String, int> _byStatus;
@override@JsonKey() Map<String, int> get byStatus {
  if (_byStatus is EqualUnmodifiableMapView) return _byStatus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byStatus);
}

 final  Map<String, int> _byCategory;
@override@JsonKey() Map<String, int> get byCategory {
  if (_byCategory is EqualUnmodifiableMapView) return _byCategory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byCategory);
}

 final  Map<String, int> _byPriority;
@override@JsonKey() Map<String, int> get byPriority {
  if (_byPriority is EqualUnmodifiableMapView) return _byPriority;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byPriority);
}

@override@JsonKey() final  int overdue;
@override final  double? avgVerifyHours;
@override final  double? avgResolveHours;
@override final  double? avgRating;
@override@JsonKey() final  int ratingCount;
 final  List<LocationCount> _topLocations;
@override@JsonKey() List<LocationCount> get topLocations {
  if (_topLocations is EqualUnmodifiableListView) return _topLocations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topLocations);
}

 final  List<MonthlyCount> _monthly;
@override@JsonKey() List<MonthlyCount> get monthly {
  if (_monthly is EqualUnmodifiableListView) return _monthly;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_monthly);
}

 final  List<UnitPerformance> _units;
@override@JsonKey() List<UnitPerformance> get units {
  if (_units is EqualUnmodifiableListView) return _units;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_units);
}


/// Create a copy of TicketStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketStatsCopyWith<_TicketStats> get copyWith => __$TicketStatsCopyWithImpl<_TicketStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketStatsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketStats&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.byStatus, _byStatus)&&const DeepCollectionEquality().equals(other.byCategory, _byCategory)&&const DeepCollectionEquality().equals(other.byPriority, _byPriority)&&(identical(other.overdue, overdue) || other.overdue == overdue)&&(identical(other.avgVerifyHours, avgVerifyHours) || other.avgVerifyHours == avgVerifyHours)&&(identical(other.avgResolveHours, avgResolveHours) || other.avgResolveHours == avgResolveHours)&&(identical(other.avgRating, avgRating) || other.avgRating == avgRating)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&const DeepCollectionEquality().equals(other.topLocations, _topLocations)&&const DeepCollectionEquality().equals(other.monthly, _monthly)&&const DeepCollectionEquality().equals(other.units, _units));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,total,const DeepCollectionEquality().hash(_byStatus),const DeepCollectionEquality().hash(_byCategory),const DeepCollectionEquality().hash(_byPriority),overdue,avgVerifyHours,avgResolveHours,avgRating,ratingCount,const DeepCollectionEquality().hash(_topLocations),const DeepCollectionEquality().hash(_monthly),const DeepCollectionEquality().hash(_units));
}

@override
String toString() {
    return 'TicketStats(total: $total, byStatus: $byStatus, byCategory: $byCategory, byPriority: $byPriority, overdue: $overdue, avgVerifyHours: $avgVerifyHours, avgResolveHours: $avgResolveHours, avgRating: $avgRating, ratingCount: $ratingCount, topLocations: $topLocations, monthly: $monthly, units: $units)';
}


}

/// @nodoc
abstract mixin class _$TicketStatsCopyWith<$Res> implements $TicketStatsCopyWith<$Res> {
  factory _$TicketStatsCopyWith(_TicketStats value, $Res Function(_TicketStats) _then) = __$TicketStatsCopyWithImpl;
@override @useResult
$Res call({
 int total, Map<String, int> byStatus, Map<String, int> byCategory, Map<String, int> byPriority, int overdue, double? avgVerifyHours, double? avgResolveHours, double? avgRating, int ratingCount, List<LocationCount> topLocations, List<MonthlyCount> monthly, List<UnitPerformance> units
});




}
/// @nodoc
class __$TicketStatsCopyWithImpl<$Res>
    implements _$TicketStatsCopyWith<$Res> {
  __$TicketStatsCopyWithImpl(this._self, this._then);

  final _TicketStats _self;
  final $Res Function(_TicketStats) _then;

/// Create a copy of TicketStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? byStatus = null,Object? byCategory = null,Object? byPriority = null,Object? overdue = null,Object? avgVerifyHours = freezed,Object? avgResolveHours = freezed,Object? avgRating = freezed,Object? ratingCount = null,Object? topLocations = null,Object? monthly = null,Object? units = null,}) {
  return _then(_TicketStats(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,byStatus: null == byStatus ? _self._byStatus : byStatus // ignore: cast_nullable_to_non_nullable
as Map<String, int>,byCategory: null == byCategory ? _self._byCategory : byCategory // ignore: cast_nullable_to_non_nullable
as Map<String, int>,byPriority: null == byPriority ? _self._byPriority : byPriority // ignore: cast_nullable_to_non_nullable
as Map<String, int>,overdue: null == overdue ? _self.overdue : overdue // ignore: cast_nullable_to_non_nullable
as int,avgVerifyHours: freezed == avgVerifyHours ? _self.avgVerifyHours : avgVerifyHours // ignore: cast_nullable_to_non_nullable
as double?,avgResolveHours: freezed == avgResolveHours ? _self.avgResolveHours : avgResolveHours // ignore: cast_nullable_to_non_nullable
as double?,avgRating: freezed == avgRating ? _self.avgRating : avgRating // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,topLocations: null == topLocations ? _self._topLocations : topLocations // ignore: cast_nullable_to_non_nullable
as List<LocationCount>,monthly: null == monthly ? _self._monthly : monthly // ignore: cast_nullable_to_non_nullable
as List<MonthlyCount>,units: null == units ? _self._units : units // ignore: cast_nullable_to_non_nullable
as List<UnitPerformance>,
  ));
}


}


/// @nodoc
mixin _$LocationCount {

 String get location; int get count;
/// Create a copy of LocationCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationCountCopyWith<LocationCount> get copyWith => _$LocationCountCopyWithImpl<LocationCount>(this as LocationCount, _$identity);

  /// Serializes this LocationCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LocationCount;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationCount&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.count, _this.count) || other.count == _this.count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LocationCount;
  return Object.hash(runtimeType,_this.location,_this.count);
}

@override
String toString() {
  final _this = this as LocationCount;
  return 'LocationCount(location: ${_this.location}, count: ${_this.count})';
}


}

/// @nodoc
abstract mixin class $LocationCountCopyWith<$Res>  {
  factory $LocationCountCopyWith(LocationCount value, $Res Function(LocationCount) _then) = _$LocationCountCopyWithImpl;
@useResult
$Res call({
 String location, int count
});




}
/// @nodoc
class _$LocationCountCopyWithImpl<$Res>
    implements $LocationCountCopyWith<$Res> {
  _$LocationCountCopyWithImpl(this._self, this._then);

  final LocationCount _self;
  final $Res Function(LocationCount) _then;

/// Create a copy of LocationCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? location = null,Object? count = null,}) {
  return _then(LocationCount(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationCount].
extension LocationCountPatterns on LocationCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationCount value)  $default,){
final _that = this;
switch (_that) {
case _LocationCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationCount value)?  $default,){
final _that = this;
switch (_that) {
case _LocationCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String location,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationCount() when $default != null:
return $default(_that.location,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String location,  int count)  $default,) {final _that = this;
switch (_that) {
case _LocationCount():
return $default(_that.location,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String location,  int count)?  $default,) {final _that = this;
switch (_that) {
case _LocationCount() when $default != null:
return $default(_that.location,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LocationCount implements LocationCount {
  const _LocationCount({this.location = '', this.count = 0});
  factory _LocationCount.fromJson(Map<String, dynamic> json) => _$LocationCountFromJson(json);

@override@JsonKey() final  String location;
@override@JsonKey() final  int count;

/// Create a copy of LocationCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationCountCopyWith<_LocationCount> get copyWith => __$LocationCountCopyWithImpl<_LocationCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocationCountToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationCount&&(identical(other.location, location) || other.location == location)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,location,count);
}

@override
String toString() {
    return 'LocationCount(location: $location, count: $count)';
}


}

/// @nodoc
abstract mixin class _$LocationCountCopyWith<$Res> implements $LocationCountCopyWith<$Res> {
  factory _$LocationCountCopyWith(_LocationCount value, $Res Function(_LocationCount) _then) = __$LocationCountCopyWithImpl;
@override @useResult
$Res call({
 String location, int count
});




}
/// @nodoc
class __$LocationCountCopyWithImpl<$Res>
    implements _$LocationCountCopyWith<$Res> {
  __$LocationCountCopyWithImpl(this._self, this._then);

  final _LocationCount _self;
  final $Res Function(_LocationCount) _then;

/// Create a copy of LocationCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? location = null,Object? count = null,}) {
  return _then(_LocationCount(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MonthlyCount {

 String get month; int get total; int get selesai;
/// Create a copy of MonthlyCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthlyCountCopyWith<MonthlyCount> get copyWith => _$MonthlyCountCopyWithImpl<MonthlyCount>(this as MonthlyCount, _$identity);

  /// Serializes this MonthlyCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MonthlyCount;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthlyCount&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.selesai, _this.selesai) || other.selesai == _this.selesai));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MonthlyCount;
  return Object.hash(runtimeType,_this.month,_this.total,_this.selesai);
}

@override
String toString() {
  final _this = this as MonthlyCount;
  return 'MonthlyCount(month: ${_this.month}, total: ${_this.total}, selesai: ${_this.selesai})';
}


}

/// @nodoc
abstract mixin class $MonthlyCountCopyWith<$Res>  {
  factory $MonthlyCountCopyWith(MonthlyCount value, $Res Function(MonthlyCount) _then) = _$MonthlyCountCopyWithImpl;
@useResult
$Res call({
 String month, int total, int selesai
});




}
/// @nodoc
class _$MonthlyCountCopyWithImpl<$Res>
    implements $MonthlyCountCopyWith<$Res> {
  _$MonthlyCountCopyWithImpl(this._self, this._then);

  final MonthlyCount _self;
  final $Res Function(MonthlyCount) _then;

/// Create a copy of MonthlyCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? total = null,Object? selesai = null,}) {
  return _then(MonthlyCount(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,selesai: null == selesai ? _self.selesai : selesai // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthlyCount].
extension MonthlyCountPatterns on MonthlyCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthlyCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthlyCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthlyCount value)  $default,){
final _that = this;
switch (_that) {
case _MonthlyCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthlyCount value)?  $default,){
final _that = this;
switch (_that) {
case _MonthlyCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String month,  int total,  int selesai)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthlyCount() when $default != null:
return $default(_that.month,_that.total,_that.selesai);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String month,  int total,  int selesai)  $default,) {final _that = this;
switch (_that) {
case _MonthlyCount():
return $default(_that.month,_that.total,_that.selesai);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String month,  int total,  int selesai)?  $default,) {final _that = this;
switch (_that) {
case _MonthlyCount() when $default != null:
return $default(_that.month,_that.total,_that.selesai);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthlyCount implements MonthlyCount {
  const _MonthlyCount({this.month = '', this.total = 0, this.selesai = 0});
  factory _MonthlyCount.fromJson(Map<String, dynamic> json) => _$MonthlyCountFromJson(json);

@override@JsonKey() final  String month;
@override@JsonKey() final  int total;
@override@JsonKey() final  int selesai;

/// Create a copy of MonthlyCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthlyCountCopyWith<_MonthlyCount> get copyWith => __$MonthlyCountCopyWithImpl<_MonthlyCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthlyCountToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthlyCount&&(identical(other.month, month) || other.month == month)&&(identical(other.total, total) || other.total == total)&&(identical(other.selesai, selesai) || other.selesai == selesai));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,month,total,selesai);
}

@override
String toString() {
    return 'MonthlyCount(month: $month, total: $total, selesai: $selesai)';
}


}

/// @nodoc
abstract mixin class _$MonthlyCountCopyWith<$Res> implements $MonthlyCountCopyWith<$Res> {
  factory _$MonthlyCountCopyWith(_MonthlyCount value, $Res Function(_MonthlyCount) _then) = __$MonthlyCountCopyWithImpl;
@override @useResult
$Res call({
 String month, int total, int selesai
});




}
/// @nodoc
class __$MonthlyCountCopyWithImpl<$Res>
    implements _$MonthlyCountCopyWith<$Res> {
  __$MonthlyCountCopyWithImpl(this._self, this._then);

  final _MonthlyCount _self;
  final $Res Function(_MonthlyCount) _then;

/// Create a copy of MonthlyCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? total = null,Object? selesai = null,}) {
  return _then(_MonthlyCount(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,selesai: null == selesai ? _self.selesai : selesai // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$UnitPerformance {

 String get unitId; String get unitName; int get total; int get selesai; double? get avgResolveHours; int? get onTimePercent;
/// Create a copy of UnitPerformance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnitPerformanceCopyWith<UnitPerformance> get copyWith => _$UnitPerformanceCopyWithImpl<UnitPerformance>(this as UnitPerformance, _$identity);

  /// Serializes this UnitPerformance to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UnitPerformance;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnitPerformance&&(identical(other.unitId, _this.unitId) || other.unitId == _this.unitId)&&(identical(other.unitName, _this.unitName) || other.unitName == _this.unitName)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.selesai, _this.selesai) || other.selesai == _this.selesai)&&(identical(other.avgResolveHours, _this.avgResolveHours) || other.avgResolveHours == _this.avgResolveHours)&&(identical(other.onTimePercent, _this.onTimePercent) || other.onTimePercent == _this.onTimePercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UnitPerformance;
  return Object.hash(runtimeType,_this.unitId,_this.unitName,_this.total,_this.selesai,_this.avgResolveHours,_this.onTimePercent);
}

@override
String toString() {
  final _this = this as UnitPerformance;
  return 'UnitPerformance(unitId: ${_this.unitId}, unitName: ${_this.unitName}, total: ${_this.total}, selesai: ${_this.selesai}, avgResolveHours: ${_this.avgResolveHours}, onTimePercent: ${_this.onTimePercent})';
}


}

/// @nodoc
abstract mixin class $UnitPerformanceCopyWith<$Res>  {
  factory $UnitPerformanceCopyWith(UnitPerformance value, $Res Function(UnitPerformance) _then) = _$UnitPerformanceCopyWithImpl;
@useResult
$Res call({
 String unitId, String unitName, int total, int selesai, double? avgResolveHours, int? onTimePercent
});




}
/// @nodoc
class _$UnitPerformanceCopyWithImpl<$Res>
    implements $UnitPerformanceCopyWith<$Res> {
  _$UnitPerformanceCopyWithImpl(this._self, this._then);

  final UnitPerformance _self;
  final $Res Function(UnitPerformance) _then;

/// Create a copy of UnitPerformance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? unitId = null,Object? unitName = null,Object? total = null,Object? selesai = null,Object? avgResolveHours = freezed,Object? onTimePercent = freezed,}) {
  return _then(UnitPerformance(
unitId: null == unitId ? _self.unitId : unitId // ignore: cast_nullable_to_non_nullable
as String,unitName: null == unitName ? _self.unitName : unitName // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,selesai: null == selesai ? _self.selesai : selesai // ignore: cast_nullable_to_non_nullable
as int,avgResolveHours: freezed == avgResolveHours ? _self.avgResolveHours : avgResolveHours // ignore: cast_nullable_to_non_nullable
as double?,onTimePercent: freezed == onTimePercent ? _self.onTimePercent : onTimePercent // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [UnitPerformance].
extension UnitPerformancePatterns on UnitPerformance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnitPerformance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnitPerformance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnitPerformance value)  $default,){
final _that = this;
switch (_that) {
case _UnitPerformance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnitPerformance value)?  $default,){
final _that = this;
switch (_that) {
case _UnitPerformance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String unitId,  String unitName,  int total,  int selesai,  double? avgResolveHours,  int? onTimePercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnitPerformance() when $default != null:
return $default(_that.unitId,_that.unitName,_that.total,_that.selesai,_that.avgResolveHours,_that.onTimePercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String unitId,  String unitName,  int total,  int selesai,  double? avgResolveHours,  int? onTimePercent)  $default,) {final _that = this;
switch (_that) {
case _UnitPerformance():
return $default(_that.unitId,_that.unitName,_that.total,_that.selesai,_that.avgResolveHours,_that.onTimePercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String unitId,  String unitName,  int total,  int selesai,  double? avgResolveHours,  int? onTimePercent)?  $default,) {final _that = this;
switch (_that) {
case _UnitPerformance() when $default != null:
return $default(_that.unitId,_that.unitName,_that.total,_that.selesai,_that.avgResolveHours,_that.onTimePercent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnitPerformance implements UnitPerformance {
  const _UnitPerformance({this.unitId = '', this.unitName = '', this.total = 0, this.selesai = 0, this.avgResolveHours, this.onTimePercent});
  factory _UnitPerformance.fromJson(Map<String, dynamic> json) => _$UnitPerformanceFromJson(json);

@override@JsonKey() final  String unitId;
@override@JsonKey() final  String unitName;
@override@JsonKey() final  int total;
@override@JsonKey() final  int selesai;
@override final  double? avgResolveHours;
@override final  int? onTimePercent;

/// Create a copy of UnitPerformance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnitPerformanceCopyWith<_UnitPerformance> get copyWith => __$UnitPerformanceCopyWithImpl<_UnitPerformance>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnitPerformanceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnitPerformance&&(identical(other.unitId, unitId) || other.unitId == unitId)&&(identical(other.unitName, unitName) || other.unitName == unitName)&&(identical(other.total, total) || other.total == total)&&(identical(other.selesai, selesai) || other.selesai == selesai)&&(identical(other.avgResolveHours, avgResolveHours) || other.avgResolveHours == avgResolveHours)&&(identical(other.onTimePercent, onTimePercent) || other.onTimePercent == onTimePercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,unitId,unitName,total,selesai,avgResolveHours,onTimePercent);
}

@override
String toString() {
    return 'UnitPerformance(unitId: $unitId, unitName: $unitName, total: $total, selesai: $selesai, avgResolveHours: $avgResolveHours, onTimePercent: $onTimePercent)';
}


}

/// @nodoc
abstract mixin class _$UnitPerformanceCopyWith<$Res> implements $UnitPerformanceCopyWith<$Res> {
  factory _$UnitPerformanceCopyWith(_UnitPerformance value, $Res Function(_UnitPerformance) _then) = __$UnitPerformanceCopyWithImpl;
@override @useResult
$Res call({
 String unitId, String unitName, int total, int selesai, double? avgResolveHours, int? onTimePercent
});




}
/// @nodoc
class __$UnitPerformanceCopyWithImpl<$Res>
    implements _$UnitPerformanceCopyWith<$Res> {
  __$UnitPerformanceCopyWithImpl(this._self, this._then);

  final _UnitPerformance _self;
  final $Res Function(_UnitPerformance) _then;

/// Create a copy of UnitPerformance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? unitId = null,Object? unitName = null,Object? total = null,Object? selesai = null,Object? avgResolveHours = freezed,Object? onTimePercent = freezed,}) {
  return _then(_UnitPerformance(
unitId: null == unitId ? _self.unitId : unitId // ignore: cast_nullable_to_non_nullable
as String,unitName: null == unitName ? _self.unitName : unitName // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,selesai: null == selesai ? _self.selesai : selesai // ignore: cast_nullable_to_non_nullable
as int,avgResolveHours: freezed == avgResolveHours ? _self.avgResolveHours : avgResolveHours // ignore: cast_nullable_to_non_nullable
as double?,onTimePercent: freezed == onTimePercent ? _self.onTimePercent : onTimePercent // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$AspirationStats {

 int get total; Map<String, int> get byStatus; Map<String, int> get byTopic; int get published; int get supports;
/// Create a copy of AspirationStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AspirationStatsCopyWith<AspirationStats> get copyWith => _$AspirationStatsCopyWithImpl<AspirationStats>(this as AspirationStats, _$identity);

  /// Serializes this AspirationStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AspirationStats;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AspirationStats&&(identical(other.total, _this.total) || other.total == _this.total)&&const DeepCollectionEquality().equals(other.byStatus, _this.byStatus)&&const DeepCollectionEquality().equals(other.byTopic, _this.byTopic)&&(identical(other.published, _this.published) || other.published == _this.published)&&(identical(other.supports, _this.supports) || other.supports == _this.supports));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AspirationStats;
  return Object.hash(runtimeType,_this.total,const DeepCollectionEquality().hash(_this.byStatus),const DeepCollectionEquality().hash(_this.byTopic),_this.published,_this.supports);
}

@override
String toString() {
  final _this = this as AspirationStats;
  return 'AspirationStats(total: ${_this.total}, byStatus: ${_this.byStatus}, byTopic: ${_this.byTopic}, published: ${_this.published}, supports: ${_this.supports})';
}


}

/// @nodoc
abstract mixin class $AspirationStatsCopyWith<$Res>  {
  factory $AspirationStatsCopyWith(AspirationStats value, $Res Function(AspirationStats) _then) = _$AspirationStatsCopyWithImpl;
@useResult
$Res call({
 int total, Map<String, int> byStatus, Map<String, int> byTopic, int published, int supports
});




}
/// @nodoc
class _$AspirationStatsCopyWithImpl<$Res>
    implements $AspirationStatsCopyWith<$Res> {
  _$AspirationStatsCopyWithImpl(this._self, this._then);

  final AspirationStats _self;
  final $Res Function(AspirationStats) _then;

/// Create a copy of AspirationStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? byStatus = null,Object? byTopic = null,Object? published = null,Object? supports = null,}) {
  return _then(AspirationStats(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,byStatus: null == byStatus ? _self.byStatus : byStatus // ignore: cast_nullable_to_non_nullable
as Map<String, int>,byTopic: null == byTopic ? _self.byTopic : byTopic // ignore: cast_nullable_to_non_nullable
as Map<String, int>,published: null == published ? _self.published : published // ignore: cast_nullable_to_non_nullable
as int,supports: null == supports ? _self.supports : supports // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AspirationStats].
extension AspirationStatsPatterns on AspirationStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AspirationStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AspirationStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AspirationStats value)  $default,){
final _that = this;
switch (_that) {
case _AspirationStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AspirationStats value)?  $default,){
final _that = this;
switch (_that) {
case _AspirationStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int total,  Map<String, int> byStatus,  Map<String, int> byTopic,  int published,  int supports)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AspirationStats() when $default != null:
return $default(_that.total,_that.byStatus,_that.byTopic,_that.published,_that.supports);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int total,  Map<String, int> byStatus,  Map<String, int> byTopic,  int published,  int supports)  $default,) {final _that = this;
switch (_that) {
case _AspirationStats():
return $default(_that.total,_that.byStatus,_that.byTopic,_that.published,_that.supports);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int total,  Map<String, int> byStatus,  Map<String, int> byTopic,  int published,  int supports)?  $default,) {final _that = this;
switch (_that) {
case _AspirationStats() when $default != null:
return $default(_that.total,_that.byStatus,_that.byTopic,_that.published,_that.supports);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AspirationStats implements AspirationStats {
  const _AspirationStats({this.total = 0,  Map<String, int> byStatus = const <String, int>{},  Map<String, int> byTopic = const <String, int>{}, this.published = 0, this.supports = 0}): _byStatus = byStatus,_byTopic = byTopic;
  factory _AspirationStats.fromJson(Map<String, dynamic> json) => _$AspirationStatsFromJson(json);

@override@JsonKey() final  int total;
 final  Map<String, int> _byStatus;
@override@JsonKey() Map<String, int> get byStatus {
  if (_byStatus is EqualUnmodifiableMapView) return _byStatus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byStatus);
}

 final  Map<String, int> _byTopic;
@override@JsonKey() Map<String, int> get byTopic {
  if (_byTopic is EqualUnmodifiableMapView) return _byTopic;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byTopic);
}

@override@JsonKey() final  int published;
@override@JsonKey() final  int supports;

/// Create a copy of AspirationStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AspirationStatsCopyWith<_AspirationStats> get copyWith => __$AspirationStatsCopyWithImpl<_AspirationStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AspirationStatsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AspirationStats&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.byStatus, _byStatus)&&const DeepCollectionEquality().equals(other.byTopic, _byTopic)&&(identical(other.published, published) || other.published == published)&&(identical(other.supports, supports) || other.supports == supports));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,total,const DeepCollectionEquality().hash(_byStatus),const DeepCollectionEquality().hash(_byTopic),published,supports);
}

@override
String toString() {
    return 'AspirationStats(total: $total, byStatus: $byStatus, byTopic: $byTopic, published: $published, supports: $supports)';
}


}

/// @nodoc
abstract mixin class _$AspirationStatsCopyWith<$Res> implements $AspirationStatsCopyWith<$Res> {
  factory _$AspirationStatsCopyWith(_AspirationStats value, $Res Function(_AspirationStats) _then) = __$AspirationStatsCopyWithImpl;
@override @useResult
$Res call({
 int total, Map<String, int> byStatus, Map<String, int> byTopic, int published, int supports
});




}
/// @nodoc
class __$AspirationStatsCopyWithImpl<$Res>
    implements _$AspirationStatsCopyWith<$Res> {
  __$AspirationStatsCopyWithImpl(this._self, this._then);

  final _AspirationStats _self;
  final $Res Function(_AspirationStats) _then;

/// Create a copy of AspirationStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? byStatus = null,Object? byTopic = null,Object? published = null,Object? supports = null,}) {
  return _then(_AspirationStats(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,byStatus: null == byStatus ? _self._byStatus : byStatus // ignore: cast_nullable_to_non_nullable
as Map<String, int>,byTopic: null == byTopic ? _self._byTopic : byTopic // ignore: cast_nullable_to_non_nullable
as Map<String, int>,published: null == published ? _self.published : published // ignore: cast_nullable_to_non_nullable
as int,supports: null == supports ? _self.supports : supports // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CareStats {

 int get helpTotal; Map<String, int> get helpByStatus; int get conversations; int get conversationsActive;
/// Create a copy of CareStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CareStatsCopyWith<CareStats> get copyWith => _$CareStatsCopyWithImpl<CareStats>(this as CareStats, _$identity);

  /// Serializes this CareStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CareStats;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CareStats&&(identical(other.helpTotal, _this.helpTotal) || other.helpTotal == _this.helpTotal)&&const DeepCollectionEquality().equals(other.helpByStatus, _this.helpByStatus)&&(identical(other.conversations, _this.conversations) || other.conversations == _this.conversations)&&(identical(other.conversationsActive, _this.conversationsActive) || other.conversationsActive == _this.conversationsActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CareStats;
  return Object.hash(runtimeType,_this.helpTotal,const DeepCollectionEquality().hash(_this.helpByStatus),_this.conversations,_this.conversationsActive);
}

@override
String toString() {
  final _this = this as CareStats;
  return 'CareStats(helpTotal: ${_this.helpTotal}, helpByStatus: ${_this.helpByStatus}, conversations: ${_this.conversations}, conversationsActive: ${_this.conversationsActive})';
}


}

/// @nodoc
abstract mixin class $CareStatsCopyWith<$Res>  {
  factory $CareStatsCopyWith(CareStats value, $Res Function(CareStats) _then) = _$CareStatsCopyWithImpl;
@useResult
$Res call({
 int helpTotal, Map<String, int> helpByStatus, int conversations, int conversationsActive
});




}
/// @nodoc
class _$CareStatsCopyWithImpl<$Res>
    implements $CareStatsCopyWith<$Res> {
  _$CareStatsCopyWithImpl(this._self, this._then);

  final CareStats _self;
  final $Res Function(CareStats) _then;

/// Create a copy of CareStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? helpTotal = null,Object? helpByStatus = null,Object? conversations = null,Object? conversationsActive = null,}) {
  return _then(CareStats(
helpTotal: null == helpTotal ? _self.helpTotal : helpTotal // ignore: cast_nullable_to_non_nullable
as int,helpByStatus: null == helpByStatus ? _self.helpByStatus : helpByStatus // ignore: cast_nullable_to_non_nullable
as Map<String, int>,conversations: null == conversations ? _self.conversations : conversations // ignore: cast_nullable_to_non_nullable
as int,conversationsActive: null == conversationsActive ? _self.conversationsActive : conversationsActive // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CareStats].
extension CareStatsPatterns on CareStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CareStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CareStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CareStats value)  $default,){
final _that = this;
switch (_that) {
case _CareStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CareStats value)?  $default,){
final _that = this;
switch (_that) {
case _CareStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int helpTotal,  Map<String, int> helpByStatus,  int conversations,  int conversationsActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CareStats() when $default != null:
return $default(_that.helpTotal,_that.helpByStatus,_that.conversations,_that.conversationsActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int helpTotal,  Map<String, int> helpByStatus,  int conversations,  int conversationsActive)  $default,) {final _that = this;
switch (_that) {
case _CareStats():
return $default(_that.helpTotal,_that.helpByStatus,_that.conversations,_that.conversationsActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int helpTotal,  Map<String, int> helpByStatus,  int conversations,  int conversationsActive)?  $default,) {final _that = this;
switch (_that) {
case _CareStats() when $default != null:
return $default(_that.helpTotal,_that.helpByStatus,_that.conversations,_that.conversationsActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CareStats implements CareStats {
  const _CareStats({this.helpTotal = 0,  Map<String, int> helpByStatus = const <String, int>{}, this.conversations = 0, this.conversationsActive = 0}): _helpByStatus = helpByStatus;
  factory _CareStats.fromJson(Map<String, dynamic> json) => _$CareStatsFromJson(json);

@override@JsonKey() final  int helpTotal;
 final  Map<String, int> _helpByStatus;
@override@JsonKey() Map<String, int> get helpByStatus {
  if (_helpByStatus is EqualUnmodifiableMapView) return _helpByStatus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_helpByStatus);
}

@override@JsonKey() final  int conversations;
@override@JsonKey() final  int conversationsActive;

/// Create a copy of CareStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CareStatsCopyWith<_CareStats> get copyWith => __$CareStatsCopyWithImpl<_CareStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CareStatsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CareStats&&(identical(other.helpTotal, helpTotal) || other.helpTotal == helpTotal)&&const DeepCollectionEquality().equals(other.helpByStatus, _helpByStatus)&&(identical(other.conversations, conversations) || other.conversations == conversations)&&(identical(other.conversationsActive, conversationsActive) || other.conversationsActive == conversationsActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,helpTotal,const DeepCollectionEquality().hash(_helpByStatus),conversations,conversationsActive);
}

@override
String toString() {
    return 'CareStats(helpTotal: $helpTotal, helpByStatus: $helpByStatus, conversations: $conversations, conversationsActive: $conversationsActive)';
}


}

/// @nodoc
abstract mixin class _$CareStatsCopyWith<$Res> implements $CareStatsCopyWith<$Res> {
  factory _$CareStatsCopyWith(_CareStats value, $Res Function(_CareStats) _then) = __$CareStatsCopyWithImpl;
@override @useResult
$Res call({
 int helpTotal, Map<String, int> helpByStatus, int conversations, int conversationsActive
});




}
/// @nodoc
class __$CareStatsCopyWithImpl<$Res>
    implements _$CareStatsCopyWith<$Res> {
  __$CareStatsCopyWithImpl(this._self, this._then);

  final _CareStats _self;
  final $Res Function(_CareStats) _then;

/// Create a copy of CareStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? helpTotal = null,Object? helpByStatus = null,Object? conversations = null,Object? conversationsActive = null,}) {
  return _then(_CareStats(
helpTotal: null == helpTotal ? _self.helpTotal : helpTotal // ignore: cast_nullable_to_non_nullable
as int,helpByStatus: null == helpByStatus ? _self._helpByStatus : helpByStatus // ignore: cast_nullable_to_non_nullable
as Map<String, int>,conversations: null == conversations ? _self.conversations : conversations // ignore: cast_nullable_to_non_nullable
as int,conversationsActive: null == conversationsActive ? _self.conversationsActive : conversationsActive // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MemberStats {

 int get total; Map<String, int> get byRole;
/// Create a copy of MemberStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberStatsCopyWith<MemberStats> get copyWith => _$MemberStatsCopyWithImpl<MemberStats>(this as MemberStats, _$identity);

  /// Serializes this MemberStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MemberStats;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberStats&&(identical(other.total, _this.total) || other.total == _this.total)&&const DeepCollectionEquality().equals(other.byRole, _this.byRole));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MemberStats;
  return Object.hash(runtimeType,_this.total,const DeepCollectionEquality().hash(_this.byRole));
}

@override
String toString() {
  final _this = this as MemberStats;
  return 'MemberStats(total: ${_this.total}, byRole: ${_this.byRole})';
}


}

/// @nodoc
abstract mixin class $MemberStatsCopyWith<$Res>  {
  factory $MemberStatsCopyWith(MemberStats value, $Res Function(MemberStats) _then) = _$MemberStatsCopyWithImpl;
@useResult
$Res call({
 int total, Map<String, int> byRole
});




}
/// @nodoc
class _$MemberStatsCopyWithImpl<$Res>
    implements $MemberStatsCopyWith<$Res> {
  _$MemberStatsCopyWithImpl(this._self, this._then);

  final MemberStats _self;
  final $Res Function(MemberStats) _then;

/// Create a copy of MemberStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? byRole = null,}) {
  return _then(MemberStats(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,byRole: null == byRole ? _self.byRole : byRole // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberStats].
extension MemberStatsPatterns on MemberStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberStats value)  $default,){
final _that = this;
switch (_that) {
case _MemberStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberStats value)?  $default,){
final _that = this;
switch (_that) {
case _MemberStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int total,  Map<String, int> byRole)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberStats() when $default != null:
return $default(_that.total,_that.byRole);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int total,  Map<String, int> byRole)  $default,) {final _that = this;
switch (_that) {
case _MemberStats():
return $default(_that.total,_that.byRole);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int total,  Map<String, int> byRole)?  $default,) {final _that = this;
switch (_that) {
case _MemberStats() when $default != null:
return $default(_that.total,_that.byRole);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberStats implements MemberStats {
  const _MemberStats({this.total = 0,  Map<String, int> byRole = const <String, int>{}}): _byRole = byRole;
  factory _MemberStats.fromJson(Map<String, dynamic> json) => _$MemberStatsFromJson(json);

@override@JsonKey() final  int total;
 final  Map<String, int> _byRole;
@override@JsonKey() Map<String, int> get byRole {
  if (_byRole is EqualUnmodifiableMapView) return _byRole;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byRole);
}


/// Create a copy of MemberStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberStatsCopyWith<_MemberStats> get copyWith => __$MemberStatsCopyWithImpl<_MemberStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberStatsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberStats&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.byRole, _byRole));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,total,const DeepCollectionEquality().hash(_byRole));
}

@override
String toString() {
    return 'MemberStats(total: $total, byRole: $byRole)';
}


}

/// @nodoc
abstract mixin class _$MemberStatsCopyWith<$Res> implements $MemberStatsCopyWith<$Res> {
  factory _$MemberStatsCopyWith(_MemberStats value, $Res Function(_MemberStats) _then) = __$MemberStatsCopyWithImpl;
@override @useResult
$Res call({
 int total, Map<String, int> byRole
});




}
/// @nodoc
class __$MemberStatsCopyWithImpl<$Res>
    implements _$MemberStatsCopyWith<$Res> {
  __$MemberStatsCopyWithImpl(this._self, this._then);

  final _MemberStats _self;
  final $Res Function(_MemberStats) _then;

/// Create a copy of MemberStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? byRole = null,}) {
  return _then(_MemberStats(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,byRole: null == byRole ? _self._byRole : byRole // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}


/// @nodoc
mixin _$PlatformStats {

 List<SchoolVolume> get schools; PlatformTotals get totals; String get updatedAt;
/// Create a copy of PlatformStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformStatsCopyWith<PlatformStats> get copyWith => _$PlatformStatsCopyWithImpl<PlatformStats>(this as PlatformStats, _$identity);

  /// Serializes this PlatformStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlatformStats;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlatformStats&&const DeepCollectionEquality().equals(other.schools, _this.schools)&&(identical(other.totals, _this.totals) || other.totals == _this.totals)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlatformStats;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.schools),_this.totals,_this.updatedAt);
}

@override
String toString() {
  final _this = this as PlatformStats;
  return 'PlatformStats(schools: ${_this.schools}, totals: ${_this.totals}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $PlatformStatsCopyWith<$Res>  {
  factory $PlatformStatsCopyWith(PlatformStats value, $Res Function(PlatformStats) _then) = _$PlatformStatsCopyWithImpl;
@useResult
$Res call({
 List<SchoolVolume> schools, PlatformTotals totals, String updatedAt
});


$PlatformTotalsCopyWith<$Res> get totals;

}
/// @nodoc
class _$PlatformStatsCopyWithImpl<$Res>
    implements $PlatformStatsCopyWith<$Res> {
  _$PlatformStatsCopyWithImpl(this._self, this._then);

  final PlatformStats _self;
  final $Res Function(PlatformStats) _then;

/// Create a copy of PlatformStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schools = null,Object? totals = null,Object? updatedAt = null,}) {
  return _then(PlatformStats(
schools: null == schools ? _self.schools : schools // ignore: cast_nullable_to_non_nullable
as List<SchoolVolume>,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as PlatformTotals,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of PlatformStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlatformTotalsCopyWith<$Res> get totals {
  
  return $PlatformTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlatformStats].
extension PlatformStatsPatterns on PlatformStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlatformStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlatformStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlatformStats value)  $default,){
final _that = this;
switch (_that) {
case _PlatformStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlatformStats value)?  $default,){
final _that = this;
switch (_that) {
case _PlatformStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SchoolVolume> schools,  PlatformTotals totals,  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlatformStats() when $default != null:
return $default(_that.schools,_that.totals,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SchoolVolume> schools,  PlatformTotals totals,  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PlatformStats():
return $default(_that.schools,_that.totals,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SchoolVolume> schools,  PlatformTotals totals,  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PlatformStats() when $default != null:
return $default(_that.schools,_that.totals,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlatformStats implements PlatformStats {
  const _PlatformStats({ List<SchoolVolume> schools = const <SchoolVolume>[], this.totals = const PlatformTotals(), this.updatedAt = ''}): _schools = schools;
  factory _PlatformStats.fromJson(Map<String, dynamic> json) => _$PlatformStatsFromJson(json);

 final  List<SchoolVolume> _schools;
@override@JsonKey() List<SchoolVolume> get schools {
  if (_schools is EqualUnmodifiableListView) return _schools;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_schools);
}

@override@JsonKey() final  PlatformTotals totals;
@override@JsonKey() final  String updatedAt;

/// Create a copy of PlatformStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlatformStatsCopyWith<_PlatformStats> get copyWith => __$PlatformStatsCopyWithImpl<_PlatformStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlatformStatsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlatformStats&&const DeepCollectionEquality().equals(other.schools, _schools)&&(identical(other.totals, totals) || other.totals == totals)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_schools),totals,updatedAt);
}

@override
String toString() {
    return 'PlatformStats(schools: $schools, totals: $totals, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PlatformStatsCopyWith<$Res> implements $PlatformStatsCopyWith<$Res> {
  factory _$PlatformStatsCopyWith(_PlatformStats value, $Res Function(_PlatformStats) _then) = __$PlatformStatsCopyWithImpl;
@override @useResult
$Res call({
 List<SchoolVolume> schools, PlatformTotals totals, String updatedAt
});


@override $PlatformTotalsCopyWith<$Res> get totals;

}
/// @nodoc
class __$PlatformStatsCopyWithImpl<$Res>
    implements _$PlatformStatsCopyWith<$Res> {
  __$PlatformStatsCopyWithImpl(this._self, this._then);

  final _PlatformStats _self;
  final $Res Function(_PlatformStats) _then;

/// Create a copy of PlatformStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schools = null,Object? totals = null,Object? updatedAt = null,}) {
  return _then(_PlatformStats(
schools: null == schools ? _self._schools : schools // ignore: cast_nullable_to_non_nullable
as List<SchoolVolume>,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as PlatformTotals,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of PlatformStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlatformTotalsCopyWith<$Res> get totals {
  
  return $PlatformTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}


/// @nodoc
mixin _$SchoolVolume {

 String get schoolId; String get name; String get city; bool get active; int get members; int get tickets; int get open; int get aspirations;
/// Create a copy of SchoolVolume
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SchoolVolumeCopyWith<SchoolVolume> get copyWith => _$SchoolVolumeCopyWithImpl<SchoolVolume>(this as SchoolVolume, _$identity);

  /// Serializes this SchoolVolume to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SchoolVolume;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SchoolVolume&&(identical(other.schoolId, _this.schoolId) || other.schoolId == _this.schoolId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.active, _this.active) || other.active == _this.active)&&(identical(other.members, _this.members) || other.members == _this.members)&&(identical(other.tickets, _this.tickets) || other.tickets == _this.tickets)&&(identical(other.open, _this.open) || other.open == _this.open)&&(identical(other.aspirations, _this.aspirations) || other.aspirations == _this.aspirations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SchoolVolume;
  return Object.hash(runtimeType,_this.schoolId,_this.name,_this.city,_this.active,_this.members,_this.tickets,_this.open,_this.aspirations);
}

@override
String toString() {
  final _this = this as SchoolVolume;
  return 'SchoolVolume(schoolId: ${_this.schoolId}, name: ${_this.name}, city: ${_this.city}, active: ${_this.active}, members: ${_this.members}, tickets: ${_this.tickets}, open: ${_this.open}, aspirations: ${_this.aspirations})';
}


}

/// @nodoc
abstract mixin class $SchoolVolumeCopyWith<$Res>  {
  factory $SchoolVolumeCopyWith(SchoolVolume value, $Res Function(SchoolVolume) _then) = _$SchoolVolumeCopyWithImpl;
@useResult
$Res call({
 String schoolId, String name, String city, bool active, int members, int tickets, int open, int aspirations
});




}
/// @nodoc
class _$SchoolVolumeCopyWithImpl<$Res>
    implements $SchoolVolumeCopyWith<$Res> {
  _$SchoolVolumeCopyWithImpl(this._self, this._then);

  final SchoolVolume _self;
  final $Res Function(SchoolVolume) _then;

/// Create a copy of SchoolVolume
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schoolId = null,Object? name = null,Object? city = null,Object? active = null,Object? members = null,Object? tickets = null,Object? open = null,Object? aspirations = null,}) {
  return _then(SchoolVolume(
schoolId: null == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as int,tickets: null == tickets ? _self.tickets : tickets // ignore: cast_nullable_to_non_nullable
as int,open: null == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as int,aspirations: null == aspirations ? _self.aspirations : aspirations // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SchoolVolume].
extension SchoolVolumePatterns on SchoolVolume {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SchoolVolume value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SchoolVolume() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SchoolVolume value)  $default,){
final _that = this;
switch (_that) {
case _SchoolVolume():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SchoolVolume value)?  $default,){
final _that = this;
switch (_that) {
case _SchoolVolume() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String schoolId,  String name,  String city,  bool active,  int members,  int tickets,  int open,  int aspirations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SchoolVolume() when $default != null:
return $default(_that.schoolId,_that.name,_that.city,_that.active,_that.members,_that.tickets,_that.open,_that.aspirations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String schoolId,  String name,  String city,  bool active,  int members,  int tickets,  int open,  int aspirations)  $default,) {final _that = this;
switch (_that) {
case _SchoolVolume():
return $default(_that.schoolId,_that.name,_that.city,_that.active,_that.members,_that.tickets,_that.open,_that.aspirations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String schoolId,  String name,  String city,  bool active,  int members,  int tickets,  int open,  int aspirations)?  $default,) {final _that = this;
switch (_that) {
case _SchoolVolume() when $default != null:
return $default(_that.schoolId,_that.name,_that.city,_that.active,_that.members,_that.tickets,_that.open,_that.aspirations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SchoolVolume implements SchoolVolume {
  const _SchoolVolume({this.schoolId = '', this.name = '', this.city = '', this.active = true, this.members = 0, this.tickets = 0, this.open = 0, this.aspirations = 0});
  factory _SchoolVolume.fromJson(Map<String, dynamic> json) => _$SchoolVolumeFromJson(json);

@override@JsonKey() final  String schoolId;
@override@JsonKey() final  String name;
@override@JsonKey() final  String city;
@override@JsonKey() final  bool active;
@override@JsonKey() final  int members;
@override@JsonKey() final  int tickets;
@override@JsonKey() final  int open;
@override@JsonKey() final  int aspirations;

/// Create a copy of SchoolVolume
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SchoolVolumeCopyWith<_SchoolVolume> get copyWith => __$SchoolVolumeCopyWithImpl<_SchoolVolume>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SchoolVolumeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SchoolVolume&&(identical(other.schoolId, schoolId) || other.schoolId == schoolId)&&(identical(other.name, name) || other.name == name)&&(identical(other.city, city) || other.city == city)&&(identical(other.active, active) || other.active == active)&&(identical(other.members, members) || other.members == members)&&(identical(other.tickets, tickets) || other.tickets == tickets)&&(identical(other.open, open) || other.open == open)&&(identical(other.aspirations, aspirations) || other.aspirations == aspirations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,schoolId,name,city,active,members,tickets,open,aspirations);
}

@override
String toString() {
    return 'SchoolVolume(schoolId: $schoolId, name: $name, city: $city, active: $active, members: $members, tickets: $tickets, open: $open, aspirations: $aspirations)';
}


}

/// @nodoc
abstract mixin class _$SchoolVolumeCopyWith<$Res> implements $SchoolVolumeCopyWith<$Res> {
  factory _$SchoolVolumeCopyWith(_SchoolVolume value, $Res Function(_SchoolVolume) _then) = __$SchoolVolumeCopyWithImpl;
@override @useResult
$Res call({
 String schoolId, String name, String city, bool active, int members, int tickets, int open, int aspirations
});




}
/// @nodoc
class __$SchoolVolumeCopyWithImpl<$Res>
    implements _$SchoolVolumeCopyWith<$Res> {
  __$SchoolVolumeCopyWithImpl(this._self, this._then);

  final _SchoolVolume _self;
  final $Res Function(_SchoolVolume) _then;

/// Create a copy of SchoolVolume
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schoolId = null,Object? name = null,Object? city = null,Object? active = null,Object? members = null,Object? tickets = null,Object? open = null,Object? aspirations = null,}) {
  return _then(_SchoolVolume(
schoolId: null == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as int,tickets: null == tickets ? _self.tickets : tickets // ignore: cast_nullable_to_non_nullable
as int,open: null == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as int,aspirations: null == aspirations ? _self.aspirations : aspirations // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PlatformTotals {

 int get schools; int get activeSchools; int get members; int get tickets; int get aspirations;
/// Create a copy of PlatformTotals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformTotalsCopyWith<PlatformTotals> get copyWith => _$PlatformTotalsCopyWithImpl<PlatformTotals>(this as PlatformTotals, _$identity);

  /// Serializes this PlatformTotals to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlatformTotals;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlatformTotals&&(identical(other.schools, _this.schools) || other.schools == _this.schools)&&(identical(other.activeSchools, _this.activeSchools) || other.activeSchools == _this.activeSchools)&&(identical(other.members, _this.members) || other.members == _this.members)&&(identical(other.tickets, _this.tickets) || other.tickets == _this.tickets)&&(identical(other.aspirations, _this.aspirations) || other.aspirations == _this.aspirations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlatformTotals;
  return Object.hash(runtimeType,_this.schools,_this.activeSchools,_this.members,_this.tickets,_this.aspirations);
}

@override
String toString() {
  final _this = this as PlatformTotals;
  return 'PlatformTotals(schools: ${_this.schools}, activeSchools: ${_this.activeSchools}, members: ${_this.members}, tickets: ${_this.tickets}, aspirations: ${_this.aspirations})';
}


}

/// @nodoc
abstract mixin class $PlatformTotalsCopyWith<$Res>  {
  factory $PlatformTotalsCopyWith(PlatformTotals value, $Res Function(PlatformTotals) _then) = _$PlatformTotalsCopyWithImpl;
@useResult
$Res call({
 int schools, int activeSchools, int members, int tickets, int aspirations
});




}
/// @nodoc
class _$PlatformTotalsCopyWithImpl<$Res>
    implements $PlatformTotalsCopyWith<$Res> {
  _$PlatformTotalsCopyWithImpl(this._self, this._then);

  final PlatformTotals _self;
  final $Res Function(PlatformTotals) _then;

/// Create a copy of PlatformTotals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schools = null,Object? activeSchools = null,Object? members = null,Object? tickets = null,Object? aspirations = null,}) {
  return _then(PlatformTotals(
schools: null == schools ? _self.schools : schools // ignore: cast_nullable_to_non_nullable
as int,activeSchools: null == activeSchools ? _self.activeSchools : activeSchools // ignore: cast_nullable_to_non_nullable
as int,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as int,tickets: null == tickets ? _self.tickets : tickets // ignore: cast_nullable_to_non_nullable
as int,aspirations: null == aspirations ? _self.aspirations : aspirations // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PlatformTotals].
extension PlatformTotalsPatterns on PlatformTotals {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlatformTotals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlatformTotals() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlatformTotals value)  $default,){
final _that = this;
switch (_that) {
case _PlatformTotals():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlatformTotals value)?  $default,){
final _that = this;
switch (_that) {
case _PlatformTotals() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schools,  int activeSchools,  int members,  int tickets,  int aspirations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlatformTotals() when $default != null:
return $default(_that.schools,_that.activeSchools,_that.members,_that.tickets,_that.aspirations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schools,  int activeSchools,  int members,  int tickets,  int aspirations)  $default,) {final _that = this;
switch (_that) {
case _PlatformTotals():
return $default(_that.schools,_that.activeSchools,_that.members,_that.tickets,_that.aspirations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schools,  int activeSchools,  int members,  int tickets,  int aspirations)?  $default,) {final _that = this;
switch (_that) {
case _PlatformTotals() when $default != null:
return $default(_that.schools,_that.activeSchools,_that.members,_that.tickets,_that.aspirations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlatformTotals implements PlatformTotals {
  const _PlatformTotals({this.schools = 0, this.activeSchools = 0, this.members = 0, this.tickets = 0, this.aspirations = 0});
  factory _PlatformTotals.fromJson(Map<String, dynamic> json) => _$PlatformTotalsFromJson(json);

@override@JsonKey() final  int schools;
@override@JsonKey() final  int activeSchools;
@override@JsonKey() final  int members;
@override@JsonKey() final  int tickets;
@override@JsonKey() final  int aspirations;

/// Create a copy of PlatformTotals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlatformTotalsCopyWith<_PlatformTotals> get copyWith => __$PlatformTotalsCopyWithImpl<_PlatformTotals>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlatformTotalsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlatformTotals&&(identical(other.schools, schools) || other.schools == schools)&&(identical(other.activeSchools, activeSchools) || other.activeSchools == activeSchools)&&(identical(other.members, members) || other.members == members)&&(identical(other.tickets, tickets) || other.tickets == tickets)&&(identical(other.aspirations, aspirations) || other.aspirations == aspirations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,schools,activeSchools,members,tickets,aspirations);
}

@override
String toString() {
    return 'PlatformTotals(schools: $schools, activeSchools: $activeSchools, members: $members, tickets: $tickets, aspirations: $aspirations)';
}


}

/// @nodoc
abstract mixin class _$PlatformTotalsCopyWith<$Res> implements $PlatformTotalsCopyWith<$Res> {
  factory _$PlatformTotalsCopyWith(_PlatformTotals value, $Res Function(_PlatformTotals) _then) = __$PlatformTotalsCopyWithImpl;
@override @useResult
$Res call({
 int schools, int activeSchools, int members, int tickets, int aspirations
});




}
/// @nodoc
class __$PlatformTotalsCopyWithImpl<$Res>
    implements _$PlatformTotalsCopyWith<$Res> {
  __$PlatformTotalsCopyWithImpl(this._self, this._then);

  final _PlatformTotals _self;
  final $Res Function(_PlatformTotals) _then;

/// Create a copy of PlatformTotals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schools = null,Object? activeSchools = null,Object? members = null,Object? tickets = null,Object? aspirations = null,}) {
  return _then(_PlatformTotals(
schools: null == schools ? _self.schools : schools // ignore: cast_nullable_to_non_nullable
as int,activeSchools: null == activeSchools ? _self.activeSchools : activeSchools // ignore: cast_nullable_to_non_nullable
as int,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as int,tickets: null == tickets ? _self.tickets : tickets // ignore: cast_nullable_to_non_nullable
as int,aspirations: null == aspirations ? _self.aspirations : aspirations // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
