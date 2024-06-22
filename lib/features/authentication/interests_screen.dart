import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/features/authentication/interests_second_screen.dart';
import 'package:thread_clone/features/authentication/widgets/form_button.dart';
import 'package:thread_clone/features/authentication/widgets/interest_big_button.dart';

const interests = [
  "Fashion & beauty",
  "Music",
  "Entertainment",
  "Outdoors",
  "Arts & culture",
  "Travel",
  "Animation & comics",
  "Business & finance",
  "Food",
  "Sports",
  "Gaming",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
  "Daily Life",
  "Entertainment",
  "Animals",
  "Beauty & Style",
  "Learning",
  "Talent",
  "Auto",
  "Family",
  "DIY & Life Hacks",
  "Oddly Satisfying",
  "Home & Garden",
];

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  List<String> userInterests = [];

  void _selectInterest(isSelected, interest) {
    if (isSelected) {
      userInterests.add(interest);
    } else {
      userInterests.remove(interest);
    }
    setState(() {});
  }

  void _onSubmit() {
    if (userInterests.length < 3) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const InterestsSecondScreen(),
      ),
    );
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Text(
                    "What do you want to see on Twitter?",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Gaps.v28,
                  Text(
                    "Select at least 3 interests to personalize your Twitter experience. They will be visible on your profile.",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey, thickness: 0.3),
            Gaps.v32,
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 15,
                spacing: 15,
                children: [
                  for (var interest in interests)
                    InterestBigButton(
                      interest: interest,
                      selectInterest: _selectInterest,
                    )
                ],
              ),
            ),
            Gaps.v32,
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (userInterests.length > 2)
                    ? const Text("Great work 🎉")
                    : Text("${userInterests.length} of 3 selected"),
                GestureDetector(
                  onTap: _onSubmit,
                  child: FormButton(
                    isLarge: false,
                    disabled: (userInterests.length < 3),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
