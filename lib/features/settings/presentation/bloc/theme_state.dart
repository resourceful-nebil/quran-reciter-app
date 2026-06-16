import 'package:equatable/equatable.dart';
import 'package:quran_app/core/theme/app_theme_variant.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.variant});

  final AppThemeVariant variant;

  @override
  List<Object?> get props => [variant];
}
