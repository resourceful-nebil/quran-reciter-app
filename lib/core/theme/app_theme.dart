import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/core/theme/app_text_styles.dart';
import 'package:quran_app/core/theme/app_theme_variant.dart';

class AppTheme {
  AppTheme._();

  static ThemeData fromVariant(AppThemeVariant variant) {
    final palette = variant.palette;
    final isDark = palette.isDark;

    return ThemeData(
      useMaterial3: true,
      brightness: palette.brightness,
      scaffoldBackgroundColor: palette.background,
      primaryColor: palette.primary,
      extensions: [palette],
      colorScheme: ColorScheme(
        brightness: palette.brightness,
        primary: palette.primary,
        onPrimary: palette.onAccent,
        secondary: palette.gold,
        onSecondary: palette.accent,
        surface: palette.backgroundCard,
        onSurface: palette.textPrimary,
        error: palette.error,
        onError: palette.onAccent,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: palette.background,
        foregroundColor: palette.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.surahTitle(palette).copyWith(fontSize: 18),
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
      ),
      dividerColor: palette.divider,
    );
  }
}
