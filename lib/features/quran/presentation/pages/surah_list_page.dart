import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/theme/app_colors.dart';
import 'package:quran_app/core/theme/app_text_styles.dart';
import 'package:quran_app/features/player/presentation/bloc/player_bloc.dart';
import 'package:quran_app/features/player/presentation/bloc/player_event.dart';
import 'package:quran_app/features/player/presentation/bloc/player_state.dart';
import 'package:quran_app/features/player/presentation/pages/player_page.dart';
import 'package:quran_app/features/player/presentation/widgets/mini_player.dart';
import 'package:quran_app/features/quran/presentation/bloc/reciter_bloc.dart';
import 'package:quran_app/features/quran/presentation/bloc/reciter_event.dart';
import 'package:quran_app/features/quran/presentation/bloc/reciter_state.dart';
import 'package:quran_app/features/quran/presentation/widgets/surah_card.dart';

class SurahListPage extends StatelessWidget {
  const SurahListPage({super.key});

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
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ReciterBloc, ReciterState>(
                builder: (context, reciterState) {
                  return switch (reciterState) {
                    ReciterInitial() || ReciterLoading() => const Center(
                        child:
                            CircularProgressIndicator(color: AppColors.gold),
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
                            padding:
                                const EdgeInsets.only(top: 8, bottom: 16),
                            itemCount: reciter.surahs.length,
                            itemBuilder: (context, index) {
                              final surah = reciter.surahs[index];
                              final isPlaying = playerState
                                          .currentSurah?.number ==
                                      surah.number &&
                                  playerState.isPlaying;
                              final isLoading = playerState
                                          .currentSurah?.number ==
                                      surah.number &&
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
                                      builder: (_) => const PlayerPage(),
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
      ),
    );
  }
}
