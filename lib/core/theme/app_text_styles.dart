import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Arabic surah names — Amiri font
  static TextStyle arabicLarge = const TextStyle(
    fontFamily: 'Amiri',
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.gold,
    height: 1.8,
  );

  static TextStyle arabicMedium = const TextStyle(
    fontFamily: 'Amiri',
    fontSize: 20,
    color: AppColors.textLight,
    height: 1.6,
  );

  // English labels
  static TextStyle surahTitle = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textLight,
  );

  static TextStyle surahNumber = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
  );

  static TextStyle playerTitle = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
  );

  static TextStyle caption = GoogleFonts.poppins(
    fontSize: 12,
    color: AppColors.textMuted,
  );
}
