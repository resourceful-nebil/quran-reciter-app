import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'application/blocs/player/player_bloc.dart';
import 'application/blocs/reciter/reciter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/local/cache_datasource.dart';
import 'data/datasources/remote/firestore_datasource.dart';
import 'data/repositories/quran_repository_impl.dart';
import 'domain/repositories/quran_repository.dart';
import 'firebase_options.dart';
import 'presentation/screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.bandarbaleelah.quranapp.channel.audio',
    androidNotificationChannelName: 'Quran Audio',
    androidNotificationOngoing: true,
    androidStopForegroundOnPause: true,
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const QuranApp());
}

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirestoreDataSource>(
          create: (_) => FirestoreDataSourceImpl(),
        ),
        RepositoryProvider<CacheDataSource>(
          create: (_) => CacheDataSourceImpl(),
        ),
        RepositoryProvider<QuranRepository>(
          create: (context) => QuranRepositoryImpl(
            remote: context.read<FirestoreDataSource>(),
            cache: context.read<CacheDataSource>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ReciterBloc(context.read<QuranRepository>()),
          ),
          BlocProvider(
            create: (_) => PlayerBloc(AudioPlayer()),
          ),
        ],
        child: MaterialApp(
          title: 'تلاوات القرآن الكريم',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
