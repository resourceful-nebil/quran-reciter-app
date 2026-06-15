import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/blocs/player/player_bloc.dart';
import '../../../application/blocs/player/player_event.dart';
import '../../../application/blocs/player/player_state.dart';
import '../../../application/blocs/reciter/reciter_bloc.dart';
import '../../../application/blocs/reciter/reciter_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../widgets/arabic_text.dart';
import '../../widgets/audio_progress_bar.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, playerState) {
        final surah = playerState.currentSurah;

        if (surah == null) {
          return const Scaffold(
            body: Center(child: Text('No surah selected')),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.backgroundDark,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textLight, size: 32),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('Now Playing', style: AppTextStyles.caption),
            actions: [
              const SizedBox(width: 16),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.gold.withOpacity(0.4),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryTeal.withOpacity(0.4),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/sheikh_photo.png',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.backgroundCard,
                          child: const Center(
                            child: Text(
                              '﷽',
                              style: TextStyle(
                                fontFamily: 'Amiri',
                                fontSize: 48,
                                color: AppColors.gold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      ArabicText(
                        text: surah.nameAr,
                        fontSize: 32,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(surah.nameEn, style: AppTextStyles.playerTitle),
                      const SizedBox(height: 4),
                      Text('Surah ${surah.number}', style: AppTextStyles.caption),
                      const SizedBox(height: 4),
                      Text(
                        'Sheikh Bandar Baleelah | بندر بليلة',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.gold.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 24),
                      AudioProgressBar(
                        position: playerState.position,
                        duration: playerState.duration,
                        onSeek: (pos) {
                          context.read<PlayerBloc>().add(PlayerSeekRequested(pos));
                        },
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<ReciterBloc, ReciterState>(
                        builder: (context, reciterState) {
                          if (reciterState is! ReciterLoaded) {
                            return const SizedBox.shrink();
                          }
                          final reciter = reciterState.reciter;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                iconSize: 36,
                                icon: const Icon(Icons.skip_previous_rounded,
                                    color: AppColors.textLight),
                                onPressed: () {
                                  context.read<PlayerBloc>().add(
                                        PlayerPlayPreviousRequested(
                                          reciter.surahs,
                                        ),
                                      );
                                },
                              ),
                              Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.gold,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.gold.withOpacity(0.4),
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: playerState.isLoading
                                    ? const Center(
                                        child: SizedBox(
                                          width: 28,
                                          height: 28,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            color: AppColors.backgroundDark,
                                          ),
                                        ),
                                      )
                                    : IconButton(
                                        iconSize: 36,
                                        icon: Icon(
                                          playerState.isPlaying
                                              ? Icons.pause_rounded
                                              : Icons.play_arrow_rounded,
                                          color: AppColors.backgroundDark,
                                        ),
                                        onPressed: () {
                                          context.read<PlayerBloc>().add(
                                                const PlayerTogglePlayPauseRequested(),
                                              );
                                        },
                                      ),
                              ),
                              IconButton(
                                iconSize: 36,
                                icon: const Icon(Icons.skip_next_rounded,
                                    color: AppColors.textLight),
                                onPressed: () {
                                  context.read<PlayerBloc>().add(
                                        PlayerPlayNextRequested(reciter.surahs),
                                      );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
