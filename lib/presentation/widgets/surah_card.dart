import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../domain/entities/surah.dart';
import 'arabic_text.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isPlaying
              ? AppColors.primaryTeal.withOpacity(0.3)
              : AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isPlaying ? AppColors.gold : AppColors.divider,
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
                    color: isPlaying ? AppColors.gold : AppColors.primaryTeal,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            color: AppColors.gold,
                          ),
                        )
                      : isPlaying
                          ? const Icon(
                              Icons.volume_up_rounded,
                              size: 18,
                              color: AppColors.gold,
                            )
                          : Text(
                              '${surah.number}',
                              style: AppTextStyles.surahNumber.copyWith(
                                color: AppColors.textMuted,
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
                      style: AppTextStyles.surahTitle.copyWith(
                        color: isPlaying ? AppColors.gold : AppColors.textLight,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Surah ${surah.number}',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              ArabicText(
                text: surah.nameAr,
                fontSize: 18,
                color: isPlaying ? AppColors.gold : AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
