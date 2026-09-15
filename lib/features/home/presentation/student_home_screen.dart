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
import '../../../core/domain/service.dart';
import '../../auth/application/session_controller.dart';
import '../../schools/data/school_repository.dart';
import '../../schools/domain/school.dart';
import 'widgets/service_card.dart';

class StudentHomeScreen extends ConsumerWidget {
  const StudentHomeScreen({super.key});

  bool _enabled(ManduService service, ServiceToggles toggles) => switch (service) {
        ManduService.lapor => toggles.lapor,
        ManduService.curhat => toggles.curhat,
        ManduService.aspirasi => toggles.aspirasi,
        ManduService.bantuan => toggles.bantuan,
        ManduService.edukasi => toggles.edukasi,
      };

  void _open(BuildContext context, ManduService service) {
    switch (service) {
      case ManduService.lapor:
        context.push(Routes.studentReport);
      default:
        showSnack(context, 'Layanan ${service.label} sedang disiapkan.');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(currentAccountProvider);
    if (account == null || account.schoolId == null) return const Scaffold(body: LoadingView());

    final school = ref.watch(schoolDocProvider(account.schoolId!)).value;
    final toggles = school?.services ?? const ServiceToggles();
    final services = ManduService.values.where((service) => _enabled(service, toggles)).toList();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ContentWidth(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(Gaps.xl, Gaps.lg, Gaps.xl, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ManduLogo(size: 30),
                      const SizedBox(height: Gaps.xl),
                      Text('Halo, ${account.firstName}', style: context.textStyles.headlineMedium),
                      const SizedBox(height: Gaps.xs),
                      Row(
                        children: [
                          Icon(Icons.apartment_rounded, size: 16, color: context.colors.onSurfaceVariant),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              account.schoolName ?? '',
                              style: context.textStyles.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Gaps.xl),
                      const _HeroCard(),
                      const SizedBox(height: Gaps.xl),
                      Text('Layanan MANDU', style: context.textStyles.titleMedium),
                      const SizedBox(height: Gaps.md),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ContentWidth(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Gaps.xl),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: services.length,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 240,
                      mainAxisExtent: 160,
                      mainAxisSpacing: Gaps.md,
                      crossAxisSpacing: Gaps.md,
                    ),
                    itemBuilder: (context, index) => ServiceCard(
                      service: services[index],
                      onTap: () => _open(context, services[index]),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ContentWidth(
                child: Padding(
                  padding: const EdgeInsets.all(Gaps.xl),
                  child: InfoBanner(
                    icon: Icons.health_and_safety_outlined,
                    title: 'Dalam keadaan darurat?',
                    message: 'MANDU bukan layanan darurat. Hubungi 112 atau orang dewasa terdekat jika kamu atau orang lain dalam bahaya.',
                    tone: context.palette.danger,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ManduColors.blue, ManduColors.blueDeep],
        ),
        borderRadius: BorderRadius.circular(Radii.xl),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Gaps.xl),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Suaramu penting.', style: context.textStyles.titleLarge?.copyWith(color: Colors.white)),
                  const SizedBox(height: Gaps.xs),
                  Text(
                    'Pilih layanan sesuai kebutuhanmu. Identitasmu bisa dirahasiakan saat melapor.',
                    style: context.textStyles.bodyMedium?.copyWith(color: const Color(0xFFDCE7FF)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: Gaps.md),
            const ManduLogo(size: 60, showWordmark: false, onDark: true),
          ],
        ),
      ),
    );
  }
}
