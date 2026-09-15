import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/design/palette.dart';
import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/mandu_logo.dart';
import '../../../core/design/widgets/states.dart';
import '../../schools/data/school_repository.dart';
import '../../schools/domain/school.dart';

class SuperadminSchoolsScreen extends ConsumerStatefulWidget {
  const SuperadminSchoolsScreen({super.key});

  @override
  ConsumerState<SuperadminSchoolsScreen> createState() => _SuperadminSchoolsScreenState();
}

class _SuperadminSchoolsScreenState extends ConsumerState<SuperadminSchoolsScreen> {
  String _query = '';

  bool _matches(School school) {
    final query = _query.trim().toLowerCase();
    return query.isEmpty ||
        [school.name, school.city, school.province, school.code, school.npsn ?? '']
            .any((value) => value.toLowerCase().contains(query));
  }

  @override
  Widget build(BuildContext context) {
    final schools = ref.watch(allSchoolsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Row(children: [ManduLogo(size: 26, showWordmark: false), SizedBox(width: Gaps.sm), Text('Konsol Superadmin')]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.superadminNewSchool),
        icon: const Icon(Icons.add_business_rounded),
        label: const Text('Tambah sekolah'),
      ),
      body: AsyncValueView(
        value: schools,
        onRetry: () => ref.invalidate(allSchoolsProvider),
        data: (all) {
          final active = all.where((school) => school.active).length;
          final filtered = all.where(_matches).toList();
          return ListView(
            padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.sm, Gaps.lg, Gaps.xxxl * 2),
            children: [
              ContentWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(child: _Stat(label: 'Sekolah terdaftar', value: '${all.length}')),
                        const SizedBox(width: Gaps.md),
                        Expanded(child: _Stat(label: 'Sekolah aktif', value: '$active')),
                      ],
                    ),
                    const SizedBox(height: Gaps.lg),
                    TextField(
                      onChanged: (value) => setState(() => _query = value),
                      decoration: const InputDecoration(
                        hintText: 'Cari nama, kota, NPSN, atau kode',
                        prefixIcon: Icon(Icons.search_rounded),
                      ),
                    ),
                    const SizedBox(height: Gaps.lg),
                    if (all.isEmpty)
                      const EmptyState(
                        icon: Icons.add_business_rounded,
                        title: 'Belum ada sekolah',
                        message: 'Tambahkan sekolah pertama, lalu undang admin sekolahnya.',
                      )
                    else if (filtered.isEmpty)
                      const EmptyState(icon: Icons.search_off_rounded, title: 'Tidak ada sekolah yang cocok')
                    else
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            for (final (index, school) in filtered.indexed) ...[
                              if (index > 0) const Divider(height: 1),
                              ListTile(
                                leading: const Icon(Icons.apartment_rounded),
                                title: Text(school.name),
                                subtitle: Text('${school.level} · ${school.city} · Kode ${school.code}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (!school.active) StatusPill(label: 'Nonaktif', tone: context.palette.danger),
                                    const Icon(Icons.chevron_right_rounded),
                                  ],
                                ),
                                onTap: () => context.push(Routes.superadminSchool(school.id)),
                              ),
                            ],
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Gaps.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: context.textStyles.headlineMedium?.copyWith(fontFeatures: const [FontFeature.tabularFigures()])),
            Text(label, style: context.textStyles.bodySmall?.copyWith(color: context.colors.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}
