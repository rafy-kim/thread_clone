import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/features/authentication/widgets/form_button.dart';
import 'package:thread_clone/features/authentication/widgets/otp_input.dart';

class ConfirmationCodeScreen extends StatefulWidget {
  final Map<String, String>? formData;
  const ConfirmationCodeScreen({
    super.key,
    this.formData,
  });

  @override
  State<ConfirmationCodeScreen> createState() => _ConfirmationCodeScreenState();
}

class _ConfirmationCodeScreenState extends State<ConfirmationCodeScreen> {
  bool _isValid = false;

  void _onTapCancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _checkValid(val) {
    setState(() {
      _isValid = val;
    });
  }

  void _onSubmitTap() {
    if (!_isValid) {
      return;
    }

    // print(formData);
    context.go("/home");
    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(
    //     builder: (context) => const PasswordScreen(),
    //   ),
    //   (route) => false,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => _onTapCancel(context),
          child: Container(
            alignment: Alignment.center,
            child: const FaIcon(FontAwesomeIcons.arrowLeft),
          ),
        ),
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
              "We sent you a code",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Gaps.v28,
            Text(
              "Enter it below to verify ${widget.formData ?? ['email']}.",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Gaps.v32,
            OTPInput(
              checkValid: _checkValid,
            ),
            Gaps.v20,
            if (_isValid)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    color: Colors.green[400],
                  ),
                ],
              ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 10,
                  ),
                  child: Text(
                    "Didn't receive email?",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _onSubmitTap,
                  child: FormButton(
                    isLarge: true,
                    disabled: !_isValid,
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
