import 'package:flutter/material.dart';
import 'package:navigation_time/constants/sizes.dart';

class ProfileButton extends StatelessWidget {
  final String name;
  const ProfileButton({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.43,
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size12,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
        // color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            Sizes.size10,
          ),
        ),
      ),
      child: Text(
        name,
        style: const TextStyle(
          // color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
