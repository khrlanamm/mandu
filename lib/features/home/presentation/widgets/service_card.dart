import 'package:flutter/material.dart';

import '../../../../core/design/palette.dart';
import '../../../../core/design/tokens.dart';
import '../../../../core/domain/service.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key, required this.service, required this.onTap});

  final ManduService service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tone = service.tone(context.palette);
    return Material(
      color: tone.container,
      borderRadius: BorderRadius.circular(Radii.lg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Gaps.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(color: tone.main, borderRadius: BorderRadius.circular(Radii.md)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(service.icon, color: tone.onMain, size: 26),
                ),
              ),
              const Spacer(),
              Text(service.label, style: context.textStyles.titleMedium?.copyWith(color: tone.onContainer)),
              const SizedBox(height: 2),
              Text(
                service.tagline,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textStyles.bodySmall?.copyWith(color: tone.onContainer),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
