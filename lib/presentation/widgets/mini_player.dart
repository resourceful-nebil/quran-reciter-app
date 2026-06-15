import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/blocs/player/player_bloc.dart';
import '../../application/blocs/player/player_event.dart';
import '../../application/blocs/player/player_state.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../screens/player/player_screen.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, playerState) {
        if (playerState.currentSurah == null) return const SizedBox.shrink();

        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const PlayerScreen()),
          ),
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primaryDarkTeal,
              border: Border(
                top: BorderSide(color: AppColors.gold.withValues(alpha: 0.3), width: 0.5),
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
                        style: AppTextStyles.surahTitle.copyWith(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Sheikh Bandar Baleelah',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
                if (playerState.isLoading)
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.gold,
                    ),
                  )
                else
                  IconButton(
                    icon: Icon(
                      playerState.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: AppColors.gold,
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
