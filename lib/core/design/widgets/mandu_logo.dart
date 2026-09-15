import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../assets.dart';
import '../tokens.dart';

/// Simbol "Suara Siswa" dengan wordmark MANDU 2.0.
class ManduLogo extends StatelessWidget {
  const ManduLogo({
    super.key,
    this.size = 40,
    this.showSymbol = true,
    this.showWordmark = true,
    this.tagline = false,
    this.onDark = false,
  });

  final double size;
  final bool showSymbol;
  final bool showWordmark;
  final bool tagline;

  /// Paksa versi untuk latar navy/biru (mis. splash).
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final dark = onDark || Theme.of(context).brightness == Brightness.dark;
    final symbol = SvgPicture.asset(
      onDark ? ManduAssets.symbolOnDark : ManduAssets.symbol,
      width: size,
      height: size,
      semanticsLabel: 'MANDU',
    );
    if (!showWordmark) return symbol;

    final wordmark = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(children: [
            TextSpan(
              text: 'MANDU',
              style: TextStyle(
                fontSize: size * 0.6,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
                height: 1,
                color: dark ? Colors.white : ManduColors.blueDeep,
              ),
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.top,
              child: Padding(
                padding: EdgeInsets.only(left: size * 0.08),
                child: Text(
                  '2.0',
                  textScaler: TextScaler.noScaling,
                  style: TextStyle(
                    fontSize: size * 0.3,
                    fontWeight: FontWeight.w700,
                    height: 1,
                    color: dark ? ManduColors.sky : ManduColors.blue,
                  ),
                ),
              ),
            ),
          ]),
          textScaler: TextScaler.noScaling,
        ),
        if (tagline)
          Padding(
            padding: EdgeInsets.only(top: size * 0.1),
            child: Text(
              'Teman Mengadu, Sekolah Berbenah',
              textScaler: TextScaler.noScaling,
              style: TextStyle(
                fontSize: size * 0.24,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                color: dark ? const Color(0xFFB9C6E3) : const Color(0xFF3B4A6B),
              ),
            ),
          ),
      ],
    );

    if (!showSymbol) return wordmark;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [symbol, SizedBox(width: size * 0.25), wordmark],
    );
  }
}
