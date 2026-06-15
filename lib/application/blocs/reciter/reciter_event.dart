import 'package:equatable/equatable.dart';

sealed class ReciterEvent extends Equatable {
  const ReciterEvent();

  @override
  List<Object?> get props => [];
}

class ReciterLoadRequested extends ReciterEvent {
  const ReciterLoadRequested();
}

class ReciterRetryRequested extends ReciterEvent {
  const ReciterRetryRequested();
}
