import 'package:equatable/equatable.dart';
import '../../../domain/entities/surah.dart';

enum PlayerStatus { idle, loading, playing, paused, error }

sealed class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object?> get props => [];
}

class PlayerPlaySurahRequested extends PlayerEvent {
  final Surah surah;

  const PlayerPlaySurahRequested(this.surah);

  @override
  List<Object?> get props => [surah];
}

class PlayerTogglePlayPauseRequested extends PlayerEvent {
  const PlayerTogglePlayPauseRequested();
}

class PlayerSeekRequested extends PlayerEvent {
  final Duration position;

  const PlayerSeekRequested(this.position);

  @override
  List<Object?> get props => [position];
}

class PlayerPlayNextRequested extends PlayerEvent {
  final List<Surah> surahs;

  const PlayerPlayNextRequested(this.surahs);

  @override
  List<Object?> get props => [surahs];
}

class PlayerPlayPreviousRequested extends PlayerEvent {
  final List<Surah> surahs;

  const PlayerPlayPreviousRequested(this.surahs);

  @override
  List<Object?> get props => [surahs];
}

class PlayerStopRequested extends PlayerEvent {
  const PlayerStopRequested();
}

class PlayerPositionUpdated extends PlayerEvent {
  final Duration position;

  const PlayerPositionUpdated(this.position);

  @override
  List<Object?> get props => [position];
}

class PlayerDurationUpdated extends PlayerEvent {
  final Duration duration;

  const PlayerDurationUpdated(this.duration);

  @override
  List<Object?> get props => [duration];
}

class PlayerPlaybackStateUpdated extends PlayerEvent {
  final bool isPlaying;
  final bool isLoading;
  final bool isCompleted;

  const PlayerPlaybackStateUpdated({
    required this.isPlaying,
    required this.isLoading,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [isPlaying, isLoading, isCompleted];
}
