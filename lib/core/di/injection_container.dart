import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/features/player/presentation/bloc/player_bloc.dart';
import 'package:quran_app/features/quran/data/datasources/local/cache_datasource.dart';
import 'package:quran_app/features/quran/data/datasources/remote/firestore_datasource.dart';
import 'package:quran_app/features/quran/data/repositories/quran_repository_impl.dart';
import 'package:quran_app/features/quran/domain/repositories/quran_repository.dart';
import 'package:quran_app/features/quran/domain/usecases/get_reciter.dart';
import 'package:quran_app/features/quran/presentation/bloc/reciter_bloc.dart';
import 'package:quran_app/features/settings/data/datasources/theme_local_datasource.dart';
import 'package:quran_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:quran_app/features/settings/presentation/bloc/theme_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);

  // Data sources
  sl.registerLazySingleton<FirestoreDataSource>(
    () => FirestoreDataSourceImpl(),
  );
  sl.registerLazySingleton<CacheDataSource>(
    () => CacheDataSourceImpl(),
  );
  sl.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<QuranRepository>(
    () => QuranRepositoryImpl(remote: sl(), cache: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetReciterUseCase(sl()));

  // BLoCs
  sl.registerFactory(() => ReciterBloc(sl()));
  sl.registerFactory(() => PlayerBloc(AudioPlayer()));
  sl.registerFactory(
    () => ThemeBloc(sl())..add(const ThemeLoadRequested()),
  );
}
