import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../assets.dart';
import '../theme/app_colors.dart';

/// Gambar jaringan dengan efek shimmer saat memuat dan placeholder saat kosong/gagal.
class ShimmerNetworkImage extends StatelessWidget {
  const ShimmerNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius = BorderRadius.zero,
    this.fit = BoxFit.cover,
  });

  final String? url;
  final double? width;
  final double? height;
  final BorderRadius borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final imageUrl = url;
    final placeholder = Image.asset(AppAssets.placeholder, fit: fit);

    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        width: width,
        height: height,
        child: imageUrl == null || imageUrl.isEmpty
            ? placeholder
            : CachedNetworkImage(
                imageUrl: imageUrl,
                fit: fit,
                fadeInDuration: const Duration(milliseconds: 200),
                placeholder: (_, _) => Shimmer.fromColors(
                  baseColor: AppColors.placeholder,
                  highlightColor: Colors.white,
                  child: const SizedBox.expand(
                    child: ColoredBox(color: AppColors.placeholder),
                  ),
                ),
                errorWidget: (_, _, _) => placeholder,
              ),
      ),
    );
  }
}
