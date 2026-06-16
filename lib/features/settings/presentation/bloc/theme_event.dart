import 'package:equatable/equatable.dart';
import 'package:quran_app/core/theme/app_theme_variant.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class ThemeLoadRequested extends ThemeEvent {
  const ThemeLoadRequested();
}

class ThemeVariantChanged extends ThemeEvent {
  const ThemeVariantChanged(this.variant);

  final AppThemeVariant variant;

  @override
  List<Object?> get props => [variant];
}
