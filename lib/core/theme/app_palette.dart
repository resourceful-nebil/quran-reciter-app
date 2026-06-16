import 'package:flutter/material.dart';

class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.primary,
    required this.primaryDark,
    required this.gold,
    required this.goldLight,
    required this.background,
    required this.backgroundCard,
    required this.textPrimary,
    required this.textMuted,
    required this.textArabic,
    required this.accent,
    required this.divider,
    required this.error,
    required this.onAccent,
    required this.brightness,
  });

  final Color primary;
  final Color primaryDark;
  final Color gold;
  final Color goldLight;
  final Color background;
  final Color backgroundCard;
  final Color textPrimary;
  final Color textMuted;
  final Color textArabic;
  final Color accent;
  final Color divider;
  final Color error;
  final Color onAccent;
  final Brightness brightness;

  static AppPalette of(BuildContext context) {
    return Theme.of(context).extension<AppPalette>()!;
  }

  bool get isDark => brightness == Brightness.dark;

  @override
  AppPalette copyWith({
    Color? primary,
    Color? primaryDark,
    Color? gold,
    Color? goldLight,
    Color? background,
    Color? backgroundCard,
    Color? textPrimary,
    Color? textMuted,
    Color? textArabic,
    Color? accent,
    Color? divider,
    Color? error,
    Color? onAccent,
    Brightness? brightness,
  }) {
    return AppPalette(
      primary: primary ?? this.primary,
      primaryDark: primaryDark ?? this.primaryDark,
      gold: gold ?? this.gold,
      goldLight: goldLight ?? this.goldLight,
      background: background ?? this.background,
      backgroundCard: backgroundCard ?? this.backgroundCard,
      textPrimary: textPrimary ?? this.textPrimary,
      textMuted: textMuted ?? this.textMuted,
      textArabic: textArabic ?? this.textArabic,
      accent: accent ?? this.accent,
      divider: divider ?? this.divider,
      error: error ?? this.error,
      onAccent: onAccent ?? this.onAccent,
      brightness: brightness ?? this.brightness,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      gold: Color.lerp(gold, other.gold, t)!,
      goldLight: Color.lerp(goldLight, other.goldLight, t)!,
      background: Color.lerp(background, other.background, t)!,
      backgroundCard: Color.lerp(backgroundCard, other.backgroundCard, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textArabic: Color.lerp(textArabic, other.textArabic, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      error: Color.lerp(error, other.error, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      brightness: t < 0.5 ? brightness : other.brightness,
    );
  }
}
