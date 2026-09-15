import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/mandu_logo.dart';
import '../../../core/design/widgets/states.dart';
import '../../../core/errors.dart';
import '../../schools/data/school_repository.dart';
import '../../schools/domain/public_school.dart';
import '../data/aspiration_repository.dart';
import 'widgets/aspiration_widgets.dart';

/// Aspirasi tanpa login lewat kode/QR sekolah: `/s/{kode}/aspirasi`.
class PublicAspirationScreen extends ConsumerStatefulWidget {
  const PublicAspirationScreen({super.key, required this.code});

  final String code;

  @override
  ConsumerState<PublicAspirationScreen> createState() => _PublicAspirationScreenState();
}

class _PublicAspirationScreenState extends ConsumerState<PublicAspirationScreen> {
  ({String number, String schoolName})? _sent;
  int _formVersion = 0;

  void _close() => context.canPop() ? context.pop() : context.go(Routes.welcome);

  @override
  Widget build(BuildContext context) {
    final school = ref.watch(publicSchoolProvider(widget.code));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(tooltip: 'Tutup', icon: const Icon(Icons.close_rounded), onPressed: _close),
        title: const ManduLogo(size: 26),
      ),
      body: AsyncValueView(
        value: school,
        onRetry: () => ref.invalidate(publicSchoolProvider(widget.code)),
        data: (school) {
          if (!school.publicAspiration || !school.services.aspirasi) {
            return EmptyState(
              icon: Icons.lock_outline_rounded,
              title: 'Aspirasi tanpa login belum dibuka',
              message: '${school.name} belum menerima aspirasi tanpa login. Siswa terdaftar dapat mengirim aspirasi dari aplikasi MANDU.',
              action: FilledButton.tonal(onPressed: _close, child: const Text('Kembali')),
            );
          }
          final sent = _sent;
          if (sent != null) return _SentView(number: sent.number, schoolName: sent.schoolName, onAgain: _again, onDone: _close);
          return ListView(
            padding: const EdgeInsets.fromLTRB(Gaps.xl, Gaps.sm, Gaps.xl, Gaps.xxl),
            children: [
              ContentWidth(
                child: AspirationForm(
                  key: ValueKey(_formVersion),
                  showAnonymous: false,
                  intro: _Intro(school: school),
                  onSubmit: (draft) async {
                    try {
                      final result = await ref.read(aspirationRepositoryProvider).submitPublic(widget.code, draft);
                      if (mounted) setState(() => _sent = (number: result.number, schoolName: result.schoolName));
                    } catch (error) {
                      if (mounted) showSnack(this.context, describeError(error), error: true);
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _again() => setState(() {
        _sent = null;
        _formVersion++;
      });
}

class _Intro extends StatelessWidget {
  const _Intro({required this.school});

  final PublicSchool school;

  @override
  Widget build(BuildContext context) {
    final tone = context.palette.aspirasi;
    return Padding(
      padding: const EdgeInsets.only(bottom: Gaps.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Aspirasi untuk', style: context.textStyles.labelMedium?.copyWith(color: context.colors.onSurfaceVariant)),
          Text(school.name, style: context.textStyles.headlineSmall),
          if (school.city.isNotEmpty) Text('${school.city}, ${school.province}', style: context.textStyles.bodyMedium),
          const SizedBox(height: Gaps.lg),
          InfoBanner(
            icon: Icons.privacy_tip_outlined,
            title: 'Tanpa login, tanpa identitas',
            message: 'Aspirasimu dikirim tanpa nama dan tidak bisa dilacak. Siswa terdaftar sebaiknya masuk ke aplikasi agar bisa memantau tanggapan sekolah.',
            tone: tone,
          ),
        ],
      ),
    );
  }
}

class _SentView extends StatelessWidget {
  const _SentView({required this.number, required this.schoolName, required this.onAgain, required this.onDone});

  final String number;
  final String schoolName;
  final VoidCallback onAgain;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.mark_email_read_outlined,
      tone: context.palette.success,
      title: 'Aspirasi terkirim',
      message: 'Terima kasih! Aspirasi $number sudah diterima $schoolName dan akan ditinjau oleh sekolah.',
      action: Wrap(
        spacing: Gaps.sm,
        runSpacing: Gaps.sm,
        alignment: WrapAlignment.center,
        children: [
          OutlinedButton(onPressed: onAgain, child: const Text('Kirim aspirasi lain')),
          FilledButton(onPressed: onDone, child: const Text('Selesai')),
        ],
      ),
    );
  }
}
