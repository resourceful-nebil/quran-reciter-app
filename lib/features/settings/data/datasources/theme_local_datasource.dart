import 'package:quran_app/core/theme/app_theme_variant.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeLocalDataSource {
  Future<AppThemeVariant> loadVariant();
  Future<void> saveVariant(AppThemeVariant variant);
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  ThemeLocalDataSourceImpl(this._prefs);

  static const _key = 'app_theme_variant';

  final SharedPreferences _prefs;

  @override
  Future<AppThemeVariant> loadVariant() async {
    return AppThemeVariant.fromId(_prefs.getString(_key));
  }

  @override
  Future<void> saveVariant(AppThemeVariant variant) async {
    await _prefs.setString(_key, variant.id);
  }
}
