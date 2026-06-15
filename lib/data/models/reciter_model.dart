import '../../domain/entities/reciter.dart';
import 'surah_model.dart';

class ReciterModel extends Reciter {
  const ReciterModel({
    required super.id,
    required super.name,
    required super.nameAr,
    required super.surahs,
    required super.surahCount,
  });

  factory ReciterModel.fromFirestore(Map<String, dynamic> data) {
    final surahsMap = data['surahs'] as Map<String, dynamic>? ?? {};

    final surahs = surahsMap.values
        .map((s) => SurahModel.fromMap(s as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => a.number.compareTo(b.number));

    return ReciterModel(
      id: data['reciterId'] as String? ?? '',
      name: data['reciterName'] as String? ?? '',
      nameAr: data['reciterNameAr'] as String? ?? '',
      surahs: surahs,
      surahCount: (data['surahCount'] as num?)?.toInt() ?? 0,
    );
  }
}
