import '../../domain/entities/reciter.dart';
import '../../domain/repositories/quran_repository.dart';
import '../datasources/local/cache_datasource.dart';
import '../datasources/remote/firestore_datasource.dart';

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
    // 1. Try remote first (fresh data)
    try {
      final reciter = await _remote.fetchReciter(reciterId);
      // 2. Cache on success
      await _cache.cacheReciter(reciterId, reciter);
      return reciter;
    } catch (_) {
      // 3. Fall back to cache if remote fails
      final cached = await _cache.getCachedReciter(reciterId);
      if (cached != null) return cached;
      // 4. Both failed
      rethrow;
    }
  }
}
