import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/features/authentication/check_account_screen.dart';
import 'package:thread_clone/features/authentication/widgets/form_button.dart';

class CustomizeExperienceScreen extends StatefulWidget {
  final Map<String, String> formData;

  const CustomizeExperienceScreen({super.key, required this.formData});

  @override
  State<CustomizeExperienceScreen> createState() =>
      _CustomizeExperienceScreenState();
}

class _CustomizeExperienceScreenState extends State<CustomizeExperienceScreen> {
  bool _agreement = false;

  void _onTapCancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onAgreementChanged(bool? newValue) {
    if (newValue == null) return;

    setState(() {
      _agreement = newValue;
    });
  }

  void _onSubmitTap() {
    if (!_agreement) return;

    // print(formData);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckAccountScreen(
          formData: widget.formData,
        ),
        // fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.formData);
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
          children: [
            Text(
              "Customize your experience",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Gaps.v28,
            Text(
              "Track where you see Twitter content across the web",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Gaps.v24,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Twitter uses this data to personalize your experience. This web browsing history will never be stored with your name, email, or phone number.",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Switch.adaptive(
                  value: _agreement,
                  onChanged: _onAgreementChanged,
                ),
              ],
            ),
            Gaps.v32,
            RichText(
              text: TextSpan(
                text: "By signing up, you agree to our ",
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: "Terms,",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  TextSpan(
                    text: "Privacy Policy,",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  TextSpan(
                    text: " and ",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: "Cookie Use.",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  TextSpan(
                    text:
                        " Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy.",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: " Learn more",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: _onSubmitTap,
                  child: FormButton(
                    isLarge: true,
                    disabled: !_agreement,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
