import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../auth/application/session_controller.dart';
import '../data/aspiration_repository.dart';
import '../domain/aspiration.dart';
import 'widgets/aspiration_widgets.dart';

/// Kotak aspirasi untuk admin, pimpinan, dan Tim Verifikasi.
class StaffAspirationInboxScreen extends ConsumerStatefulWidget {
  const StaffAspirationInboxScreen({super.key});

  @override
  ConsumerState<StaffAspirationInboxScreen> createState() => _StaffAspirationInboxScreenState();
}

class _StaffAspirationInboxScreenState extends ConsumerState<StaffAspirationInboxScreen> {
  /// null = semua status.
  AspirationStatus? _status = AspirationStatus.diterima;

  @override
  Widget build(BuildContext context) {
    final schoolId = ref.watch(currentAccountProvider)?.schoolId;
    if (schoolId == null) return const Scaffold(body: LoadingView());
    final inbox = ref.watch(aspirationInboxProvider(schoolId));

    return Scaffold(
      appBar: AppBar(title: const Text('Aspirasi masuk')),
      body: AsyncValueView(
        value: inbox,
        onRetry: () => ref.invalidate(aspirationInboxProvider(schoolId)),
        data: (all) {
          final visible = _status == null ? all : all.where((item) => item.status == _status).toList();
          return Column(
            children: [
              SizedBox(
                height: 56,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: Gaps.lg, vertical: Gaps.sm),
                  children: [
                    for (final status in [...AspirationStatus.values, null]) ...[
                      ChoiceChip(
                        label: Text(
                          '${status?.label ?? 'Semua'} (${status == null ? all.length : all.where((item) => item.status == status).length})',
                        ),
                        selected: _status == status,
                        onSelected: (_) => setState(() => _status = status),
                      ),
                      const SizedBox(width: Gaps.sm),
                    ],
                  ],
                ),
              ),
              Expanded(
                child: visible.isEmpty
                    ? EmptyState(
                        icon: Icons.lightbulb_outline_rounded,
                        tone: context.palette.aspirasi,
                        title: _status == AspirationStatus.diterima ? 'Tidak ada aspirasi baru' : 'Tidak ada aspirasi',
                        message: 'Aspirasi dari siswa dan tamu (lewat kode sekolah) akan muncul di sini.',
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.xs, Gaps.lg, Gaps.xxl),
                        itemCount: visible.length,
                        separatorBuilder: (_, _) => const SizedBox(height: Gaps.md),
                        itemBuilder: (context, index) => ContentWidth(
                          child: AspirationCard(
                            aspiration: visible[index],
                            staffView: true,
                            onTap: () => context.push(Routes.staffAspiration(visible[index].id)),
                          ),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
