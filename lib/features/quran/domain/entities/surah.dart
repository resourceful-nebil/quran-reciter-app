import 'package:equatable/equatable.dart';

class Surah extends Equatable {
  final int number;
  final String nameEn;
  final String nameAr;
  final String audioUrl;
  final String storagePath;

  const Surah({
    required this.number,
    required this.nameEn,
    required this.nameAr,
    required this.audioUrl,
    required this.storagePath,
  });

  @override
  List<Object?> get props => [number, nameEn, nameAr, audioUrl, storagePath];
}
