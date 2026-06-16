import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/theme/app_palette.dart';
import 'package:quran_app/core/theme/app_text_styles.dart';
import 'package:quran_app/features/quran/presentation/bloc/reciter_bloc.dart';
import 'package:quran_app/features/quran/presentation/bloc/reciter_event.dart';
import 'package:quran_app/features/quran/presentation/pages/surah_list_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _controller.forward();

    context.read<ReciterBloc>().add(const ReciterLoadRequested());

    Future.delayed(const Duration(milliseconds: 2200), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const SurahListPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = AppPalette.of(context);

    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 120,
                    height: 120,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.menu_book_rounded,
                      size: 80,
                      color: c.gold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 22,
                      color: c.gold,
                      height: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'تلاوات القرآن الكريم',
                    style: AppTextStyles.arabicMedium(c).copyWith(
                      color: c.textMuted,
                      fontSize: 16,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sheikh Bandar Baleelah',
                    style: AppTextStyles.caption(c),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
