// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(statsRepository)
final statsRepositoryProvider = StatsRepositoryProvider._();

final class StatsRepositoryProvider
    extends
        $FunctionalProvider<StatsRepository, StatsRepository, StatsRepository>
    with $Provider<StatsRepository> {
  StatsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statsRepositoryHash();

  @$internal
  @override
  $ProviderElement<StatsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StatsRepository create(Ref ref) {
    return statsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StatsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StatsRepository>(value),
    );
  }
}

String _$statsRepositoryHash() => r'85fb477a126a220f414fe01a5ffbabae6a702024';

@ProviderFor(schoolStats)
final schoolStatsProvider = SchoolStatsFamily._();

final class SchoolStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<SchoolStats>,
          SchoolStats,
          FutureOr<SchoolStats>
        >
    with $FutureModifier<SchoolStats>, $FutureProvider<SchoolStats> {
  SchoolStatsProvider._({
    required SchoolStatsFamily super.from,
    required (String, {int months}) super.argument,
  }) : super(
         retry: null,
         name: r'schoolStatsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$schoolStatsHash();

  @override
  String toString() {
    return r'schoolStatsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<SchoolStats> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SchoolStats> create(Ref ref) {
    final argument = this.argument as (String, {int months});
    return schoolStats(ref, argument.$1, months: argument.months);
  }

  @override
  bool operator ==(Object other) {
    return other is SchoolStatsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$schoolStatsHash() => r'2887e7c6510fe9da716d87bd449c53c586f3629e';

final class SchoolStatsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<SchoolStats>,
          (String, {int months})
        > {
  SchoolStatsFamily._()
    : super(
        retry: null,
        name: r'schoolStatsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SchoolStatsProvider call(String schoolId, {int months = 6}) =>
      SchoolStatsProvider._(argument: (schoolId, months: months), from: this);

  @override
  String toString() => r'schoolStatsProvider';
}

@ProviderFor(platformStats)
final platformStatsProvider = PlatformStatsProvider._();

final class PlatformStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<PlatformStats>,
          PlatformStats,
          FutureOr<PlatformStats>
        >
    with $FutureModifier<PlatformStats>, $FutureProvider<PlatformStats> {
  PlatformStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'platformStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$platformStatsHash();

  @$internal
  @override
  $FutureProviderElement<PlatformStats> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PlatformStats> create(Ref ref) {
    return platformStats(ref);
  }
}

String _$platformStatsHash() => r'a0f0870002af061c0a6fb85124becc3bd9f33d05';
