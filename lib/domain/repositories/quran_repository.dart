import '../entities/reciter.dart';

// Abstract interface — the domain defines the contract
// The data layer implements it
abstract interface class QuranRepository {
  Future<Reciter> fetchReciter(String reciterId);
}
