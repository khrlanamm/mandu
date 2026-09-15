import 'package:flutter/material.dart';

import '../../../core/widgets/label_chip.dart';
import '../../../core/widgets/shimmer_network_image.dart';
import '../../../data/models/report.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({super.key, required this.report, required this.onTap});

  final Report report;
  final VoidCallback onTap;

  static const _textStyle = TextStyle(fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ShimmerNetworkImage(
                url: report.urlBukti,
                width: 80,
                height: 80,
                borderRadius: BorderRadius.circular(12),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tanggal: ${report.tanggalBullying}', style: _textStyle),
                    const SizedBox(height: 4),
                    Text(
                      'Lokasi: ${report.lokasi}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _textStyle,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      report.deskripsi,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: _textStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LabelChip.status(report.status),
                    LabelChip.role(report.peran),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
