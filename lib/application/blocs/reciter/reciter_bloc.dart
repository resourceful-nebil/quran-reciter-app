import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/quran_repository.dart';
import 'reciter_event.dart';
import 'reciter_state.dart';

const String kReciterId = 'bandar-baleelah';

class ReciterBloc extends Bloc<ReciterEvent, ReciterState> {
  final QuranRepository _repository;

  ReciterBloc(this._repository) : super(const ReciterInitial()) {
    on<ReciterLoadRequested>(_onLoadRequested);
    on<ReciterRetryRequested>(_onLoadRequested);
  }

  Future<void> _onLoadRequested(
    ReciterEvent event,
    Emitter<ReciterState> emit,
  ) async {
    emit(const ReciterLoading());
    try {
      final reciter = await _repository.fetchReciter(kReciterId);
      emit(ReciterLoaded(reciter));
    } catch (_) {
      emit(const ReciterError());
    }
  }
}
