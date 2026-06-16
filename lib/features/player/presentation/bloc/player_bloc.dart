import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart' as ja;
import 'package:just_audio_background/just_audio_background.dart';
import 'package:quran_app/features/quran/domain/entities/surah.dart';
import 'package:quran_app/features/player/presentation/bloc/player_event.dart';
import 'package:quran_app/features/player/presentation/bloc/player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final ja.AudioPlayer _player;
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<Duration?>? _durationSub;
  StreamSubscription<ja.PlayerState>? _playerStateSub;

  PlayerBloc(this._player) : super(const PlayerState()) {
    on<PlayerPlaySurahRequested>(_onPlaySurah);
    on<PlayerTogglePlayPauseRequested>(_onTogglePlayPause);
    on<PlayerSeekRequested>(_onSeek);
    on<PlayerPlayNextRequested>(_onPlayNext);
    on<PlayerPlayPreviousRequested>(_onPlayPrevious);
    on<PlayerStopRequested>(_onStop);
    on<PlayerPositionUpdated>(_onPositionUpdated);
    on<PlayerDurationUpdated>(_onDurationUpdated);
    on<PlayerPlaybackStateUpdated>(_onPlaybackStateUpdated);
    _listenToPlayer();
  }

  void _listenToPlayer() {
    _positionSub = _player.positionStream.listen(
      (position) => add(PlayerPositionUpdated(position)),
    );

    _durationSub = _player.durationStream.listen((duration) {
      if (duration != null) {
        add(PlayerDurationUpdated(duration));
      }
    });

    _playerStateSub = _player.playerStateStream.listen((playerState) {
      add(PlayerPlaybackStateUpdated(
        isPlaying: playerState.playing,
        isLoading: playerState.processingState == ja.ProcessingState.loading ||
            playerState.processingState == ja.ProcessingState.buffering,
        isCompleted:
            playerState.processingState == ja.ProcessingState.completed,
      ));
    });
  }

  void _onPositionUpdated(
    PlayerPositionUpdated event,
    Emitter<PlayerState> emit,
  ) {
    emit(state.copyWith(position: event.position));
  }

  void _onDurationUpdated(
    PlayerDurationUpdated event,
    Emitter<PlayerState> emit,
  ) {
    emit(state.copyWith(duration: event.duration));
  }

  void _onPlaybackStateUpdated(
    PlayerPlaybackStateUpdated event,
    Emitter<PlayerState> emit,
  ) {
    if (event.isPlaying) {
      emit(state.copyWith(status: PlayerStatus.playing));
    } else if (event.isLoading) {
      emit(state.copyWith(status: PlayerStatus.loading));
    } else if (event.isCompleted) {
      emit(state.copyWith(
        status: PlayerStatus.paused,
        position: Duration.zero,
      ));
    } else {
      emit(state.copyWith(status: PlayerStatus.paused));
    }
  }

  Future<void> _onPlaySurah(
    PlayerPlaySurahRequested event,
    Emitter<PlayerState> emit,
  ) async {
    final surah = event.surah;
    try {
      if (state.currentSurah?.number == surah.number) {
        add(const PlayerTogglePlayPauseRequested());
        return;
      }

      if (surah.audioUrl.isEmpty) {
        emit(state.copyWith(
          status: PlayerStatus.error,
          errorMessage: 'Audio not available for this surah.',
        ));
        return;
      }

      emit(state.copyWith(
        currentSurah: surah,
        status: PlayerStatus.loading,
        position: Duration.zero,
        duration: Duration.zero,
        errorMessage: null,
      ));

      await _player.setAudioSource(_audioSourceFor(surah));
      await _player.play();
    } catch (_) {
      emit(state.copyWith(
        status: PlayerStatus.error,
        errorMessage: 'Failed to play surah. Please try again.',
      ));
    }
  }

  ja.AudioSource _audioSourceFor(Surah surah) {
    return ja.AudioSource.uri(
      Uri.parse(surah.audioUrl),
      tag: MediaItem(
        id: surah.number.toString(),
        album: 'Quran — Sheikh Bandar Baleelah',
        title: surah.nameEn,
        artist: 'Sheikh Bandar Baleelah',
      ),
    );
  }

  Future<void> _onTogglePlayPause(
    PlayerTogglePlayPauseRequested event,
    Emitter<PlayerState> emit,
  ) async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  Future<void> _onSeek(
    PlayerSeekRequested event,
    Emitter<PlayerState> emit,
  ) async {
    await _player.seek(event.position);
  }

  Future<void> _onPlayNext(
    PlayerPlayNextRequested event,
    Emitter<PlayerState> emit,
  ) async {
    final current = state.currentSurah;
    if (current == null) return;

    final idx = event.surahs.indexWhere((s) => s.number == current.number);
    if (idx < event.surahs.length - 1) {
      add(PlayerPlaySurahRequested(event.surahs[idx + 1]));
    }
  }

  Future<void> _onPlayPrevious(
    PlayerPlayPreviousRequested event,
    Emitter<PlayerState> emit,
  ) async {
    final current = state.currentSurah;
    if (current == null) return;

    final idx = event.surahs.indexWhere((s) => s.number == current.number);
    if (idx > 0) {
      add(PlayerPlaySurahRequested(event.surahs[idx - 1]));
    }
  }

  Future<void> _onStop(
    PlayerStopRequested event,
    Emitter<PlayerState> emit,
  ) async {
    await _player.stop();
    emit(const PlayerState());
  }

  @override
  Future<void> close() {
    _positionSub?.cancel();
    _durationSub?.cancel();
    _playerStateSub?.cancel();
    _player.dispose();
    return super.close();
  }
}
