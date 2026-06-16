import 'package:flutter/material.dart';
import 'package:quran_app/core/theme/app_palette.dart';
import 'package:quran_app/core/theme/app_text_styles.dart';
import 'package:quran_app/core/widgets/arabic_text.dart';
import 'package:quran_app/features/quran/domain/entities/surah.dart';

class SurahCard extends StatelessWidget {
  final Surah surah;
  final bool isPlaying;
  final bool isLoading;
  final VoidCallback onTap;

  const SurahCard({
    super.key,
    required this.surah,
    required this.isPlaying,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = AppPalette.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isPlaying
              ? c.primary.withValues(alpha: 0.3)
              : c.backgroundCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isPlaying ? c.gold : c.divider,
            width: isPlaying ? 1.5 : 0.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isPlaying ? c.gold : c.primary,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: isLoading
                      ? SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            color: c.gold,
                          ),
                        )
                      : isPlaying
                          ? Icon(
                              Icons.volume_up_rounded,
                              size: 18,
                              color: c.gold,
                            )
                          : Text(
                              '${surah.number}',
                              style: AppTextStyles.surahNumber(c).copyWith(
                                fontSize: 12,
                              ),
                            ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      surah.nameEn,
                      style: AppTextStyles.surahTitle(c).copyWith(
                        color: isPlaying ? c.gold : c.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text('Surah ${surah.number}', style: AppTextStyles.caption(c)),
                  ],
                ),
              ),
              ArabicText(
                text: surah.nameAr,
                fontSize: 18,
                color: isPlaying ? c.gold : c.textArabic,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
