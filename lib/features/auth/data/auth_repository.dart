import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../app/env.dart';
import '../../../core/errors.dart';
import '../../../core/firebase/firebase_providers.dart';

part 'auth_repository.g.dart';

/// Email sintetis akun NISN (sama dengan nisnEmail di functions/src/core/ids.ts).
String nisnEmail(String schoolId, String nisn) => '$schoolId.${nisn.trim()}@${Env.nisnEmailDomain}';

class AuthRepository {
  const AuthRepository(this._auth);

  final FirebaseAuth _auth;

  Future<void> signInWithGoogle() async {
    if (kIsWeb) {
      await _auth.signInWithPopup(GoogleAuthProvider());
      return;
    }
    final account = await GoogleSignIn.instance.authenticate();
    final idToken = account.authentication.idToken;
    if (idToken == null) throw const AppException('Token Google tidak diterima. Coba lagi.');
    await _auth.signInWithCredential(GoogleAuthProvider.credential(idToken: idToken));
  }

  Future<void> signInWithNisn({required String schoolId, required String nisn, required String password}) =>
      _auth.signInWithEmailAndPassword(email: nisnEmail(schoolId, nisn), password: password);

  Future<void> signInWithEmail(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email.trim().toLowerCase(), password: password);

  /// Masuk ulang setelah password diganti di server.
  Future<void> signInAgain(String password) async {
    final email = _auth.currentUser?.email;
    if (email == null) throw const AppException('Sesi berakhir. Silakan masuk kembali.');
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> sendPasswordReset(String email) => _auth.sendPasswordResetEmail(email: email.trim());

  Future<void> signOut() async {
    final usedGoogle = _auth.currentUser?.providerData.any((provider) => provider.providerId == 'google.com') ?? false;
    // Credential Manager bisa lama merespons; akun email/NISN tidak perlu membersihkannya.
    if (!kIsWeb && usedGoogle) {
      try {
        await GoogleSignIn.instance.signOut().timeout(const Duration(seconds: 5));
      } catch (error) {
        debugPrint('Sign out Google gagal: $error');
      }
    }
    await _auth.signOut();
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => AuthRepository(ref.watch(firebaseAuthProvider));
