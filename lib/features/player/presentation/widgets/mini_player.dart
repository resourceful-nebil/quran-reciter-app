import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/theme/app_palette.dart';
import 'package:quran_app/core/theme/app_text_styles.dart';
import 'package:quran_app/features/player/presentation/bloc/player_bloc.dart';
import 'package:quran_app/features/player/presentation/bloc/player_event.dart';
import 'package:quran_app/features/player/presentation/bloc/player_state.dart';
import 'package:quran_app/features/player/presentation/pages/player_page.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final c = AppPalette.of(context);

    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, playerState) {
        if (playerState.currentSurah == null) return const SizedBox.shrink();

        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const PlayerPage()),
          ),
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: c.accent,
              border: Border(
                top: BorderSide(
                  color: c.gold.withValues(alpha: 0.3),
                  width: 0.5,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        playerState.currentSurah!.nameEn,
                        style: AppTextStyles.surahTitle(c).copyWith(
                          fontSize: 14,
                          color: c.onAccent,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Sheikh Bandar Baleelah',
                        style: AppTextStyles.caption(c).copyWith(
                          color: c.goldLight,
                        ),
                      ),
                    ],
                  ),
                ),
                if (playerState.isLoading)
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: c.gold,
                    ),
                  )
                else
                  IconButton(
                    icon: Icon(
                      playerState.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: c.gold,
                      size: 32,
                    ),
                    onPressed: () {
                      context.read<PlayerBloc>().add(
                            const PlayerTogglePlayPauseRequested(),
                          );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
