import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../auth/application/session_controller.dart';
import '../data/ticket_repository.dart';
import '../domain/ticket.dart';
import 'widgets/ticket_widgets.dart';

/// Tab Aktivitas siswa: laporan yang pernah dikirim.
class MyActivityScreen extends ConsumerWidget {
  const MyActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final owned = ref.watch(myTicketsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Aktivitas')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.studentReport),
        icon: const Icon(Icons.campaign_rounded),
        label: const Text('Lapor'),
      ),
      body: AsyncValueView(
        value: owned,
        onRetry: () => ref.invalidate(myTicketsProvider),
        data: (owners) {
          if (owners.isEmpty) {
            return EmptyState(
              icon: Icons.receipt_long_rounded,
              tone: context.palette.lapor,
              title: 'Belum ada laporan',
              message: 'Laporan yang kamu kirim beserta perkembangannya akan tampil di sini.',
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.sm, Gaps.lg, 96),
            itemCount: owners.length,
            separatorBuilder: (_, _) => const SizedBox(height: Gaps.md),
            itemBuilder: (context, index) => ContentWidth(child: _OwnedTicketTile(owner: owners[index])),
          );
        },
      ),
    );
  }
}

class _OwnedTicketTile extends ConsumerWidget {
  const _OwnedTicketTile({required this.owner});

  final TicketOwner owner;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schoolId = ref.watch(currentAccountProvider)?.schoolId ?? '';
    final ticket = ref.watch(ticketProvider(schoolId, owner.id)).value;
    if (ticket == null) {
      return const Card(child: SizedBox(height: 112, child: Center(child: CircularProgressIndicator(strokeWidth: 2))));
    }
    return TicketCard(ticket: ticket, onTap: () => context.push(Routes.studentTicket(ticket.id)));
  }
}
