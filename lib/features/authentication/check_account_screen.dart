import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/features/authentication/confirmation_code_screen.dart';
import 'package:thread_clone/features/authentication/widgets/form_button.dart';

class CheckAccountScreen extends StatefulWidget {
  final Map<String, String> formData;
  const CheckAccountScreen({
    super.key,
    required this.formData,
  });

  @override
  State<CheckAccountScreen> createState() => _CheckAccountScreenState();
}

class _CheckAccountScreenState extends State<CheckAccountScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birtydayController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.formData['name'].toString();
    _emailController.text = widget.formData['email'].toString();
    _birtydayController.text = widget.formData['birthday'].toString();
  }

  void _onTapCancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onSubmitTap() {
    // print(widget.formData);
    // print("제출 완료!");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmationCodeScreen(
          formData: widget.formData,
        ),
        // fullscreenDialog: true,
      ),
    );
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
        child: Form(
          child: Column(
            children: [
              Text(
                "Create your account",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Gaps.v32,
              TextFormField(
                readOnly: true,
                controller: _nameController,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                decoration: InputDecoration(
                  suffix: FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    color: Colors.green[400],
                  ),
                  labelText: 'Name',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
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
                validator: (value) {
                  // if (value != null && value.isEmpty) {
                  //   return "Please write your name";
                  // }
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue != null) {
                    widget.formData['name'] = newValue;
                  }
                },
              ),
              Gaps.v16,
              TextFormField(
                readOnly: true,
                controller: _emailController,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                decoration: InputDecoration(
                  suffix: FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    color: Colors.green[400],
                  ),
                  // hintText: 'Phone number or email address',
                  labelText: 'Phone number or email address',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
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
                validator: (value) {
                  // if (value != null && value.isEmpty) {
                  //   return "Please write your email";
                  // }
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue != null) {
                    widget.formData['email'] = newValue;
                  }
                },
              ),
              Gaps.v16,
              TextFormField(
                readOnly: true,
                controller: _birtydayController,
                // onTapOutside: (event) => _setFocusBirth(false),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                decoration: InputDecoration(
                  suffix: FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    color: Colors.green[400],
                  ), // hintText: 'Date of birth',
                  labelText: 'Date of birth',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
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
                validator: (value) {
                  // if (value != null && value.isEmpty) {
                  //   return "Please write your email";
                  // }
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue != null) {
                    widget.formData['email'] = newValue;
                  }
                },
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "By signing up, you agree to the ",
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: "Terms of Service",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                            TextSpan(
                              text: " and ",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextSpan(
                              text: "Privacy Policy,",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                            TextSpan(
                              text: " including ",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextSpan(
                              text: "Cookie Use.",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                            TextSpan(
                              text:
                                  " Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy, like keeping your account secure and Personalizeing our services, including ads.",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextSpan(
                              text: " Learn more",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                            TextSpan(
                              text:
                                  ". Others will be able to find you by email or phone number, when provided, unless you choose otherwise",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextSpan(
                              text: " here.",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Gaps.v20,
                      GestureDetector(
                        onTap: _onSubmitTap,
                        child: FormButton(
                          isLarge: true,
                          disabled: false,
                          text: "Sign up",
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
