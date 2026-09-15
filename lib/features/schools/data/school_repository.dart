import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/firebase/callable.dart';
import '../../../core/firebase/firebase_providers.dart';
import '../domain/public_school.dart';
import '../domain/school.dart';

part 'school_repository.g.dart';

class SchoolRepository {
  const SchoolRepository(this._functions, this._firestore);

  final FirebaseFunctions _functions;
  final FirebaseFirestore _firestore;

  Future<PublicSchool> lookup(String code) async =>
      PublicSchool.fromJson(await _functions.callMap('schools-lookup', {'code': code.trim().toUpperCase()}));

  Future<({String schoolId, String code})> create({
    required String name,
    required String level,
    required String city,
    required String province,
    String? npsn,
    String? address,
    String? code,
    List<String> allowedDomains = const [],
  }) async {
    final result = await _functions.callMap('schools-create', {
      'name': name,
      'level': level,
      'city': city,
      'province': province,
      if (npsn != null && npsn.isNotEmpty) 'npsn': npsn,
      if (address != null && address.isNotEmpty) 'address': address,
      if (code != null && code.isNotEmpty) 'code': code,
      if (allowedDomains.isNotEmpty) 'allowedDomains': allowedDomains,
    });
    return (schoolId: result['schoolId'] as String, code: result['code'] as String);
  }

  /// Ubah pengaturan sekolah; [changes] memakai nama field `schools-update`.
  Future<void> update(String schoolId, Map<String, Object?> changes) =>
      _functions.callMap('schools-update', {'schoolId': schoolId, ...changes});

  Future<String> changeCode(String schoolId, {String? code}) async {
    final result = await _functions.callMap('schools-changeCode', {
      'schoolId': schoolId,
      if (code != null && code.isNotEmpty) 'code': code,
    });
    return result['code'] as String;
  }

  Stream<School?> watchSchool(String schoolId) => _firestore
      .collection('schools')
      .doc(schoolId)
      .snapshots()
      .map((snapshot) => snapshot.exists ? School.fromJson(docWithId(snapshot)) : null);

  Stream<List<SchoolUnit>> watchUnits(String schoolId) => _firestore
      .collection('schools')
      .doc(schoolId)
      .collection('units')
      .snapshots()
      .map((query) => query.docs.map((doc) => SchoolUnit.fromJson(docWithId(doc))).toList()
        ..sort((a, b) => a.name.compareTo(b.name)));

  Stream<List<School>> watchAllSchools() => _firestore
      .collection('schools')
      .orderBy('name')
      .snapshots()
      .map((query) => query.docs.map((doc) => School.fromJson(docWithId(doc))).toList());
}

@Riverpod(keepAlive: true)
SchoolRepository schoolRepository(Ref ref) =>
    SchoolRepository(ref.watch(functionsProvider), ref.watch(firestoreProvider));

/// Informasi publik sekolah dari kode (aspirasi tanpa login).
@riverpod
Future<PublicSchool> publicSchool(Ref ref, String code) => ref.watch(schoolRepositoryProvider).lookup(code);

@riverpod
Stream<School?> schoolDoc(Ref ref, String schoolId) => ref.watch(schoolRepositoryProvider).watchSchool(schoolId);

@riverpod
Stream<List<SchoolUnit>> schoolUnits(Ref ref, String schoolId) =>
    ref.watch(schoolRepositoryProvider).watchUnits(schoolId);

@riverpod
Stream<List<School>> allSchools(Ref ref) => ref.watch(schoolRepositoryProvider).watchAllSchools();
