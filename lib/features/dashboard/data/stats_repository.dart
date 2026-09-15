import 'package:cloud_functions/cloud_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/firebase/callable.dart';
import '../../../core/firebase/firebase_providers.dart';
import '../domain/school_stats.dart';

part 'stats_repository.g.dart';

class StatsRepository {
  const StatsRepository(this._functions);

  final FirebaseFunctions _functions;

  Future<SchoolStats> school(String schoolId, {int months = 6}) async =>
      SchoolStats.fromJson(await _functions.callMap('stats-school', {'schoolId': schoolId, 'months': months}));

  Future<PlatformStats> platform() async => PlatformStats.fromJson(await _functions.callMap('stats-platform'));
}

@Riverpod(keepAlive: true)
StatsRepository statsRepository(Ref ref) => StatsRepository(ref.watch(functionsProvider));

@riverpod
Future<SchoolStats> schoolStats(Ref ref, String schoolId, {int months = 6}) =>
    ref.watch(statsRepositoryProvider).school(schoolId, months: months);

@riverpod
Future<PlatformStats> platformStats(Ref ref) => ref.watch(statsRepositoryProvider).platform();
