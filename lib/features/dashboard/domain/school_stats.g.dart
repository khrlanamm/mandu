// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SchoolStats _$SchoolStatsFromJson(Map<String, dynamic> json) => _SchoolStats(
  months: (json['months'] as num?)?.toInt() ?? 6,
  from: json['from'] as String? ?? '',
  tickets: json['tickets'] == null
      ? const TicketStats()
      : TicketStats.fromJson(json['tickets'] as Map<String, dynamic>),
  aspirations: json['aspirations'] == null
      ? const AspirationStats()
      : AspirationStats.fromJson(json['aspirations'] as Map<String, dynamic>),
  care: json['care'] == null
      ? const CareStats()
      : CareStats.fromJson(json['care'] as Map<String, dynamic>),
  members: json['members'] == null
      ? const MemberStats()
      : MemberStats.fromJson(json['members'] as Map<String, dynamic>),
  updatedAt: json['updatedAt'] as String? ?? '',
);

Map<String, dynamic> _$SchoolStatsToJson(_SchoolStats instance) =>
    <String, dynamic>{
      'months': instance.months,
      'from': instance.from,
      'tickets': instance.tickets.toJson(),
      'aspirations': instance.aspirations.toJson(),
      'care': instance.care.toJson(),
      'members': instance.members.toJson(),
      'updatedAt': instance.updatedAt,
    };

_TicketStats _$TicketStatsFromJson(Map<String, dynamic> json) => _TicketStats(
  total: (json['total'] as num?)?.toInt() ?? 0,
  byStatus:
      (json['byStatus'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const <String, int>{},
  byCategory:
      (json['byCategory'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const <String, int>{},
  byPriority:
      (json['byPriority'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const <String, int>{},
  overdue: (json['overdue'] as num?)?.toInt() ?? 0,
  avgVerifyHours: (json['avgVerifyHours'] as num?)?.toDouble(),
  avgResolveHours: (json['avgResolveHours'] as num?)?.toDouble(),
  avgRating: (json['avgRating'] as num?)?.toDouble(),
  ratingCount: (json['ratingCount'] as num?)?.toInt() ?? 0,
  topLocations:
      (json['topLocations'] as List<dynamic>?)
          ?.map((e) => LocationCount.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LocationCount>[],
  monthly:
      (json['monthly'] as List<dynamic>?)
          ?.map((e) => MonthlyCount.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MonthlyCount>[],
  units:
      (json['units'] as List<dynamic>?)
          ?.map((e) => UnitPerformance.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <UnitPerformance>[],
);

Map<String, dynamic> _$TicketStatsToJson(_TicketStats instance) =>
    <String, dynamic>{
      'total': instance.total,
      'byStatus': instance.byStatus,
      'byCategory': instance.byCategory,
      'byPriority': instance.byPriority,
      'overdue': instance.overdue,
      'avgVerifyHours': instance.avgVerifyHours,
      'avgResolveHours': instance.avgResolveHours,
      'avgRating': instance.avgRating,
      'ratingCount': instance.ratingCount,
      'topLocations': instance.topLocations.map((e) => e.toJson()).toList(),
      'monthly': instance.monthly.map((e) => e.toJson()).toList(),
      'units': instance.units.map((e) => e.toJson()).toList(),
    };

_LocationCount _$LocationCountFromJson(Map<String, dynamic> json) =>
    _LocationCount(
      location: json['location'] as String? ?? '',
      count: (json['count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$LocationCountToJson(_LocationCount instance) =>
    <String, dynamic>{'location': instance.location, 'count': instance.count};

_MonthlyCount _$MonthlyCountFromJson(Map<String, dynamic> json) =>
    _MonthlyCount(
      month: json['month'] as String? ?? '',
      total: (json['total'] as num?)?.toInt() ?? 0,
      selesai: (json['selesai'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MonthlyCountToJson(_MonthlyCount instance) =>
    <String, dynamic>{
      'month': instance.month,
      'total': instance.total,
      'selesai': instance.selesai,
    };

_UnitPerformance _$UnitPerformanceFromJson(Map<String, dynamic> json) =>
    _UnitPerformance(
      unitId: json['unitId'] as String? ?? '',
      unitName: json['unitName'] as String? ?? '',
      total: (json['total'] as num?)?.toInt() ?? 0,
      selesai: (json['selesai'] as num?)?.toInt() ?? 0,
      avgResolveHours: (json['avgResolveHours'] as num?)?.toDouble(),
      onTimePercent: (json['onTimePercent'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UnitPerformanceToJson(_UnitPerformance instance) =>
    <String, dynamic>{
      'unitId': instance.unitId,
      'unitName': instance.unitName,
      'total': instance.total,
      'selesai': instance.selesai,
      'avgResolveHours': instance.avgResolveHours,
      'onTimePercent': instance.onTimePercent,
    };

_AspirationStats _$AspirationStatsFromJson(Map<String, dynamic> json) =>
    _AspirationStats(
      total: (json['total'] as num?)?.toInt() ?? 0,
      byStatus:
          (json['byStatus'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const <String, int>{},
      byTopic:
          (json['byTopic'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const <String, int>{},
      published: (json['published'] as num?)?.toInt() ?? 0,
      supports: (json['supports'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AspirationStatsToJson(_AspirationStats instance) =>
    <String, dynamic>{
      'total': instance.total,
      'byStatus': instance.byStatus,
      'byTopic': instance.byTopic,
      'published': instance.published,
      'supports': instance.supports,
    };

_CareStats _$CareStatsFromJson(Map<String, dynamic> json) => _CareStats(
  helpTotal: (json['helpTotal'] as num?)?.toInt() ?? 0,
  helpByStatus:
      (json['helpByStatus'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const <String, int>{},
  conversations: (json['conversations'] as num?)?.toInt() ?? 0,
  conversationsActive: (json['conversationsActive'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$CareStatsToJson(_CareStats instance) =>
    <String, dynamic>{
      'helpTotal': instance.helpTotal,
      'helpByStatus': instance.helpByStatus,
      'conversations': instance.conversations,
      'conversationsActive': instance.conversationsActive,
    };

_MemberStats _$MemberStatsFromJson(Map<String, dynamic> json) => _MemberStats(
  total: (json['total'] as num?)?.toInt() ?? 0,
  byRole:
      (json['byRole'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const <String, int>{},
);

Map<String, dynamic> _$MemberStatsToJson(_MemberStats instance) =>
    <String, dynamic>{'total': instance.total, 'byRole': instance.byRole};

_PlatformStats _$PlatformStatsFromJson(Map<String, dynamic> json) =>
    _PlatformStats(
      schools:
          (json['schools'] as List<dynamic>?)
              ?.map((e) => SchoolVolume.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SchoolVolume>[],
      totals: json['totals'] == null
          ? const PlatformTotals()
          : PlatformTotals.fromJson(json['totals'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] as String? ?? '',
    );

Map<String, dynamic> _$PlatformStatsToJson(_PlatformStats instance) =>
    <String, dynamic>{
      'schools': instance.schools.map((e) => e.toJson()).toList(),
      'totals': instance.totals.toJson(),
      'updatedAt': instance.updatedAt,
    };

_SchoolVolume _$SchoolVolumeFromJson(Map<String, dynamic> json) =>
    _SchoolVolume(
      schoolId: json['schoolId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      city: json['city'] as String? ?? '',
      active: json['active'] as bool? ?? true,
      members: (json['members'] as num?)?.toInt() ?? 0,
      tickets: (json['tickets'] as num?)?.toInt() ?? 0,
      open: (json['open'] as num?)?.toInt() ?? 0,
      aspirations: (json['aspirations'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SchoolVolumeToJson(_SchoolVolume instance) =>
    <String, dynamic>{
      'schoolId': instance.schoolId,
      'name': instance.name,
      'city': instance.city,
      'active': instance.active,
      'members': instance.members,
      'tickets': instance.tickets,
      'open': instance.open,
      'aspirations': instance.aspirations,
    };

_PlatformTotals _$PlatformTotalsFromJson(Map<String, dynamic> json) =>
    _PlatformTotals(
      schools: (json['schools'] as num?)?.toInt() ?? 0,
      activeSchools: (json['activeSchools'] as num?)?.toInt() ?? 0,
      members: (json['members'] as num?)?.toInt() ?? 0,
      tickets: (json['tickets'] as num?)?.toInt() ?? 0,
      aspirations: (json['aspirations'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PlatformTotalsToJson(_PlatformTotals instance) =>
    <String, dynamic>{
      'schools': instance.schools,
      'activeSchools': instance.activeSchools,
      'members': instance.members,
      'tickets': instance.tickets,
      'aspirations': instance.aspirations,
    };
