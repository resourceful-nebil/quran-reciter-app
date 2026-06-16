import 'package:equatable/equatable.dart';
import 'package:quran_app/features/quran/domain/entities/reciter.dart';

sealed class ReciterState extends Equatable {
  const ReciterState();

  @override
  List<Object?> get props => [];
}

class ReciterInitial extends ReciterState {
  const ReciterInitial();
}

class ReciterLoading extends ReciterState {
  const ReciterLoading();
}

class ReciterLoaded extends ReciterState {
  final Reciter reciter;

  const ReciterLoaded(this.reciter);

  @override
  List<Object?> get props => [reciter];
}

class ReciterError extends ReciterState {
  final String message;

  const ReciterError([this.message = 'Failed to load surahs']);

  @override
  List<Object?> get props => [message];
}
