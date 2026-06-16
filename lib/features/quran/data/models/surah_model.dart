import 'package:quran_app/features/quran/domain/entities/surah.dart';

class SurahModel extends Surah {
  const SurahModel({
    required super.number,
    required super.nameEn,
    required super.nameAr,
    required super.audioUrl,
    required super.storagePath,
  });

  factory SurahModel.fromMap(Map<String, dynamic> map) {
    return SurahModel(
      number: (map['surahNumber'] as num).toInt(),
      nameEn: map['surahNameEn'] as String? ?? '',
      nameAr: map['surahNameAr'] as String? ?? '',
      audioUrl: map['audioUrl'] as String? ?? '',
      storagePath: map['storagePath'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'surahNumber': number,
      'surahNameEn': nameEn,
      'surahNameAr': nameAr,
      'audioUrl': audioUrl,
      'storagePath': storagePath,
    };
  }
}
