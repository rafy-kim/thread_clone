import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time/constants/gaps.dart';
import 'package:navigation_time/constants/sizes.dart';
import 'package:navigation_time/features/posts/views/widgets/modal_sheet.dart';

class UserTile extends StatelessWidget {
  final String userName;
  final String bio;
  final String? userImg;
  final bool? authorized;
  final int? followers;
  const UserTile({
    super.key,
    required this.userName,
    required this.bio,
    this.userImg,
    this.authorized,
    this.followers,
  });

  void _onFollowTap(BuildContext context) async {
    // await showModalBottomSheet(
    //   context: context,
    //   showDragHandle: true,
    //   isScrollControlled: true,
    //   // barrierColor: Colors.red,
    //   // backgroundColor: Colors.transparent,
    //   builder: (context) => const ModalSheet(),
    // );
  }

  String formatNumber(int number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(userImg!), // 프로필 이미지 URL
      ),
      title: Row(
        children: [
          Text(
            userName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.verified,
            color: Colors.blue,
            size: 20,
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bio,
            style: TextStyle(
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${formatNumber(followers!)} followers',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      trailing: GestureDetector(
        onTap: () => _onFollowTap(context),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 26,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: Colors.grey.shade400,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            "Follow",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
