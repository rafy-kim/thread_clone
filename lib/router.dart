import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thread_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:thread_clone/features/authentication/initial_screen.dart';

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: "/home",
      // redirect: (context, state) {
      //   final isLoggedIn = ref.read(authRepo).isLoggedIn;
      //   if (!isLoggedIn) {
      //     if (state.subloc != SignUpScreen.routeURL &&
      //         state.subloc != LoginScreen.routeURL) {
      //       return SignUpScreen.routeURL;
      //     }
      //   }
      //   return null;
      // },
      routes: [
        GoRoute(
          name: InitialScreen.routeName,
          path: InitialScreen.routeURL,
          builder: (context, state) => const InitialScreen(),
        ),
        GoRoute(
          name: MainNavigationScreen.routeName,
          path: "/:tab(home|search|like|user)",
          builder: (context, state) {
            final tab = state.params["tab"]!;
            return MainNavigationScreen(tab: tab);
          },
        ),
        // GoRoute(
        //   name: SettingsScreen.routeName,
        //   path: SettingsScreen.routeURL,
        //   builder: (context, state) => const SettingsScreen(),
        // ),
        // GoRoute(
        //   name: PrivacyScreen.routeName,
        //   path: PrivacyScreen.routeURL,
        //   builder: (context, state) => const PrivacyScreen(),
        // ),
        // GoRoute(
        //   name: ChatsScreen.routeName,
        //   path: ChatsScreen.routeURL,
        //   builder: (context, state) => const ChatsScreen(),
        //   routes: [
        //     GoRoute(
        //       name: ChatDetailScreen.routeName,
        //       path: ChatDetailScreen.routeURL,
        //       builder: (context, state) {
        //         final chatId = state.params["chatId"]!;
        //         return ChatDetailScreen(
        //           chatId: chatId,
        //         );
        //       },
        //     )
        //   ],
        // ),
        // GoRoute(
        //   name: VideoRecordingScreen.routeName,
        //   path: VideoRecordingScreen.routeURL,
        //   pageBuilder: (context, state) => CustomTransitionPage(
        //     transitionDuration: const Duration(milliseconds: 200),
        //     child: const VideoRecordingScreen(),
        //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
        //       final position = Tween(
        //         begin: const Offset(0, 1),
        //         end: Offset.zero,
        //       ).animate(animation);
        //       return SlideTransition(
        //         position: position,
        //         child: child,
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  },
);
