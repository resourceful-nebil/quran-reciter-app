import 'package:quran_app/features/quran/domain/entities/reciter.dart';
import 'package:quran_app/features/quran/domain/repositories/quran_repository.dart';

class GetReciterUseCase {
  const GetReciterUseCase(this._repository);

  final QuranRepository _repository;

  static const defaultReciterId = 'bandar-baleelah';

  Future<Reciter> call({String reciterId = defaultReciterId}) {
    return _repository.fetchReciter(reciterId);
  }
}
