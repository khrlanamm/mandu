import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/roles.dart';
import '../../../core/firebase/callable.dart';
import '../../../core/firebase/firebase_providers.dart';
import '../domain/member.dart';
import '../domain/student_import.dart';

part 'membership_repository.g.dart';

typedef JoinResult = ({String status, String schoolId, String schoolName});
typedef InviteResult = ({String invitationId, String status, String? passwordSetupLink});

class MembershipRepository {
  const MembershipRepository(this._functions, this._firestore);

  final FirebaseFunctions _functions;
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _members(String schoolId) =>
      _firestore.collection('schools').doc(schoolId).collection('members');

  Future<JoinResult> join({required String code, required String displayName, required String kelas, String? nisn}) async {
    final data = await _functions.callMap('members-join', {
      'code': code,
      'displayName': displayName,
      'kelas': kelas,
      if (nisn != null && nisn.isNotEmpty) 'nisn': nisn,
    });
    return (status: data['status'] as String, schoolId: data['schoolId'] as String, schoolName: data['schoolName'] as String);
  }

  Future<void> cancelJoin() => _functions.callMap('members-cancelJoin');

  Stream<Member?> watchMember(String schoolId, String uid) => _members(schoolId)
      .doc(uid)
      .snapshots()
      .map((snapshot) => snapshot.exists ? Member.fromJson(snapshot.data()!) : null);

  /// Anggota sekolah, diurutkan berdasarkan nama. [status] null = semua status.
  Stream<List<Member>> watchMembers(String schoolId, {MemberStatus? status}) {
    Query<Map<String, dynamic>> query = _members(schoolId);
    if (status != null) query = query.where('status', isEqualTo: status.name);
    return query.snapshots().map((snapshot) => snapshot.docs.map((doc) => Member.fromJson(doc.data())).toList()
      ..sort((a, b) => a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase())));
  }

  Stream<List<Invitation>> watchPendingInvitations(String schoolId) => _firestore
      .collection('invitations')
      .where('schoolId', isEqualTo: schoolId)
      .where('status', isEqualTo: 'pending')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Invitation.fromJson(docWithId(doc))).toList());

  Future<({List<String> updated, List<String> skipped})> review({
    required String schoolId,
    required List<String> uids,
    required bool approve,
    String? reason,
  }) async {
    final data = await _functions.callMap('members-review', {
      'schoolId': schoolId,
      'uids': uids,
      'approve': approve,
      if (reason != null && reason.isNotEmpty) 'reason': reason,
    });
    return (
      updated: (data['updated'] as List? ?? const []).cast<String>(),
      skipped: (data['skipped'] as List? ?? const []).cast<String>(),
    );
  }

  Future<void> updateMember({
    required String schoolId,
    required String uid,
    SchoolRole? role,
    List<String>? units,
    bool? canVerify,
    String? kelas,
    String? displayName,
  }) =>
      _functions.callMap('members-update', {
        'schoolId': schoolId,
        'uid': uid,
        'role': ?role?.name,
        'units': ?units,
        'canVerify': ?canVerify,
        'kelas': ?kelas,
        'displayName': ?displayName,
      });

  Future<void> removeMember({required String schoolId, required String uid}) =>
      _functions.callMap('members-remove', {'schoolId': schoolId, 'uid': uid});

  Future<InviteResult> invite({
    required String schoolId,
    required String email,
    required SchoolRole role,
    String? displayName,
    List<String> units = const [],
    bool canVerify = false,
    bool createAccount = false,
  }) async {
    final data = await _functions.callMap('members-invite', {
      'schoolId': schoolId,
      'email': email,
      'role': role.name,
      if (displayName != null && displayName.isNotEmpty) 'displayName': displayName,
      'units': units,
      'canVerify': canVerify,
      'createAccount': createAccount,
    });
    return (
      invitationId: data['invitationId'] as String,
      status: data['status'] as String,
      passwordSetupLink: data['passwordSetupLink'] as String?,
    );
  }

  Future<void> revokeInvitation(String invitationId) =>
      _functions.callMap('members-revokeInvitation', {'invitationId': invitationId});

  /// Impor bertahap per 300 siswa (batas satu panggilan).
  Future<List<StudentImportResult>> importStudents(String schoolId, List<StudentInput> students) async {
    final results = <StudentImportResult>[];
    for (var start = 0; start < students.length; start += 300) {
      final chunk = students.sublist(start, start + 300 > students.length ? students.length : start + 300);
      final data = await _functions.callMap('members-importStudents', {
        'schoolId': schoolId,
        'students': [for (final student in chunk) student.toJson()],
      });
      for (final row in data['results'] as List? ?? const []) {
        results.add(StudentImportResult.fromJson(jsonMap(row)));
      }
    }
    return results;
  }

  Future<String> resetStudentPassword({required String schoolId, required String uid}) async {
    final data = await _functions.callMap('members-resetStudentPassword', {'schoolId': schoolId, 'uid': uid});
    return data['password'] as String;
  }
}

@Riverpod(keepAlive: true)
MembershipRepository membershipRepository(Ref ref) =>
    MembershipRepository(ref.watch(functionsProvider), ref.watch(firestoreProvider));

@riverpod
Stream<Member?> ownMembership(Ref ref, String schoolId, String uid) =>
    ref.watch(membershipRepositoryProvider).watchMember(schoolId, uid);

@riverpod
Stream<Member?> schoolMember(Ref ref, String schoolId, String uid) =>
    ref.watch(membershipRepositoryProvider).watchMember(schoolId, uid);

@riverpod
Stream<List<Member>> schoolMembers(Ref ref, String schoolId, {MemberStatus? status}) =>
    ref.watch(membershipRepositoryProvider).watchMembers(schoolId, status: status);

@riverpod
Stream<List<Invitation>> pendingInvitations(Ref ref, String schoolId) =>
    ref.watch(membershipRepositoryProvider).watchPendingInvitations(schoolId);
