import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quran_app/features/quran/data/models/reciter_model.dart';
import 'package:quran_app/features/quran/data/models/surah_model.dart';

abstract interface class CacheDataSource {
  Future<ReciterModel?> getCachedReciter(String reciterId);
  Future<void> cacheReciter(String reciterId, ReciterModel reciter);
}

class CacheDataSourceImpl implements CacheDataSource {
  static const String _prefix = 'reciter_cache_';

  @override
  Future<ReciterModel?> getCachedReciter(String reciterId) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString('$_prefix$reciterId');
    if (jsonStr == null) return null;

    try {
      final Map<String, dynamic> data = jsonDecode(jsonStr);
      return ReciterModel.fromFirestore(data);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> cacheReciter(String reciterId, ReciterModel reciter) async {
    final prefs = await SharedPreferences.getInstance();
    final data = {
      'reciterId': reciter.id,
      'reciterName': reciter.name,
      'reciterNameAr': reciter.nameAr,
      'surahCount': reciter.surahCount,
      'surahs': {
        for (final s in reciter.surahs)
          '${s.number}': (s as SurahModel).toMap(),
      },
    };
    await prefs.setString('$_prefix$reciterId', jsonEncode(data));
  }
}
