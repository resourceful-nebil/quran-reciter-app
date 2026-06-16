import 'package:flutter/material.dart';
import 'package:quran_app/core/theme/app_palette.dart';

class ArabicText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final TextAlign textAlign;

  const ArabicText({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.color,
    this.textAlign = TextAlign.right,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);

    return Text(
      text,
      textAlign: textAlign,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontFamily: 'Amiri',
        fontSize: fontSize,
        color: color ?? palette.gold,
        height: 1.8,
      ),
    );
  }
}
