import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../errors.dart';
import '../palette.dart';
import '../tokens.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            const SizedBox(height: Gaps.lg),
            Text(message!, style: context.textStyles.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant)),
          ],
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.icon, required this.title, this.message, this.action, this.tone});

  final IconData icon;
  final String title;
  final String? message;
  final Widget? action;
  final ToneColors? tone;

  @override
  Widget build(BuildContext context) {
    final colors = tone ?? context.palette.info;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Gaps.xl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 380),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(color: colors.container, shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(Gaps.lg + 2),
                  child: Icon(icon, size: 32, color: colors.main),
                ),
              ),
              const SizedBox(height: Gaps.lg),
              Text(title, textAlign: TextAlign.center, style: context.textStyles.titleMedium),
              if (message != null) ...[
                const SizedBox(height: Gaps.sm),
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: context.textStyles.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
                ),
              ],
              if (action != null) ...[const SizedBox(height: Gaps.xl), action!],
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorState extends StatelessWidget {
  const ErrorState({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.cloud_off_rounded,
      title: 'Gagal memuat',
      message: message,
      tone: context.palette.danger,
      action: onRetry == null ? null : FilledButton.tonal(onPressed: onRetry, child: const Text('Coba lagi')),
    );
  }
}

/// Tampilan standar untuk AsyncValue: memuat, gagal, atau data.
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({super.key, required this.value, required this.data, this.onRetry, this.loading});

  final AsyncValue<T> value;
  final Widget Function(T value) data;
  final VoidCallback? onRetry;
  final Widget? loading;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => loading ?? const LoadingView(),
      error: (error, _) => ErrorState(message: describeError(error), onRetry: onRetry),
    );
  }
}
