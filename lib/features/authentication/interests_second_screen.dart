import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/features/authentication/widgets/form_button.dart';
import 'package:thread_clone/features/authentication/widgets/interest_big_button.dart';
import 'package:thread_clone/features/authentication/widgets/interest_button.dart';

const musics = [
  "Rap",
  "R&B soul",
  "Grammy Awards",
  "Pop",
  "K-pop",
  "Music industry",
  "Music news",
  "Hip hop",
  "Reggae",
  "Soul",
  "Country",
  "Funk",
  "Folk",
  "Middle Eastern",
  "Jazz",
  "Disco",
  "Classical",
  "Electronic",
  "New-age",
  "Christian",
  "Independent",
];

const entertainments = [
  "Anime",
  "Movies & TV",
  "Harry Potter",
  "Marvel Universe",
  "Movie news",
  "Movies",
  "Grammy Awards",
  "Science Fiction",
  "Fantasy",
  "Horror",
  "Comedy",
  "Drama",
  "Western",
  "Thriller",
  "Historical Fiction",
  "Action",
  "Adventure",
  "Crime",
  "Mistery",
  "Romance",
];

class InterestsSecondScreen extends StatefulWidget {
  const InterestsSecondScreen({super.key});

  @override
  State<InterestsSecondScreen> createState() => _InterestsSecondScreenState();
}

class _InterestsSecondScreenState extends State<InterestsSecondScreen> {
  List<String> userInterests = [];

  void _selectInterest(isSelected, interest) {
    if (isSelected) {
      userInterests.add(interest);
    } else {
      userInterests.remove(interest);
    }
    setState(() {});
    print(userInterests);
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
                    "Interests are used to personalize your experience and will be visible on your profile.",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey, thickness: 0.3),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Music",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Gaps.v28,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      // padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 2.3,
                      child: Wrap(
                        // direction: Axis.vertical,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: 15.0,
                        runSpacing: 15.0,
                        children: [
                          for (var music in musics)
                            InterestButton(
                              interest: music,
                              // selectInterest: _selectInterest,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey, thickness: 0.3),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Entertainments",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Gaps.v28,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      // padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 2.3,
                      child: Wrap(
                        // direction: Axis.vertical,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: 15.0,
                        runSpacing: 15.0,
                        children: [
                          for (var entertainment in entertainments)
                            InterestButton(
                              interest: entertainment,
                              // selectInterest: _selectInterest,
                            ),
                        ],
                      ),
                    ),
                  ),
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const FormButton(
                    isLarge: false,
                    disabled: false,
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
