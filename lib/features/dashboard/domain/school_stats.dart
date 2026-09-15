import 'package:freezed_annotation/freezed_annotation.dart';

part 'school_stats.freezed.dart';
part 'school_stats.g.dart';

/// Hasil `stats-school` (functions/src/stats/compute.ts).
@freezed
abstract class SchoolStats with _$SchoolStats {
  const SchoolStats._();

  const factory SchoolStats({
    @Default(6) int months,
    @Default('') String from,
    @Default(TicketStats()) TicketStats tickets,
    @Default(AspirationStats()) AspirationStats aspirations,
    @Default(CareStats()) CareStats care,
    @Default(MemberStats()) MemberStats members,
    @Default('') String updatedAt,
  }) = _SchoolStats;

  factory SchoolStats.fromJson(Map<String, dynamic> json) => _$SchoolStatsFromJson(json);
}

@freezed
abstract class TicketStats with _$TicketStats {
  const TicketStats._();

  const factory TicketStats({
    @Default(0) int total,
    @Default(<String, int>{}) Map<String, int> byStatus,
    @Default(<String, int>{}) Map<String, int> byCategory,
    @Default(<String, int>{}) Map<String, int> byPriority,
    @Default(0) int overdue,
    double? avgVerifyHours,
    double? avgResolveHours,
    double? avgRating,
    @Default(0) int ratingCount,
    @Default(<LocationCount>[]) List<LocationCount> topLocations,
    @Default(<MonthlyCount>[]) List<MonthlyCount> monthly,
    @Default(<UnitPerformance>[]) List<UnitPerformance> units,
  }) = _TicketStats;

  factory TicketStats.fromJson(Map<String, dynamic> json) => _$TicketStatsFromJson(json);

  int get selesai => byStatus['selesai'] ?? 0;

  int get menungguVerifikasi => byStatus['menunggu_verifikasi'] ?? 0;

  int get diproses => (byStatus['diteruskan'] ?? 0) + (byStatus['diproses'] ?? 0);

  int get darurat => byPriority['darurat'] ?? 0;
}

@freezed
abstract class LocationCount with _$LocationCount {
  const factory LocationCount({@Default('') String location, @Default(0) int count}) = _LocationCount;

  factory LocationCount.fromJson(Map<String, dynamic> json) => _$LocationCountFromJson(json);
}

@freezed
abstract class MonthlyCount with _$MonthlyCount {
  const factory MonthlyCount({@Default('') String month, @Default(0) int total, @Default(0) int selesai}) = _MonthlyCount;

  factory MonthlyCount.fromJson(Map<String, dynamic> json) => _$MonthlyCountFromJson(json);
}

@freezed
abstract class UnitPerformance with _$UnitPerformance {
  const factory UnitPerformance({
    @Default('') String unitId,
    @Default('') String unitName,
    @Default(0) int total,
    @Default(0) int selesai,
    double? avgResolveHours,
    int? onTimePercent,
  }) = _UnitPerformance;

  factory UnitPerformance.fromJson(Map<String, dynamic> json) => _$UnitPerformanceFromJson(json);
}

@freezed
abstract class AspirationStats with _$AspirationStats {
  const factory AspirationStats({
    @Default(0) int total,
    @Default(<String, int>{}) Map<String, int> byStatus,
    @Default(<String, int>{}) Map<String, int> byTopic,
    @Default(0) int published,
    @Default(0) int supports,
  }) = _AspirationStats;

  factory AspirationStats.fromJson(Map<String, dynamic> json) => _$AspirationStatsFromJson(json);
}

@freezed
abstract class CareStats with _$CareStats {
  const factory CareStats({
    @Default(0) int helpTotal,
    @Default(<String, int>{}) Map<String, int> helpByStatus,
    @Default(0) int conversations,
    @Default(0) int conversationsActive,
  }) = _CareStats;

  factory CareStats.fromJson(Map<String, dynamic> json) => _$CareStatsFromJson(json);
}

@freezed
abstract class MemberStats with _$MemberStats {
  const factory MemberStats({
    @Default(0) int total,
    @Default(<String, int>{}) Map<String, int> byRole,
  }) = _MemberStats;

  factory MemberStats.fromJson(Map<String, dynamic> json) => _$MemberStatsFromJson(json);
}

/// Hasil `stats-platform` untuk superadmin.
@freezed
abstract class PlatformStats with _$PlatformStats {
  const factory PlatformStats({
    @Default(<SchoolVolume>[]) List<SchoolVolume> schools,
    @Default(PlatformTotals()) PlatformTotals totals,
    @Default('') String updatedAt,
  }) = _PlatformStats;

  factory PlatformStats.fromJson(Map<String, dynamic> json) => _$PlatformStatsFromJson(json);
}

@freezed
abstract class SchoolVolume with _$SchoolVolume {
  const factory SchoolVolume({
    @Default('') String schoolId,
    @Default('') String name,
    @Default('') String city,
    @Default(true) bool active,
    @Default(0) int members,
    @Default(0) int tickets,
    @Default(0) int open,
    @Default(0) int aspirations,
  }) = _SchoolVolume;

  factory SchoolVolume.fromJson(Map<String, dynamic> json) => _$SchoolVolumeFromJson(json);
}

@freezed
abstract class PlatformTotals with _$PlatformTotals {
  const factory PlatformTotals({
    @Default(0) int schools,
    @Default(0) int activeSchools,
    @Default(0) int members,
    @Default(0) int tickets,
    @Default(0) int aspirations,
  }) = _PlatformTotals;

  factory PlatformTotals.fromJson(Map<String, dynamic> json) => _$PlatformTotalsFromJson(json);
}
