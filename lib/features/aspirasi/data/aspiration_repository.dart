import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/firebase/callable.dart';
import '../../../core/firebase/firebase_providers.dart';
import '../../auth/application/session_controller.dart';
import '../domain/aspiration.dart';

part 'aspiration_repository.g.dart';

enum BoardSort { popular, newest }

class AspirationRepository {
  const AspirationRepository(this._functions, this._firestore);

  final FirebaseFunctions _functions;
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _aspirations(String schoolId) =>
      _firestore.collection('schools').doc(schoolId).collection('aspirations');

  Future<({String aspirationId, String number, bool flagged})> submit(String schoolId, AspirationDraft draft) async {
    final data = await _functions.callMap('aspirations-submit', {
      'schoolId': schoolId,
      'anonymous': draft.anonymous,
      ...draft.toJson(),
    });
    return (
      aspirationId: data['aspirationId'] as String,
      number: data['number'] as String,
      flagged: data['flagged'] as bool? ?? false,
    );
  }

  /// Aspirasi tamu tanpa login lewat kode sekolah.
  Future<({String number, String schoolName, bool flagged})> submitPublic(String code, AspirationDraft draft) async {
    final data = await _functions.callMap('aspirations-submitPublic', {'code': code.trim().toUpperCase(), ...draft.toJson()});
    return (
      number: data['number'] as String,
      schoolName: data['schoolName'] as String,
      flagged: data['flagged'] as bool? ?? false,
    );
  }

  Future<void> review({
    required String schoolId,
    required String aspirationId,
    AspirationStatus? status,
    String? response,
    BoardState? board,
  }) =>
      _functions.callMap('aspirations-review', {
        'schoolId': schoolId,
        'aspirationId': aspirationId,
        'status': ?status?.wire,
        'response': ?(response == null || response.trim().isEmpty ? null : response.trim()),
        'board': ?board?.name,
      });

  Future<int> support({required String schoolId, required String aspirationId, required bool support}) async {
    final data = await _functions.callMap('aspirations-support', {
      'schoolId': schoolId,
      'aspirationId': aspirationId,
      'support': support,
    });
    return (data['supportCount'] as num).toInt();
  }

  Stream<Aspiration?> watchAspiration(String schoolId, String id) => _aspirations(schoolId)
      .doc(id)
      .snapshots()
      .map((snapshot) => snapshot.exists ? Aspiration.fromJson(docWithId(snapshot)) : null);

  Stream<List<Aspiration>> watchBoard(String schoolId, BoardSort sort) => _aspirations(schoolId)
      .where('board', isEqualTo: BoardState.published.name)
      .orderBy(sort == BoardSort.popular ? 'supportCount' : 'publishedAt', descending: true)
      .limit(100)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Aspiration.fromJson(docWithId(doc))).toList());

  /// Kotak masuk staf (admin, pimpinan, Tim Verifikasi).
  Stream<List<Aspiration>> watchInbox(String schoolId) => _aspirations(schoolId)
      .orderBy('createdAt', descending: true)
      .limit(300)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Aspiration.fromJson(docWithId(doc))).toList());

  Stream<List<AspirationOwner>> watchOwned(String schoolId, String uid) => _firestore
      .collection('schools')
      .doc(schoolId)
      .collection('aspirationOwners')
      .where('uid', isEqualTo: uid)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => AspirationOwner.fromJson(docWithId(doc))).toList());

  Stream<AspirationIdentity?> watchIdentity(String schoolId, String id) => _aspirations(schoolId)
      .doc(id)
      .collection('private')
      .doc('identity')
      .snapshots()
      .map((snapshot) => snapshot.exists ? AspirationIdentity.fromJson(snapshot.data()!) : null);

  Stream<bool> watchSupported(String schoolId, String id, String uid) =>
      _aspirations(schoolId).doc(id).collection('supports').doc(uid).snapshots().map((snapshot) => snapshot.exists);
}

@Riverpod(keepAlive: true)
AspirationRepository aspirationRepository(Ref ref) =>
    AspirationRepository(ref.watch(functionsProvider), ref.watch(firestoreProvider));

@riverpod
Stream<Aspiration?> aspiration(Ref ref, String schoolId, String aspirationId) =>
    ref.watch(aspirationRepositoryProvider).watchAspiration(schoolId, aspirationId);

@riverpod
Stream<List<Aspiration>> aspirationBoard(Ref ref, String schoolId, BoardSort sort) =>
    ref.watch(aspirationRepositoryProvider).watchBoard(schoolId, sort);

@riverpod
Stream<List<Aspiration>> aspirationInbox(Ref ref, String schoolId) =>
    ref.watch(aspirationRepositoryProvider).watchInbox(schoolId);

@riverpod
Stream<AspirationIdentity?> aspirationIdentity(Ref ref, String schoolId, String aspirationId) =>
    ref.watch(aspirationRepositoryProvider).watchIdentity(schoolId, aspirationId);

@riverpod
Stream<List<AspirationOwner>> myAspirations(Ref ref) {
  final account = ref.watch(currentAccountProvider);
  if (account?.schoolId == null) return Stream.value(const []);
  return ref.watch(aspirationRepositoryProvider).watchOwned(account!.schoolId!, account.uid);
}

@riverpod
Stream<bool> aspirationSupported(Ref ref, String schoolId, String aspirationId) {
  final uid = ref.watch(currentAccountProvider)?.uid;
  if (uid == null) return Stream.value(false);
  return ref.watch(aspirationRepositoryProvider).watchSupported(schoolId, aspirationId, uid);
}
