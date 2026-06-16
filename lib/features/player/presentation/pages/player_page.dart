import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/theme/app_palette.dart';
import 'package:quran_app/core/theme/app_text_styles.dart';
import 'package:quran_app/features/player/presentation/bloc/player_bloc.dart';
import 'package:quran_app/features/player/presentation/bloc/player_event.dart';
import 'package:quran_app/features/player/presentation/bloc/player_state.dart';
import 'package:quran_app/features/player/presentation/widgets/audio_progress_bar.dart';
import 'package:quran_app/features/quran/presentation/bloc/reciter_bloc.dart';
import 'package:quran_app/features/quran/presentation/bloc/reciter_state.dart';
import 'package:quran_app/core/widgets/arabic_text.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = AppPalette.of(context);

    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, playerState) {
        final surah = playerState.currentSurah;

        if (surah == null) {
          return const Scaffold(
            body: SafeArea(child: Center(child: Text('No surah selected'))),
          );
        }

        return Scaffold(
          backgroundColor: c.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_down_rounded,
                  color: c.textPrimary, size: 32),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('Now Playing', style: AppTextStyles.caption(c)),
            actions: const [
              SizedBox(width: 16),
            ],
          ),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(48, 8, 48, 0),
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: c.gold.withValues(alpha: 0.35),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: c.primary.withValues(alpha: 0.15),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => ColoredBox(
                          color: c.backgroundCard,
                          child: Center(
                            child: Text(
                              '﷽',
                              style: TextStyle(
                                fontFamily: 'Amiri',
                                fontSize: 36,
                                color: c.gold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ArabicText(
                                  text: surah.nameAr,
                                  fontSize: 32,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(surah.nameEn,
                                    style: AppTextStyles.playerTitle(c)),
                                const SizedBox(height: 4),
                                Text('Surah ${surah.number}',
                                    style: AppTextStyles.caption(c)),
                                const SizedBox(height: 4),
                                Text(
                                  'Sheikh Bandar Baleelah | بندر بليلة',
                                  style: AppTextStyles.caption(c).copyWith(
                                    color: c.gold.withValues(alpha: 0.9),
                                  ),
                                ),
                                if (playerState.errorMessage != null) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    playerState.errorMessage!,
                                    style: AppTextStyles.caption(c).copyWith(
                                      color: c.error,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                                const SizedBox(height: 16),
                                AudioProgressBar(
                                  position: playerState.position,
                                  duration: playerState.duration,
                                  onSeek: (pos) {
                                    context.read<PlayerBloc>().add(
                                          PlayerSeekRequested(pos),
                                        );
                                  },
                                ),
                                const SizedBox(height: 12),
                                BlocBuilder<ReciterBloc, ReciterState>(
                                  builder: (context, reciterState) {
                                    if (reciterState is! ReciterLoaded) {
                                      return const SizedBox.shrink();
                                    }
                                    final reciter = reciterState.reciter;
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          iconSize: 36,
                                          icon: Icon(
                                            Icons.skip_previous_rounded,
                                            color: c.textPrimary,
                                          ),
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
                                            color: c.gold,
                                            boxShadow: [
                                              BoxShadow(
                                                color: c.gold
                                                    .withValues(alpha: 0.4),
                                                blurRadius: 20,
                                                spreadRadius: 2,
                                              ),
                                            ],
                                          ),
                                          child: playerState.isLoading
                                              ? Center(
                                                  child: SizedBox(
                                                    width: 28,
                                                    height: 28,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 2.5,
                                                      color: c.accent,
                                                    ),
                                                  ),
                                                )
                                              : IconButton(
                                                  iconSize: 36,
                                                  icon: Icon(
                                                    playerState.isPlaying
                                                        ? Icons.pause_rounded
                                                        : Icons
                                                            .play_arrow_rounded,
                                                    color: c.accent,
                                                  ),
                                                  onPressed: () {
                                                    context
                                                        .read<PlayerBloc>()
                                                        .add(
                                                          const PlayerTogglePlayPauseRequested(),
                                                        );
                                                  },
                                                ),
                                        ),
                                        IconButton(
                                          iconSize: 36,
                                          icon: Icon(
                                            Icons.skip_next_rounded,
                                            color: c.textPrimary,
                                          ),
                                          onPressed: () {
                                            context.read<PlayerBloc>().add(
                                                  PlayerPlayNextRequested(
                                                    reciter.surahs,
                                                  ),
                                                );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
