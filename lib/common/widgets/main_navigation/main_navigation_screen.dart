import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_time/common/widgets/main_navigation/widgets/nav_tab.dart';
import 'package:navigation_time/constants/gaps.dart';
import 'package:navigation_time/constants/sizes.dart';
import 'package:navigation_time/features/activity/views/activity_screen.dart';
import 'package:navigation_time/features/posts/views/post_timeline_screen.dart';
import 'package:navigation_time/features/posts/views/widgets/modal_sheet.dart';
import 'package:navigation_time/features/posts/views/widgets/new_post.dart';
import 'package:navigation_time/features/search/views/search_screen.dart';
import 'package:navigation_time/features/users/views/profile_screen.dart';
import 'package:navigation_time/utils.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = "mainNavigation";
  final String tab;
  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "home",
    "search",
    "post",
    "like",
    "user",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) async {
    if (index == 2) {
      await showModalBottomSheet(
        context: context,
        // showDragHandle: true,
        isScrollControlled: true,
        // barrierColor: Colors.red,
        // backgroundColor: Colors.transparent,
        builder: (context) => const NewPost(),
      );
    } else {
      context.go("/${_tabs[index]}");
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final isDark = isDarkMode(context);
    print(_selectedIndex);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor:
      //     _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            // child: const VideoTimelineScreen(),
            child: const PostTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            // child: const DiscoverScreen(),
            child: const SearchScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            // child: const InboxScreen(),
            child: const ActivityScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const ProfileScreen(
              username: "Rafy",
              tab: "",
            ),
            // child: const UserProfileScreen(
            //   username: "라피",
            //   tab: "",
            // ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade400,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: "Home",
            // backgroundColor: Colors.amber,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: "Search",
            // backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.penToSquare),
            label: "Post",
            // backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.heart),
            label: "Like",
            // backgroundColor: Colors.yellow,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: "User",
            // backgroundColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}







// Container(
//         // surfaceTintColor: Colors.white,
//         // shadowColor: Colors.black,
//         // elevation: 1,
//         padding: const EdgeInsets.only(
//           bottom: Sizes.size24,
//         ),
//         // color: _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
//         child: Padding(
//           padding: const EdgeInsets.all(Sizes.size12),
//           // padding: const EdgeInsets.symmetric(vertical: Sizes.size12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               NavTab(
//                 text: "Home",
//                 isSelected: _selectedIndex == 0,
//                 icon: FontAwesomeIcons.house,
//                 selectedIcon: FontAwesomeIcons.house,
//                 onTap: () => _onTap(0),
//                 selectedIndex: _selectedIndex,
//               ),
//               NavTab(
//                 text: "Discover",
//                 isSelected: _selectedIndex == 1,
//                 icon: FontAwesomeIcons.compass,
//                 selectedIcon: FontAwesomeIcons.solidCompass,
//                 onTap: () => _onTap(1),
//                 selectedIndex: _selectedIndex,
//               ),
//               Gaps.h24,
//               GestureDetector(
//                 onTap: _onPostVideoButtonTap,
//                 child: Container(),
//               ),
//               Gaps.h24,
//               NavTab(
//                 text: "Inbox",
//                 isSelected: _selectedIndex == 3,
//                 icon: FontAwesomeIcons.message,
//                 selectedIcon: FontAwesomeIcons.solidMessage,
//                 onTap: () => _onTap(3),
//                 selectedIndex: _selectedIndex,
//               ),
//               NavTab(
//                 text: "Profile",
//                 isSelected: _selectedIndex == 4,
//                 icon: FontAwesomeIcons.user,
//                 selectedIcon: FontAwesomeIcons.solidUser,
//                 onTap: () => _onTap(4),
//                 selectedIndex: _selectedIndex,
//               ),
//             ],
//           ),
//         ),
//       ),