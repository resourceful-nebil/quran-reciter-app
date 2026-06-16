import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:quran_app/core/di/injection_container.dart';
import 'package:quran_app/core/theme/app_theme.dart';
import 'package:quran_app/features/player/presentation/bloc/player_bloc.dart';
import 'package:quran_app/features/quran/presentation/bloc/reciter_bloc.dart';
import 'package:quran_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:quran_app/features/settings/presentation/bloc/theme_state.dart';
import 'package:quran_app/features/splash/presentation/pages/splash_page.dart';
import 'package:quran_app/firebase_options.dart';

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

  await initDependencies();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const QuranApp());
}

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ReciterBloc>()),
        BlocProvider(create: (_) => sl<PlayerBloc>()),
        BlocProvider(create: (_) => sl<ThemeBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          final palette = themeState.variant.palette;

          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness:
                  palette.isDark ? Brightness.light : Brightness.dark,
            ),
          );

          return MaterialApp(
            title: 'تلاوات القرآن الكريم',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.fromVariant(themeState.variant),
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
