import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thread_clone/features/settings/repos/screen_config_repository.dart';
import 'package:thread_clone/features/settings/view_models/screen_config_view_model.dart';
import 'package:thread_clone/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final repository = ScreenConfigRepository(preferences);

  runApp(
    ProviderScope(
      overrides: [
        screenConfigProvider
            .overrideWith(() => ScreenConfigViewModel(repository))
      ],
      child: const ThreadClone(),
    ),
  );
}

class ThreadClone extends ConsumerWidget {
  const ThreadClone({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      title: 'Thread Clone',
      themeMode: ref.watch(screenConfigProvider).dark
          ? ThemeMode.dark
          : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light, // 디폴트 글자 색상
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 1.0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedIconTheme: const IconThemeData(
            color: Colors.black,
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.grey.shade400,
          ),
        ),
        primaryColor: Colors.blue[400],
        textTheme: TextTheme(
          displayLarge: GoogleFonts.openSans(
              fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
          displayMedium: GoogleFonts.openSans(
              fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
          displaySmall:
              GoogleFonts.openSans(fontSize: 48, fontWeight: FontWeight.w400),
          headlineMedium: GoogleFonts.openSans(
              fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          headlineSmall:
              GoogleFonts.openSans(fontSize: 28, fontWeight: FontWeight.w800),
          titleLarge: GoogleFonts.openSans(
              fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: 0.15),
          titleMedium: GoogleFonts.openSans(
              fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 0.15),
          titleSmall: GoogleFonts.openSans(
              fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.1),
          bodyLarge: GoogleFonts.roboto(
              fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: 0.5),
          bodyMedium: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          labelLarge: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
          bodySmall: GoogleFonts.roboto(
              fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
          labelSmall: GoogleFonts.roboto(
              fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark, // 디폴트 글자 색상
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          surfaceTintColor: Colors.black,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.black,
          surfaceTintColor: Colors.black,
          elevation: 1.0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedIconTheme: const IconThemeData(
            color: Colors.white,
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.grey.shade600,
          ),
        ),
        primaryColor: Colors.blue[400],
        textTheme: TextTheme(
          displayLarge: GoogleFonts.openSans(
              fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
          displayMedium: GoogleFonts.openSans(
              fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
          displaySmall:
              GoogleFonts.openSans(fontSize: 48, fontWeight: FontWeight.w400),
          headlineMedium: GoogleFonts.openSans(
              fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          headlineSmall:
              GoogleFonts.openSans(fontSize: 28, fontWeight: FontWeight.w800),
          titleLarge: GoogleFonts.openSans(
              fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: 0.15),
          titleMedium: GoogleFonts.openSans(
              fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 0.15),
          titleSmall: GoogleFonts.openSans(
              fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.1),
          bodyLarge: GoogleFonts.roboto(
              fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: 0.5),
          bodyMedium: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          labelLarge: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
          bodySmall: GoogleFonts.roboto(
              fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
          labelSmall: GoogleFonts.roboto(
              fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
        ),
      ),
    );
  }
}
