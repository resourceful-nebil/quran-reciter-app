import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/theme/app_theme_variant.dart';
import 'package:quran_app/features/settings/data/datasources/theme_local_datasource.dart';
import 'package:quran_app/features/settings/presentation/bloc/theme_event.dart';
import 'package:quran_app/features/settings/presentation/bloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(this._localDataSource)
      : super(const ThemeState(variant: AppThemeVariant.defaultVariant)) {
    on<ThemeLoadRequested>(_onLoadRequested);
    on<ThemeVariantChanged>(_onVariantChanged);
  }

  final ThemeLocalDataSource _localDataSource;

  Future<void> _onLoadRequested(
    ThemeLoadRequested event,
    Emitter<ThemeState> emit,
  ) async {
    final variant = await _localDataSource.loadVariant();
    emit(ThemeState(variant: variant));
  }

  Future<void> _onVariantChanged(
    ThemeVariantChanged event,
    Emitter<ThemeState> emit,
  ) async {
    emit(ThemeState(variant: event.variant));
    await _localDataSource.saveVariant(event.variant);
  }
}
