import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/feedback.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/errors.dart';
import '../../auth/application/session_controller.dart';
import '../data/aspiration_repository.dart';
import 'widgets/aspiration_widgets.dart';

class StudentAspirationFormScreen extends ConsumerWidget {
  const StudentAspirationFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schoolId = ref.watch(currentAccountProvider)?.schoolId;
    return Scaffold(
      appBar: AppBar(title: const Text('Kirim aspirasi')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Gaps.xl, Gaps.sm, Gaps.xl, Gaps.xxl),
        children: [
          ContentWidth(
            child: AspirationForm(
              showAnonymous: true,
              intro: Padding(
                padding: const EdgeInsets.only(bottom: Gaps.xl),
                child: Text(
                  'Aspirasi dibaca admin sekolah dan dijawab dengan tanggapan resmi. Aspirasi yang bermanfaat bagi banyak siswa bisa ditampilkan di papan aspirasi.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              onSubmit: (draft) async {
                if (schoolId == null) return;
                try {
                  final result = await ref.read(aspirationRepositoryProvider).submit(schoolId, draft);
                  if (!context.mounted) return;
                  if (result.flagged) showSnack(context, 'Beberapa kata kurang pantas sudah disamarkan.');
                  context.go(Routes.studentAspiration(result.aspirationId, justSubmitted: true));
                } catch (error) {
                  if (context.mounted) showSnack(context, describeError(error), error: true);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
