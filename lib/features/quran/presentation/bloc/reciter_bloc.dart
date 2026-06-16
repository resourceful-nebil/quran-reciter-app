import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/features/quran/domain/usecases/get_reciter.dart';
import 'package:quran_app/features/quran/presentation/bloc/reciter_event.dart';
import 'package:quran_app/features/quran/presentation/bloc/reciter_state.dart';

class ReciterBloc extends Bloc<ReciterEvent, ReciterState> {
  final GetReciterUseCase _getReciter;

  ReciterBloc(this._getReciter) : super(const ReciterInitial()) {
    on<ReciterLoadRequested>(_onLoadRequested);
    on<ReciterRetryRequested>(_onLoadRequested);
  }

  Future<void> _onLoadRequested(
    ReciterEvent event,
    Emitter<ReciterState> emit,
  ) async {
    emit(const ReciterLoading());
    try {
      final reciter = await _getReciter();
      emit(ReciterLoaded(reciter));
    } catch (_) {
      emit(const ReciterError());
    }
  }
}
