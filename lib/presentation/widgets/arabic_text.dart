import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ArabicText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;

  const ArabicText({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.color = AppColors.gold,
    this.textAlign = TextAlign.right,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontFamily: 'Amiri',
        fontSize: fontSize,
        color: color,
        height: 1.8,
      ),
    );
  }
}
