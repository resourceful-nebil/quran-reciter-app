import 'package:flutter/material.dart';
import 'package:quran_app/core/theme/app_palette.dart';

enum AppThemeVariant {
  tealGold(
    id: 'teal_gold',
    label: 'Teal & Gold',
    labelAr: 'تركواز وذهبي',
    palette: AppPalette(
      primary: Color(0xFF4ABDB5),
      primaryDark: Color(0xFF2A8F88),
      gold: Color(0xFFB8963E),
      goldLight: Color(0xFFD4AF5A),
      background: Color(0xFFF7F4EF),
      backgroundCard: Color(0xFFEEEAE2),
      textPrimary: Color(0xFF1A1A1A),
      textMuted: Color(0xFF7A7A7A),
      textArabic: Color(0xFF2A2A2A),
      accent: Color(0xFF1B2A4A),
      divider: Color(0xFFD4CFC6),
      error: Color(0xFFC62828),
      onAccent: Color(0xFFF7F4EF),
      brightness: Brightness.light,
    ),
  ),
  emerald(
    id: 'emerald',
    label: 'Emerald',
    labelAr: 'زمردي',
    palette: AppPalette(
      primary: Color(0xFF2E8B6E),
      primaryDark: Color(0xFF1F6B54),
      gold: Color(0xFFC4A035),
      goldLight: Color(0xFFD9B84E),
      background: Color(0xFFF5F8F4),
      backgroundCard: Color(0xFFE8EFE9),
      textPrimary: Color(0xFF1A2E24),
      textMuted: Color(0xFF6B7F74),
      textArabic: Color(0xFF243528),
      accent: Color(0xFF1A3D32),
      divider: Color(0xFFC8D5CC),
      error: Color(0xFFC62828),
      onAccent: Color(0xFFF5F8F4),
      brightness: Brightness.light,
    ),
  ),
  warmSand(
    id: 'warm_sand',
    label: 'Warm Sand',
    labelAr: 'رملي دافئ',
    palette: AppPalette(
      primary: Color(0xFF8B6F4E),
      primaryDark: Color(0xFF6B5438),
      gold: Color(0xFFB8963E),
      goldLight: Color(0xFFD4AF5A),
      background: Color(0xFFFAF6F0),
      backgroundCard: Color(0xFFF0EAE0),
      textPrimary: Color(0xFF2C2418),
      textMuted: Color(0xFF8A7B6A),
      textArabic: Color(0xFF3A3024),
      accent: Color(0xFF4A3728),
      divider: Color(0xFFDDD4C6),
      error: Color(0xFFC62828),
      onAccent: Color(0xFFFAF6F0),
      brightness: Brightness.light,
    ),
  ),
  midnight(
    id: 'midnight',
    label: 'Midnight',
    labelAr: 'ليلي',
    palette: AppPalette(
      primary: Color(0xFF4ABDB5),
      primaryDark: Color(0xFF2A8F88),
      gold: Color(0xFFD4AF5A),
      goldLight: Color(0xFFE8C878),
      background: Color(0xFF0F1A2E),
      backgroundCard: Color(0xFF1B2A4A),
      textPrimary: Color(0xFFF7F4EF),
      textMuted: Color(0xFFA8B0C0),
      textArabic: Color(0xFFE8E4DC),
      accent: Color(0xFF1B2A4A),
      divider: Color(0xFF2A3D5C),
      error: Color(0xFFE57373),
      onAccent: Color(0xFFF7F4EF),
      brightness: Brightness.dark,
    ),
  );

  const AppThemeVariant({
    required this.id,
    required this.label,
    required this.labelAr,
    required this.palette,
  });

  final String id;
  final String label;
  final String labelAr;
  final AppPalette palette;

  static const defaultVariant = AppThemeVariant.tealGold;

  static AppThemeVariant fromId(String? id) {
    return AppThemeVariant.values.firstWhere(
      (v) => v.id == id,
      orElse: () => defaultVariant,
    );
  }
}
