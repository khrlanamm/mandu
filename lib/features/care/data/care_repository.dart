import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/roles.dart';
import '../../../core/files/pending_attachment.dart';
import '../../../core/firebase/callable.dart';
import '../../../core/firebase/firebase_providers.dart';
import '../../auth/application/session_controller.dart';
import '../domain/care.dart';

part 'care_repository.g.dart';

typedef Counselor = ({String uid, String name});

class CareRepository {
  const CareRepository(this._functions, this._firestore, this._storage);

  final FirebaseFunctions _functions;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  CollectionReference<Map<String, dynamic>> _school(String schoolId, String collection) =>
      _firestore.collection('schools').doc(schoolId).collection(collection);

  // ---------- Butuh Bantuan ----------

  Future<({String requestId, String number})> requestHelp(String schoolId, HelpDraft draft) async {
    final data = await _functions.callMap('help-request', {
      'schoolId': schoolId,
      'needs': draft.needs,
      'urgency': draft.urgency.name,
      'contactMethod': draft.contactMethod.name,
      'contactTime': draft.contactTime.wire,
      'whatsapp': ?(draft.whatsapp == null || draft.whatsapp!.trim().isEmpty ? null : draft.whatsapp!.replaceAll(RegExp(r'[\s-]'), '')),
      'note': ?(draft.note == null || draft.note!.trim().isEmpty ? null : draft.note!.trim()),
    });
    return (requestId: data['requestId'] as String, number: data['number'] as String);
  }

  Future<String?> claimHelp({required String schoolId, required String requestId}) async {
    final data = await _functions.callMap('help-claim', {'schoolId': schoolId, 'requestId': requestId});
    return data['conversationId'] as String?;
  }

  Future<void> closeHelp({required String schoolId, required String requestId, required String note}) =>
      _functions.callMap('help-close', {'schoolId': schoolId, 'requestId': requestId, 'note': note.trim()});

  Future<void> cancelHelp({required String schoolId, required String requestId}) =>
      _functions.callMap('help-cancel', {'schoolId': schoolId, 'requestId': requestId});

  Stream<List<HelpRequest>> watchMyHelpRequests(String schoolId, String uid) => _school(schoolId, 'helpRequests')
      .where('studentUid', isEqualTo: uid)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => HelpRequest.fromJson(docWithId(doc))).toList());

  /// Antrean untuk konselor: semua permintaan bantuan sekolah.
  Stream<List<HelpRequest>> watchHelpQueue(String schoolId) => _school(schoolId, 'helpRequests')
      .orderBy('createdAt', descending: true)
      .limit(200)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => HelpRequest.fromJson(docWithId(doc))).toList());

  Stream<HelpRequest?> watchHelpRequest(String schoolId, String requestId) => _school(schoolId, 'helpRequests')
      .doc(requestId)
      .snapshots()
      .map((snapshot) => snapshot.exists ? HelpRequest.fromJson(docWithId(snapshot)) : null);

  // ---------- Curhat ----------

  Future<List<Counselor>> counselors(String schoolId) async {
    final data = await _functions.callMap('curhat-counselors', {'schoolId': schoolId});
    return [
      for (final item in data['counselors'] as List? ?? const [])
        (uid: jsonMap(item)['uid'] as String, name: jsonMap(item)['name'] as String),
    ];
  }

  Future<String> startConversation({
    required String schoolId,
    String? counselorUid,
    String? alias,
    String? topic,
    required String message,
  }) async {
    final data = await _functions.callMap('curhat-start', {
      'schoolId': schoolId,
      'counselorUid': counselorUid,
      'alias': ?(alias == null || alias.trim().isEmpty ? null : alias.trim()),
      'topic': ?(topic == null || topic.trim().isEmpty ? null : topic.trim()),
      'message': message.trim(),
    });
    return data['conversationId'] as String;
  }

  Future<void> claimConversation({required String schoolId, required String conversationId}) =>
      _functions.callMap('curhat-claim', {'schoolId': schoolId, 'conversationId': conversationId});

  Future<void> closeConversation({required String schoolId, required String conversationId}) =>
      _functions.callMap('curhat-close', {'schoolId': schoolId, 'conversationId': conversationId});

  Future<void> revealIdentity({required String schoolId, required String conversationId}) =>
      _functions.callMap('curhat-reveal', {'schoolId': schoolId, 'conversationId': conversationId});

  Future<void> proposeMeeting({
    required String schoolId,
    required String conversationId,
    required DateTime at,
    required String place,
  }) =>
      _functions.callMap('curhat-proposeMeeting', {
        'schoolId': schoolId,
        'conversationId': conversationId,
        'at': at.toUtc().toIso8601String(),
        'place': place.trim(),
      });

  Future<void> respondMeeting({required String schoolId, required String conversationId, required bool accept}) =>
      _functions.callMap('curhat-respondMeeting', {'schoolId': schoolId, 'conversationId': conversationId, 'accept': accept});

  /// Pesan ditulis langsung ke Firestore (diizinkan security rules), lalu trigger memperbarui ringkasan.
  Future<void> sendMessage({
    required String schoolId,
    required String conversationId,
    required String uid,
    required MessageRole role,
    String text = '',
    String? imagePath,
  }) =>
      _school(schoolId, 'conversations').doc(conversationId).collection('messages').add({
        'senderUid': uid,
        'senderRole': role.name,
        'text': text.trim(),
        'imagePath': imagePath,
        'createdAt': FieldValue.serverTimestamp(),
      });

  Future<String> uploadChatImage({
    required String schoolId,
    required String conversationId,
    required PendingAttachment file,
  }) async {
    final safeName = file.name.replaceAll(RegExp(r'[^A-Za-z0-9._-]'), '_');
    final path = 'schools/$schoolId/conversations/$conversationId/${DateTime.now().millisecondsSinceEpoch}_$safeName';
    await _storage.ref(path).putData(file.bytes, SettableMetadata(contentType: file.contentType));
    return path;
  }

  Future<void> markRead({required String schoolId, required String conversationId, required bool asStudent}) =>
      _school(schoolId, 'conversations').doc(conversationId).update({asStudent ? 'unreadStudent' : 'unreadCounselor': 0});

  Future<void> addCaseNote({
    required String schoolId,
    required String conversationId,
    required String text,
    required String riskLevel,
    required String authorName,
  }) =>
      _school(schoolId, 'conversations').doc(conversationId).collection('caseNotes').add({
        'text': text.trim(),
        'riskLevel': riskLevel,
        'authorName': authorName,
        'createdAt': FieldValue.serverTimestamp(),
      });

  Stream<Conversation?> watchConversation(String schoolId, String conversationId) => _school(schoolId, 'conversations')
      .doc(conversationId)
      .snapshots()
      .map((snapshot) => snapshot.exists ? Conversation.fromJson(docWithId(snapshot)) : null);

  Stream<List<Conversation>> watchStudentConversations(String schoolId, String uid) => _school(schoolId, 'conversations')
      .where('studentUid', isEqualTo: uid)
      .orderBy('updatedAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Conversation.fromJson(docWithId(doc))).toList());

  Stream<List<Conversation>> watchCounselorConversations(String schoolId, String uid) => _school(schoolId, 'conversations')
      .where('counselorUid', isEqualTo: uid)
      .orderBy('updatedAt', descending: true)
      .limit(200)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Conversation.fromJson(docWithId(doc))).toList());

  /// Percakapan yang belum diambil konselor mana pun.
  Stream<List<Conversation>> watchWaitingConversations(String schoolId) => _school(schoolId, 'conversations')
      .where('counselorUid', isNull: true)
      .orderBy('createdAt', descending: true)
      .limit(100)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Conversation.fromJson(docWithId(doc))).toList());

  Stream<List<ChatMessage>> watchMessages(String schoolId, String conversationId) => _school(schoolId, 'conversations')
      .doc(conversationId)
      .collection('messages')
      .orderBy('createdAt')
      .limit(500)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => ChatMessage.fromJson(docWithId(doc))).toList());

  Stream<List<CaseNote>> watchCaseNotes(String schoolId, String conversationId) => _school(schoolId, 'conversations')
      .doc(conversationId)
      .collection('caseNotes')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => CaseNote.fromJson(docWithId(doc))).toList());

  Future<String> imageUrl(String path) => _storage.ref(path).getDownloadURL();
}

@Riverpod(keepAlive: true)
CareRepository careRepository(Ref ref) =>
    CareRepository(ref.watch(functionsProvider), ref.watch(firestoreProvider), ref.watch(storageProvider));

@riverpod
Stream<List<HelpRequest>> myHelpRequests(Ref ref) {
  final account = ref.watch(currentAccountProvider);
  if (account?.schoolId == null) return Stream.value(const []);
  return ref.watch(careRepositoryProvider).watchMyHelpRequests(account!.schoolId!, account.uid);
}

@riverpod
Stream<List<HelpRequest>> helpQueue(Ref ref) {
  final account = ref.watch(currentAccountProvider);
  if (account?.schoolId == null || account?.role != SchoolRole.konselor) return Stream.value(const []);
  return ref.watch(careRepositoryProvider).watchHelpQueue(account!.schoolId!);
}

@riverpod
Stream<HelpRequest?> helpRequest(Ref ref, String schoolId, String requestId) =>
    ref.watch(careRepositoryProvider).watchHelpRequest(schoolId, requestId);

@riverpod
Future<List<Counselor>> counselorList(Ref ref, String schoolId) => ref.watch(careRepositoryProvider).counselors(schoolId);

@riverpod
Stream<Conversation?> conversation(Ref ref, String schoolId, String conversationId) =>
    ref.watch(careRepositoryProvider).watchConversation(schoolId, conversationId);

@riverpod
Stream<List<Conversation>> myConversations(Ref ref) {
  final account = ref.watch(currentAccountProvider);
  if (account?.schoolId == null) return Stream.value(const []);
  return ref.watch(careRepositoryProvider).watchStudentConversations(account!.schoolId!, account.uid);
}

@riverpod
Stream<List<Conversation>> counselorConversations(Ref ref) {
  final account = ref.watch(currentAccountProvider);
  if (account?.schoolId == null || account?.role != SchoolRole.konselor) return Stream.value(const []);
  return ref.watch(careRepositoryProvider).watchCounselorConversations(account!.schoolId!, account.uid);
}

@riverpod
Stream<List<Conversation>> waitingConversations(Ref ref) {
  final account = ref.watch(currentAccountProvider);
  if (account?.schoolId == null || account?.role != SchoolRole.konselor) return Stream.value(const []);
  return ref.watch(careRepositoryProvider).watchWaitingConversations(account!.schoolId!);
}

@riverpod
Stream<List<ChatMessage>> conversationMessages(Ref ref, String schoolId, String conversationId) =>
    ref.watch(careRepositoryProvider).watchMessages(schoolId, conversationId);

@riverpod
Stream<List<CaseNote>> caseNotes(Ref ref, String schoolId, String conversationId) =>
    ref.watch(careRepositoryProvider).watchCaseNotes(schoolId, conversationId);

@riverpod
Future<String> chatImageUrl(Ref ref, String path) => ref.watch(careRepositoryProvider).imageUrl(path);

/// Jumlah hal yang menunggu konselor (badge tab Tugas).
@riverpod
int counselorPendingCount(Ref ref) {
  final help = ref.watch(helpQueueProvider).value?.where((request) => request.status == HelpStatus.menunggu).length ?? 0;
  final waiting = ref.watch(waitingConversationsProvider).value?.length ?? 0;
  final unread = ref
          .watch(counselorConversationsProvider)
          .value
          ?.where((conversation) => conversation.unreadCounselor > 0)
          .length ??
      0;
  return help + waiting + unread;
}
