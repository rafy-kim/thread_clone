import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/constants/sizes.dart';
import 'package:thread_clone/features/authentication/customize_experience_screen.dart';
import 'package:thread_clone/features/authentication/widgets/form_button.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _birthdayController = TextEditingController();
  late DateTime initialDate, maxinumDate;
  bool _focusBirth = false;

  Map<String, String> formData = {};

  @override
  void initState() {
    super.initState();
    DateTime today = DateTime.now();
    initialDate = DateTime(today.year - 15, today.month, today.day);
    maxinumDate = initialDate;
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  void _onTapCancel() {
    Navigator.of(context).pop();
  }

  void _onSubmitTap() {
    if (!_isNameValid() || !_isEmailValid() || !_isBirthdayValid()) {
      return;
    }

    // print(formData);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomizeExperienceScreen(
          formData: formData,
        ),
        // fullscreenDialog: true,
      ),
    );
  }

  void _nameSave(name) {
    setState(() {
      formData['name'] = name;
    });
  }

  bool _isNameValid() {
    if (formData['name'] == null) return false;
    return formData['name']!.isNotEmpty && formData['name']!.length >= 4;
  }

  void _emailSave(email) {
    setState(() {
      formData['email'] = email;
    });
  }

  bool _isEmailValid() {
    if (formData['email'] == null) return false;
    // perform valid
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(formData['email'].toString())) {
      return false;
    }
    return true;
  }

  void _setFocusBirth(val) {
    if (val && _birthdayController.value.text.isEmpty) {
      _setTextFieldDate(initialDate);
    }
    setState(() {
      _focusBirth = val;
    });
  }

  void _setTextFieldDate(DateTime date) {
    // final textDate = date.toString().split(" ").first;
    final textDate = DateFormat('MMMM d, yyyy').format(date);

    _birthdayController.value = TextEditingValue(text: textDate);
    initialDate = date;

    setState(() {
      formData['birthday'] = textDate;
    });
  }

  bool _isBirthdayValid() {
    if (formData['birthday'] == null) return false;
    return formData['birthday']!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: _onTapCancel,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "Cancel",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        leadingWidth: 100,
        title: FaIcon(
          FontAwesomeIcons.twitter,
          color: Theme.of(context).primaryColor,
          size: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Create your account",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Gaps.v32,
              TextFormField(
                onTap: () => _setFocusBirth(false),
                onChanged: (value) => _nameSave(value),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                decoration: InputDecoration(
                  suffix: _isNameValid()
                      ? FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          color: Colors.green[400],
                        )
                      : null,
                  // hintText: 'Name',
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
                    formData['name'] = newValue;
                  }
                },
              ),
              Gaps.v16,
              TextFormField(
                onTap: () => _setFocusBirth(false),
                onChanged: (value) => _emailSave(value),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                decoration: InputDecoration(
                  suffix: _isEmailValid()
                      ? FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          color: Colors.green[400],
                        )
                      : null,
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
                    formData['email'] = newValue;
                  }
                },
              ),
              Gaps.v16,
              TextFormField(
                readOnly: true,
                onTap: () => _setFocusBirth(true),
                // onTapOutside: (event) => _setFocusBirth(false),
                controller: _birthdayController,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                decoration: InputDecoration(
                  // hintText: 'Date of birth',
                  labelText: 'Date of birth',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  helper: !_focusBirth
                      ? null
                      : const Text(
                          "This will not be shown publicly. Confirm your own age, even if this account is for a business, a pet, or something else.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: Sizes.size16,
                          ),
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
                    formData['email'] = newValue;
                  }
                },
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: _onSubmitTap,
                    child: FormButton(
                      isLarge: false,
                      disabled: !_isNameValid() ||
                          !_isEmailValid() ||
                          !_isBirthdayValid(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: !_focusBirth
          ? null
          : Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
              ),
              child: BottomAppBar(
                height: 200,
                child: CupertinoDatePicker(
                  maximumDate: maxinumDate,
                  initialDateTime: initialDate,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: _setTextFieldDate,
                ),
              ),
            ),
    );
  }
}
