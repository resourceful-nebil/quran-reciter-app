import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/theme/app_palette.dart';
import 'package:quran_app/core/theme/app_text_styles.dart';
import 'package:quran_app/core/theme/app_theme_variant.dart';
import 'package:quran_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:quran_app/features/settings/presentation/bloc/theme_event.dart';
import 'package:quran_app/features/settings/presentation/bloc/theme_state.dart';

class ThemePickerSheet extends StatelessWidget {
  const ThemePickerSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppPalette.of(context).background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const ThemePickerSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: palette.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Theme', style: AppTextStyles.surahTitle(palette)),
            Text(
              'المظهر',
              style: AppTextStyles.arabicMedium(palette).copyWith(fontSize: 14),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 16),
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: AppThemeVariant.values.map((variant) {
                    final isSelected = state.variant == variant;
                    return _ThemeOption(
                      variant: variant,
                      isSelected: isSelected,
                      onTap: () {
                        context.read<ThemeBloc>().add(
                              ThemeVariantChanged(variant),
                            );
                        Navigator.of(context).pop();
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.variant,
    required this.isSelected,
    required this.onTap,
  });

  final AppThemeVariant variant;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = variant.palette;
    final current = AppPalette.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 150,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: palette.backgroundCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? palette.gold : current.divider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _Swatch(color: palette.primary),
                const SizedBox(width: 4),
                _Swatch(color: palette.gold),
                const SizedBox(width: 4),
                _Swatch(color: palette.accent),
                const Spacer(),
                if (isSelected)
                  Icon(Icons.check_circle_rounded,
                      color: palette.gold, size: 18),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              variant.label,
              style: AppTextStyles.surahTitle(palette).copyWith(fontSize: 13),
            ),
            Text(
              variant.labelAr,
              style: AppTextStyles.caption(palette),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
    );
  }
}
