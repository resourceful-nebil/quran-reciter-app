import 'package:quran_app/features/quran/data/datasources/local/cache_datasource.dart';
import 'package:quran_app/features/quran/data/datasources/remote/firestore_datasource.dart';
import 'package:quran_app/features/quran/domain/entities/reciter.dart';
import 'package:quran_app/features/quran/domain/repositories/quran_repository.dart';

class QuranRepositoryImpl implements QuranRepository {
  final FirestoreDataSource _remote;
  final CacheDataSource _cache;

  const QuranRepositoryImpl({
    required FirestoreDataSource remote,
    required CacheDataSource cache,
  })  : _remote = remote,
        _cache = cache;

  @override
  Future<Reciter> fetchReciter(String reciterId) async {
    try {
      final reciter = await _remote.fetchReciter(reciterId);
      await _cache.cacheReciter(reciterId, reciter);
      return reciter;
    } catch (_) {
      final cached = await _cache.getCachedReciter(reciterId);
      if (cached != null) return cached;
      rethrow;
    }
  }
}
