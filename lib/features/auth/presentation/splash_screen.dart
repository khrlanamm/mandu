import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/mandu_logo.dart';
import '../application/session_controller.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionControllerProvider);
    final controller = ref.read(sessionControllerProvider.notifier);

    return Scaffold(
      backgroundColor: ManduColors.blueDeep,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(Gaps.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const ManduLogo(size: 72, showWordmark: false),
                ),
                const SizedBox(height: Gaps.xl),
                const ManduLogo(size: 40, showSymbol: false, tagline: true, onDark: true),
                const SizedBox(height: Gaps.xxl),
                if (session is SessionFailure) ...[
                  Text(
                    session.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  const SizedBox(height: Gaps.lg),
                  FilledButton.tonal(onPressed: controller.refresh, child: const Text('Coba lagi')),
                  const SizedBox(height: Gaps.sm),
                  TextButton(
                    onPressed: () => signOutFromApp(ref),
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    child: const Text('Keluar'),
                  ),
                ] else
                  const SizedBox.square(
                    dimension: 28,
                    child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
