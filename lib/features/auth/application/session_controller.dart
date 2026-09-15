import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors.dart';
import '../../../core/firebase/firebase_providers.dart';
import '../../account/data/account_repository.dart';
import '../../account/domain/account_summary.dart';
import '../../notifications/application/push_controller.dart';
import '../data/auth_repository.dart';

part 'session_controller.g.dart';

sealed class Session {
  const Session();
}

final class SessionLoading extends Session {
  const SessionLoading();
}

final class SignedOut extends Session {
  const SignedOut();
}

final class SessionFailure extends Session {
  const SessionFailure(this.message);

  final String message;
}

final class SignedIn extends Session {
  const SignedIn(this.account);

  final AccountSummary account;
}

/// Status login + profil MANDU. Memantau `users/{uid}.claimsVersion` agar
/// perubahan peran (mis. disetujui admin) langsung berlaku tanpa login ulang.
@Riverpod(keepAlive: true)
class SessionController extends _$SessionController {
  StreamSubscription<User?>? _authSubscription;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _profileSubscription;
  String? _uid;
  int? _claimsVersion;

  @override
  Session build() {
    final auth = ref.watch(firebaseAuthProvider);
    _authSubscription = auth.authStateChanges().listen(_onAuthChanged);
    ref.onDispose(() {
      _authSubscription?.cancel();
      _profileSubscription?.cancel();
    });
    final user = auth.currentUser;
    return user == null || user.isAnonymous ? const SignedOut() : const SessionLoading();
  }

  Future<void> _onAuthChanged(User? user) async {
    if (user != null && user.uid == _uid && state is SignedIn) return;

    await _profileSubscription?.cancel();
    _profileSubscription = null;
    _claimsVersion = null;
    _uid = user?.uid;

    if (user == null || user.isAnonymous) {
      state = const SignedOut();
      return;
    }

    state = const SessionLoading();
    await refresh();
    if (_uid != user.uid) return;
    _profileSubscription = ref
        .read(firestoreProvider)
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .listen(_onProfileChanged, onError: (Object _) {});
  }

  Future<void> _onProfileChanged(DocumentSnapshot<Map<String, dynamic>> snapshot) async {
    final version = (snapshot.data()?['claimsVersion'] as num?)?.toInt();
    if (version == null) return;
    final previous = _claimsVersion;
    _claimsVersion = version;
    if (previous == null || previous == version) return;

    await ref.read(firebaseAuthProvider).currentUser?.getIdToken(true);
    await refresh(silent: true);
  }

  /// Sinkronkan akun dengan server (setelah masuk, bergabung, menyetujui kebijakan, dsb.).
  Future<void> refresh({bool silent = false}) async {
    final auth = ref.read(firebaseAuthProvider);
    final user = auth.currentUser;
    if (user == null || user.isAnonymous) {
      state = const SignedOut();
      return;
    }
    try {
      var account = await ref.read(accountRepositoryProvider).sync();
      if (account.claimsUpdated) {
        await user.getIdToken(true);
        account = account.copyWith(claimsUpdated: false);
      }
      if (auth.currentUser?.uid == user.uid) state = SignedIn(account);
    } catch (error) {
      if (!silent || state is! SignedIn) state = SessionFailure(describeError(error));
    }
  }

  Future<void> signOut() => ref.read(authRepositoryProvider).signOut();
}

@riverpod
AccountSummary? currentAccount(Ref ref) => switch (ref.watch(sessionControllerProvider)) {
      SignedIn(:final account) => account,
      _ => null,
    };

/// Keluar dari aplikasi: lepas token perangkat dahulu (masih memerlukan sesi), lalu keluar dari Firebase Auth.
///
/// Ditulis sebagai fungsi biasa, bukan provider, agar [SessionController] dan `PushController`
/// tidak saling bergantung (Riverpod menolak dependensi melingkar).
Future<void> signOutFromApp(WidgetRef ref) async {
  await ref.read(pushControllerProvider.notifier).unregister();
  await ref.read(sessionControllerProvider.notifier).signOut();
}
