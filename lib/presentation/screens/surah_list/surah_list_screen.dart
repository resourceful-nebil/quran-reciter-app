import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/blocs/player/player_bloc.dart';
import '../../../application/blocs/player/player_event.dart';
import '../../../application/blocs/player/player_state.dart';
import '../../../application/blocs/reciter/reciter_bloc.dart';
import '../../../application/blocs/reciter/reciter_event.dart';
import '../../../application/blocs/reciter/reciter_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../widgets/mini_player.dart';
import '../../widgets/surah_card.dart';
import '../player/player_screen.dart';

class SurahListScreen extends StatelessWidget {
  const SurahListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('القرآن الكريم',
                style: AppTextStyles.arabicMedium.copyWith(fontSize: 18)),
            Text('Sheikh Bandar Baleelah', style: AppTextStyles.caption),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ReciterBloc, ReciterState>(
              builder: (context, reciterState) {
                return switch (reciterState) {
                  ReciterInitial() || ReciterLoading() => const Center(
                      child: CircularProgressIndicator(color: AppColors.gold),
                    ),
                  ReciterError(:final message) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.wifi_off_rounded,
                              color: AppColors.textMuted, size: 48),
                          const SizedBox(height: 16),
                          Text(message, style: AppTextStyles.surahTitle),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () => context.read<ReciterBloc>().add(
                                  const ReciterRetryRequested(),
                                ),
                            child: const Text('Retry',
                                style: TextStyle(color: AppColors.gold)),
                          ),
                        ],
                      ),
                    ),
                  ReciterLoaded(:final reciter) =>
                    BlocBuilder<PlayerBloc, PlayerState>(
                      builder: (context, playerState) {
                        return ListView.builder(
                          padding: const EdgeInsets.only(top: 8, bottom: 16),
                          itemCount: reciter.surahs.length,
                          itemBuilder: (context, index) {
                            final surah = reciter.surahs[index];
                            final isPlaying =
                                playerState.currentSurah?.number == surah.number &&
                                    playerState.isPlaying;
                            final isLoading =
                                playerState.currentSurah?.number == surah.number &&
                                    playerState.isLoading;

                            return SurahCard(
                              surah: surah,
                              isPlaying: isPlaying,
                              isLoading: isLoading,
                              onTap: () {
                                context.read<PlayerBloc>().add(
                                      PlayerPlaySurahRequested(surah),
                                    );
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const PlayerScreen(),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                };
              },
            ),
          ),
          const MiniPlayer(),
        ],
      ),
    );
  }
}
