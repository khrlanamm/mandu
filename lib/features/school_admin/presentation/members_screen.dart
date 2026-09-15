import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design/tokens.dart';
import '../../../core/design/widgets/layout.dart';
import '../../../core/design/widgets/states.dart';
import '../../../core/domain/roles.dart';
import '../../members/data/membership_repository.dart';
import '../../members/domain/member.dart';
import '../../schools/data/school_repository.dart';

class MembersScreen extends ConsumerStatefulWidget {
  const MembersScreen({super.key, required this.schoolId});

  final String schoolId;

  @override
  ConsumerState<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends ConsumerState<MembersScreen> {
  String _query = '';
  SchoolRole? _role;

  bool _matches(Member member) {
    if (_role != null && member.role != _role) return false;
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return true;
    return [member.displayName, member.kelas, member.nisn, member.email]
        .whereType<String>()
        .any((value) => value.toLowerCase().contains(query));
  }

  @override
  Widget build(BuildContext context) {
    final members = ref.watch(schoolMembersProvider(widget.schoolId, status: MemberStatus.active));
    final unitNames = {
      for (final unit in ref.watch(schoolUnitsProvider(widget.schoolId)).value ?? const []) unit.id: unit.name,
    };
    final path = GoRouterState.of(context).uri.path;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Anggota & peran'),
        actions: [
          IconButton(
            tooltip: 'Undang staf',
            onPressed: () => context.push(path.replaceFirst(RegExp(r'/anggota$'), '/undang')),
            icon: const Icon(Icons.person_add_alt_1_rounded),
          ),
        ],
      ),
      body: AsyncValueView(
        value: members,
        data: (all) {
          final filtered = all.where(_matches).toList();
          return ListView(
            padding: const EdgeInsets.all(Gaps.lg),
            children: [
              ContentWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      onChanged: (value) => setState(() => _query = value),
                      decoration: const InputDecoration(
                        hintText: 'Cari nama, kelas, NISN, atau email',
                        prefixIcon: Icon(Icons.search_rounded),
                      ),
                    ),
                    const SizedBox(height: Gaps.md),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          FilterChip(
                            label: Text('Semua (${all.length})'),
                            selected: _role == null,
                            onSelected: (_) => setState(() => _role = null),
                          ),
                          for (final role in SchoolRole.values) ...[
                            const SizedBox(width: Gaps.sm),
                            FilterChip(
                              label: Text('${role.label} (${all.where((member) => member.role == role).length})'),
                              selected: _role == role,
                              onSelected: (selected) => setState(() => _role = selected ? role : null),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: Gaps.lg),
                    if (filtered.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: Gaps.xxl),
                        child: EmptyState(icon: Icons.person_search_rounded, title: 'Tidak ada anggota yang cocok'),
                      )
                    else
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            for (final (index, member) in filtered.indexed) ...[
                              if (index > 0) const Divider(height: 1),
                              ListTile(
                                leading: CircleAvatar(child: Text(member.initials)),
                                title: Text(member.displayName),
                                subtitle: Text([
                                  member.role.label,
                                  if (member.kelas != null && member.kelas!.isNotEmpty) 'Kelas ${member.kelas}',
                                  if (member.units.isNotEmpty) member.units.map((id) => unitNames[id] ?? id).join(', '),
                                ].join(' · ')),
                                trailing: const Icon(Icons.chevron_right_rounded),
                                onTap: () => context.push('$path/${member.uid}'),
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
