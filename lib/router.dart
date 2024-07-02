import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thread_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:thread_clone/features/authentication/repos/authentication_repository.dart';
import 'package:thread_clone/features/authentication/views/login_screen.dart';
import 'package:thread_clone/features/authentication/views/signup_screen.dart';
import 'package:thread_clone/features/settings/views/privacy_screen.dart';
import 'package:thread_clone/features/settings/views/settings_screen.dart';

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: "/",
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        if (!isLoggedIn) {
          if (state.subloc != SignupScreen.routeURL &&
              state.subloc != LoginScreen.routeURL) {
            return LoginScreen.routeURL;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          name: LoginScreen.routeName,
          path: LoginScreen.routeURL,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          name: SignupScreen.routeName,
          path: SignupScreen.routeURL,
          builder: (context, state) => const SignupScreen(),
        ),

        GoRoute(
          name: MainNavigationScreen.routeName,
          path: "/:tab(|search|activity|profile)",
          builder: (context, state) {
            final tab = state.params["tab"]!;
            return MainNavigationScreen(tab: tab);
          },
        ),
        GoRoute(
            name: SettingsScreen.routeName,
            path: SettingsScreen.routeURL,
            builder: (context, state) => const SettingsScreen(),
            routes: [
              GoRoute(
                name: PrivacyScreen.routeName,
                path: PrivacyScreen.routeURL,
                builder: (context, state) => const PrivacyScreen(),
              ),
            ]),
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
