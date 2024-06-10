import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_time/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:navigation_time/router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: NavigationTime(),
    ),
  );
}

class NavigationTime extends StatelessWidget {
  const NavigationTime({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        useMaterial3: true,
      ),
    );
  }
}
