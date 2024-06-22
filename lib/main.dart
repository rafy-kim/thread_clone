import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thread_clone/router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: ThreadClone(),
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
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
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
