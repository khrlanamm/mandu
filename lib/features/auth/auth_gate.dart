import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/repositories/auth_repository.dart';
import '../home/home_screen.dart';
import 'login_screen.dart';

/// Menampilkan Login atau Home sesuai status Firebase Auth.
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late final Stream<User?> _authChanges = AuthRepository.instance.authStateChanges();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _authChanges,
      initialData: AuthRepository.instance.currentUser,
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user == null) return const LoginScreen();
        return HomeScreen(key: ValueKey(user.uid));
      },
    );
  }
}
