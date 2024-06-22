import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/constants/sizes.dart';
import 'package:thread_clone/features/authentication/interests_screen.dart';
import 'package:thread_clone/features/authentication/widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final bool _isValid = false;
  void _onTapCancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  final TextEditingController _passwordController = TextEditingController();

  String _password = "";

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  bool _isPasswordValid() {
    return _password.isNotEmpty && _password.length > 7;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (!_isPasswordValid()) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const InterestsScreen(),
      ),
      (route) => false,
    );
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _toogleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          // leading: GestureDetector(
          //   onTap: () => _onTapCancel(context),
          //   child: Container(
          //     alignment: Alignment.center,
          //     child: const FaIcon(FontAwesomeIcons.arrowLeft),
          //   ),
          // ),
          title: FaIcon(
            FontAwesomeIcons.twitter,
            color: Theme.of(context).primaryColor,
            size: 30,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "You'll need a password",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Gaps.v28,
              Text(
                "Make sure it's 8 characters or more.",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Gaps.v32,
              TextField(
                controller: _passwordController,
                // onSubmitted: (value) => ,
                onEditingComplete: _onSubmit,
                obscureText: _obscureText,
                obscuringCharacter: ' ',
                autocorrect: false,
                decoration: InputDecoration(
                  // prefixIcon: const Icon(Icons.ac_unit),
                  // suffixIcon: const Icon(Icons.add_business),
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // GestureDetector(
                      //   onTap: _onClearTap,
                      //   child: FaIcon(
                      //     FontAwesomeIcons.solidCircleXmark,
                      //     color: Colors.grey.shade500,
                      //     size: Sizes.size20,
                      //   ),
                      // ),
                      // Gaps.h16,
                      GestureDetector(
                        onTap: _toogleObscureText,
                        child: FaIcon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                      if (_isPasswordValid())
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Gaps.h16,
                            FaIcon(
                              FontAwesomeIcons.solidCircleCheck,
                              color: Colors.green[400],
                            ),
                          ],
                        ),
                    ],
                  ),
                  labelText: "Password",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  )),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  )),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              const Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _onSubmit,
                    child: FormButton(
                      isLarge: true,
                      disabled: !_isPasswordValid(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
