import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/core/theme/app_palette.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle arabicLarge(AppPalette c) => TextStyle(
        fontFamily: 'Amiri',
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: c.gold,
        height: 1.8,
      );

  static TextStyle arabicMedium(AppPalette c) => TextStyle(
        fontFamily: 'Amiri',
        fontSize: 20,
        color: c.textArabic,
        height: 1.6,
      );

  static TextStyle surahTitle(AppPalette c) => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: c.textPrimary,
      );

  static TextStyle surahNumber(AppPalette c) => GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: c.textMuted,
      );

  static TextStyle playerTitle(AppPalette c) => GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: c.textPrimary,
      );

  static TextStyle caption(AppPalette c) => GoogleFonts.poppins(
        fontSize: 12,
        color: c.textMuted,
      );
}
