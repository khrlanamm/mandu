import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/firebase/callable.dart';
import '../../../core/firebase/firebase_providers.dart';
import '../../auth/application/session_controller.dart';
import '../domain/app_notification.dart';

part 'notification_repository.g.dart';

class NotificationRepository {
  const NotificationRepository(this._firestore, this._functions);

  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;

  CollectionReference<Map<String, dynamic>> _inbox(String uid) =>
      _firestore.collection('users').doc(uid).collection('notifications');

  Stream<List<AppNotification>> watchInbox(String uid) => _inbox(uid)
      .orderBy('createdAt', descending: true)
      .limit(100)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => AppNotification.fromJson(docWithId(doc))).toList());

  Future<void> markRead(String uid, String id) => _inbox(uid).doc(id).update({'read': true});

  Future<void> markAllRead(String uid, Iterable<String> ids) async {
    final batch = _firestore.batch();
    for (final id in ids) {
      batch.update(_inbox(uid).doc(id), {'read': true});
    }
    await batch.commit();
  }

  Future<void> delete(String uid, String id) => _inbox(uid).doc(id).delete();

  Future<void> registerDevice({required String token, required String platform}) =>
      _functions.callMap('account-registerDevice', {'token': token, 'platform': platform});

  Future<void> unregisterDevice(String token) => _functions.callMap('account-unregisterDevice', {'token': token});
}

@Riverpod(keepAlive: true)
NotificationRepository notificationRepository(Ref ref) =>
    NotificationRepository(ref.watch(firestoreProvider), ref.watch(functionsProvider));

@riverpod
Stream<List<AppNotification>> inbox(Ref ref) {
  final uid = ref.watch(currentAccountProvider)?.uid;
  if (uid == null) return Stream.value(const []);
  return ref.watch(notificationRepositoryProvider).watchInbox(uid);
}

@riverpod
int unreadNotificationCount(Ref ref) =>
    ref.watch(inboxProvider).value?.where((notification) => !notification.read).length ?? 0;
