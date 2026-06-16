import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/core/theme/app_colors.dart';
import 'package:quran_app/core/theme/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      primaryColor: AppColors.primaryTeal,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryTeal,
        secondary: AppColors.gold,
        surface: AppColors.backgroundCard,
        error: AppColors.error,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.surahTitle.copyWith(fontSize: 18),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      dividerColor: AppColors.divider,
    );
  }
}
