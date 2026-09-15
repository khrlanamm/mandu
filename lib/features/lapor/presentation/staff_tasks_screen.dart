import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../notifications/presentation/notification_bell.dart';
import '../data/ticket_repository.dart';
import '../domain/staff_queue.dart';
import 'widgets/ticket_widgets.dart';

/// Tab Tugas staf: antrean laporan sesuai peran dan unit.
class StaffTasksScreen extends ConsumerStatefulWidget {
  const StaffTasksScreen({super.key});

  @override
  ConsumerState<StaffTasksScreen> createState() => _StaffTasksScreenState();
}

class _StaffTasksScreenState extends ConsumerState<StaffTasksScreen> {
  StaffTicketFilter? _filter;

  @override
  Widget build(BuildContext context) {
    final access = ref.watch(staffTicketAccessProvider);
    final tickets = ref.watch(staffTicketsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas'),
        actions: const [NotificationBell(route: Routes.staffNotifications)],
      ),
      body: access == null
          ? const LoadingView()
          : AsyncValueView(
              value: tickets,
              onRetry: () => ref.invalidate(staffTicketsProvider),
              data: (all) {
                final filters = StaffTicketFilter.availableFor(access);
                final filter = filters.contains(_filter) ? _filter! : StaffTicketFilter.initialFor(access);
                final visible = sortForQueue(all.where(filter.matches));

                return Column(
                  children: [
                    SizedBox(
                      height: 56,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: Gaps.lg, vertical: Gaps.sm),
                        children: [
                          for (final option in filters) ...[
                            ChoiceChip(
                              label: Text('${option.label} (${all.where(option.matches).length})'),
                              selected: option == filter,
                              onSelected: (_) => setState(() => _filter = option),
                            ),
                            const SizedBox(width: Gaps.sm),
                          ],
                        ],
                      ),
                    ),
                    if (access.readOnly)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(Gaps.lg, 0, Gaps.lg, Gaps.sm),
                        child: InfoBanner(
                          icon: Icons.visibility_outlined,
                          message: 'Mode pantau: kamu dapat membaca semua laporan, identitas pelapor rahasia tetap tersembunyi.',
                          tone: context.palette.neutral,
                        ),
                      ),
                    Expanded(
                      child: visible.isEmpty
                          ? EmptyState(
                              icon: Icons.task_alt_rounded,
                              tone: context.palette.success,
                              title: switch (filter) {
                                StaffTicketFilter.verifikasi => 'Tidak ada laporan yang menunggu verifikasi',
                                StaffTicketFilter.ditangani => 'Tidak ada laporan yang sedang ditangani',
                                StaffTicketFilter.menungguPelapor => 'Tidak ada laporan yang menunggu pelapor',
                                StaffTicketFilter.selesai => 'Belum ada laporan yang ditutup',
                                StaffTicketFilter.semua => 'Belum ada laporan',
                              },
                              message: access.seesAll || access.units.isNotEmpty
                                  ? 'Laporan baru akan muncul di sini beserta notifikasinya.'
                                  : 'Kamu belum ditugaskan ke unit mana pun. Minta admin sekolah mengatur unitmu.',
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.xs, Gaps.lg, Gaps.xxl),
                              itemCount: visible.length,
                              separatorBuilder: (_, _) => const SizedBox(height: Gaps.md),
                              itemBuilder: (context, index) => ContentWidth(
                                child: TicketCard(
                                  ticket: visible[index],
                                  staffView: true,
                                  onTap: () => context.push(Routes.staffTicket(visible[index].id)),
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
