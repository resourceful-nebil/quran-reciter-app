import 'package:quran_app/features/quran/domain/entities/reciter.dart';

abstract interface class QuranRepository {
  Future<Reciter> fetchReciter(String reciterId);
}
