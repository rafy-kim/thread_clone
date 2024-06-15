import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActivityTile extends StatelessWidget {
  final String userImg;
  final String username;
  final String timeAgo;
  final String actionType;
  final String actionDescription;
  final bool hasTrailingWidget;
  final int randNumber;

  ActivityTile({
    super.key,
    required this.userImg,
    required this.username,
    required this.timeAgo,
    required this.actionType,
    required this.actionDescription,
    required this.hasTrailingWidget,
    required this.randNumber,
  });

  final smallCircles = [
    CircleAvatar(
      radius: 10,
      backgroundColor: Colors.green[300],
      child: const FaIcon(
        FontAwesomeIcons.threads,
        color: Colors.white,
        size: 10,
      ),
    ),
    CircleAvatar(
      radius: 10,
      backgroundColor: Colors.blue[300],
      child: const FaIcon(
        FontAwesomeIcons.share,
        color: Colors.white,
        size: 10,
      ),
    ),
    CircleAvatar(
      radius: 10,
      backgroundColor: Colors.purple[700],
      child: const FaIcon(
        FontAwesomeIcons.user,
        color: Colors.white,
        size: 10,
      ),
    ),
    CircleAvatar(
      radius: 10,
      backgroundColor: Colors.pink[600],
      child: const FaIcon(
        FontAwesomeIcons.heart,
        color: Colors.white,
        size: 10,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(userImg),
          ),
          Positioned(
            bottom: 0,
            right: -5,
            child: actionType == "Mentioned you"
                ? smallCircles[2]
                : actionType == "Replied you"
                    ? smallCircles[1]
                    : smallCircles[randNumber],
          ),
        ],
      ),
      title: Row(
        children: [
          Text(
            username,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 4),
          Text(
            timeAgo,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            actionType,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(actionDescription),
        ],
      ),
      trailing: !hasTrailingWidget
          ? null
          : GestureDetector(
              onTap: () => {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: Colors.grey.shade400,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Following",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
    );
  }
}
