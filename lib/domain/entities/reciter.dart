import 'package:equatable/equatable.dart';
import 'surah.dart';

class Reciter extends Equatable {
  final String id;
  final String name;
  final String nameAr;
  final List<Surah> surahs;
  final int surahCount;

  const Reciter({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.surahs,
    required this.surahCount,
  });

  @override
  List<Object?> get props => [id, name, nameAr, surahs, surahCount];
}
