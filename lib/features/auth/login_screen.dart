import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/ui_helpers.dart';
import '../../data/repositories/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  static const _itemCount = 5;
  static const _stagger = Duration(milliseconds: 400);
  static const _fadeDuration = Duration(milliseconds: 600);

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _stagger * (_itemCount - 1) + _fadeDuration,
  );

  late final List<CurvedAnimation> _fades = List.generate(_itemCount, (index) {
    final total = _controller.duration!.inMilliseconds;
    final start = _stagger.inMilliseconds * index;
    return CurvedAnimation(
      parent: _controller,
      curve: Interval(
        start / total,
        (start + _fadeDuration.inMilliseconds) / total,
        curve: Curves.easeOut,
      ),
    );
  });

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    for (final fade in _fades) {
      fade.dispose();
    }
    _controller.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    setState(() => _isLoading = true);
    try {
      await AuthRepository.instance.signInWithGoogle();
      // AuthGate otomatis berpindah ke Home.
    } on GoogleSignInException catch (e) {
      debugPrint('Google sign-in gagal: $e');
      if (mounted) {
        showSnack(
          context,
          e.code == GoogleSignInExceptionCode.canceled
              ? 'Proses login dibatalkan.'
              : 'Gagal masuk: ${e.description ?? e.code.name}',
        );
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase sign-in gagal: $e');
      if (mounted) showSnack(context, 'Autentikasi Firebase gagal');
    } catch (e) {
      debugPrint('Sign-in error: $e');
      if (mounted) showSnack(context, 'Terjadi kesalahan saat masuk');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Text(
        'Selamat Datang,',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      Image.asset(AppAssets.logoLandscape, height: 57),
      Image.asset(AppAssets.onboarding, height: 300),
      const Text(
        'Ayo laporkan segala tindakan perundungan yang kamu alami, '
        'tidak ada tempat untuk Bullying!',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: AppColors.toscaDark),
      ),
      _GoogleSignInButton(isLoading: _isLoading, onPressed: _isLoading ? null : _signIn),
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  for (var i = 0; i < items.length; i++) ...[
                    if (i > 0) const SizedBox(height: 16),
                    FadeTransition(opacity: _fades[i], child: items[i]),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GoogleSignInButton extends StatelessWidget {
  const _GoogleSignInButton({required this.isLoading, required this.onPressed});

  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.textPrimary,
          disabledBackgroundColor: Colors.white70,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        ),
        onPressed: onPressed,
        child: isLoading
            ? const SizedBox.square(
                dimension: 24,
                child: CircularProgressIndicator(strokeWidth: 2.5),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppAssets.icGoogle, width: 24, height: 24),
                  const SizedBox(width: 12),
                  const Text(
                    'Daftar / Masuk',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
      ),
    );
  }
}
