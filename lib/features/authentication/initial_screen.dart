import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/constants/sizes.dart';
import 'package:thread_clone/features/authentication/create_account_screen.dart';

class InitialScreen extends StatelessWidget {
  static const routeURL = "/";
  static const routeName = "signUp";

  const InitialScreen({super.key});

  void _onTapAuth(String service, BuildContext context) {
    if (service == "Here") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const CreateAccountScreen(),
        ),
      );
    }
    print("Hello $service");
  }

  void _onTapLogin(BuildContext context) {
    print("Login Screen으로 고고");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FaIcon(
          FontAwesomeIcons.twitter,
          color: Theme.of(context).primaryColor,
          size: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Gaps.v80,
            Text(
              "See what's happening in the world right now.",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Gaps.v80,
            AuthButton(
              title: "Continue with Google",
              logo: FontAwesomeIcons.google,
              isOauth: true,
              onTap: () => _onTapAuth("Google", context),
            ),
            Gaps.v16,
            AuthButton(
              title: "Continue with Apple",
              logo: FontAwesomeIcons.apple,
              isOauth: true,
              onTap: () => _onTapAuth("Apple", context),
            ),
            Gaps.v24,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.37,
                  child: const Divider(color: Colors.black, thickness: 0.5),
                ),
                const Text(
                  "   or   ",
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.37,
                  child: const Divider(color: Colors.black, thickness: 0.5),
                ),
              ],
            ),
            Gaps.v5,
            AuthButton(
              title: "Create account",
              isOauth: false,
              onTap: () => _onTapAuth("Here", context),
            ),
            Gaps.v32,
            Row(
              children: [
                Text(
                  "By signing up, you agree to our ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "Terms,",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Privacy Policy,",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                Text(
                  " and ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "Cookie Use.",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ],
            ),
            Gaps.v48,
            Row(
              children: [
                Text(
                  "Have an account already? ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                GestureDetector(
                  onTap: () => _onTapLogin(context),
                  child: Text(
                    "Log in",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  final String title;
  final IconData? logo;
  final bool isOauth;
  final Function onTap;

  const AuthButton({
    super.key,
    required this.title,
    this.logo,
    required this.isOauth,
    required this.onTap,
  });

  void _onTap() {
    onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        height: Sizes.size60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1.0,
          ),
          color: isOauth ? Colors.white : Colors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (logo != null)
              Row(
                children: [
                  FaIcon(
                    logo,
                  ),
                  Gaps.h20,
                ],
              ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: isOauth ? Colors.black : Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
