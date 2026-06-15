import 'package:equatable/equatable.dart';
import '../../../domain/entities/surah.dart';
import 'player_event.dart';

class PlayerState extends Equatable {
  final Surah? currentSurah;
  final PlayerStatus status;
  final Duration position;
  final Duration duration;
  final String? errorMessage;

  const PlayerState({
    this.currentSurah,
    this.status = PlayerStatus.idle,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.errorMessage,
  });

  PlayerState copyWith({
    Surah? currentSurah,
    PlayerStatus? status,
    Duration? position,
    Duration? duration,
    String? errorMessage,
  }) {
    return PlayerState(
      currentSurah: currentSurah ?? this.currentSurah,
      status: status ?? this.status,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isPlaying => status == PlayerStatus.playing;
  bool get isLoading => status == PlayerStatus.loading;

  @override
  List<Object?> get props => [
        currentSurah,
        status,
        position,
        duration,
        errorMessage,
      ];
}
