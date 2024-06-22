import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:thread_clone/constants/gaps.dart';

class PrivacyScreen extends ConsumerStatefulWidget {
  static const String routeName = "privacy";
  static const String routeURL = "/privacy";
  const PrivacyScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends ConsumerState<PrivacyScreen> {
  bool _privacy = false;

  void _setPrivacy() {
    setState(() {
      _privacy = !_privacy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Row(
            children: [
              Gaps.h10,
              FaIcon(FontAwesomeIcons.chevronLeft),
              Gaps.h10,
              Text(
                "Back",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 0.5,
          ),
        ),
        title: const Text(
          'Privacy',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.lock,
            ),
            title: const Text("Private profile"),
            trailing: Switch.adaptive(
              value: _privacy,
              onChanged: (value) => _setPrivacy(),
            ),
          ),
          const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.at,
            ),
            title: Text("Mentions"),
            trailing: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Everyone",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                Gaps.h10,
                FaIcon(FontAwesomeIcons.chevronRight,
                    size: 16.0, color: Colors.grey),
              ],
            ),
          ),
          const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.bellSlash,
            ),
            title: Text("Muted"),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              size: 16.0,
              color: Colors.grey,
            ),
          ),
          const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.eyeSlash,
            ),
            title: Text("Hidden Words"),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              size: 16.0,
              color: Colors.grey,
            ),
          ),
          const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.userGroup,
            ),
            title: Text("Profile you follow"),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              size: 16.0,
              color: Colors.grey,
            ),
          ),
          const Divider(
            thickness: 0.5,
          ),
          const ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Other privacy settings"),
                FaIcon(
                  FontAwesomeIcons.shareFromSquare,
                  size: 16.0,
                  color: Colors.grey,
                ),
              ],
            ),
            subtitle: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram.",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.circleXmark,
            ),
            title: Text("Blocked profiles"),
            trailing: FaIcon(
              FontAwesomeIcons.shareFromSquare,
              size: 16.0,
              color: Colors.grey,
            ),
          ),
          const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.heartCrack,
            ),
            title: Text("Hide likes"),
            trailing: FaIcon(
              FontAwesomeIcons.shareFromSquare,
              size: 16.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
