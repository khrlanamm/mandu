import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  AuthRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  static final instance = AuthRepository();

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  User? get currentUser => _auth.currentUser;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  /// Login Google lewat Credential Manager, lalu tukar ID token ke Firebase Auth.
  /// Melempar [GoogleSignInException] (mis. dibatalkan) atau [FirebaseAuthException].
  Future<UserCredential> signInWithGoogle() async {
    final account = await _googleSignIn.authenticate();
    final idToken = account.authentication.idToken;
    if (idToken == null) {
      throw FirebaseAuthException(
        code: 'missing-id-token',
        message: 'Token Google tidak ditemukan.',
      );
    }
    return _auth.signInWithCredential(GoogleAuthProvider.credential(idToken: idToken));
  }

  Future<void> signOut() async {
    try {
      // Membersihkan status kredensial agar akun bisa dipilih ulang saat login berikutnya.
      await _googleSignIn.signOut();
    } catch (e) {
      debugPrint('Gagal sign out Google: $e');
    }
    await _auth.signOut();
  }

  /// Admin ditandai dengan adanya dokumen `admins/{uid}`.
  Future<bool> isAdmin([String? uid]) async {
    final userId = uid ?? _auth.currentUser?.uid;
    if (userId == null || userId.isEmpty) return false;
    try {
      final doc = await _firestore.collection('admins').doc(userId).get();
      return doc.exists;
    } on FirebaseException catch (e) {
      debugPrint('Gagal cek status admin $userId: $e');
      return false;
    }
  }

  Future<void> saveAdminFcmToken(String uid, String token) {
    return _firestore.collection('admins').doc(uid).update({'fcmToken': token});
  }
}
