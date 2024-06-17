import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time/constants/sizes.dart';

class PersistentTabbar extends SliverPersistentHeaderDelegate {
  final TabController tabController;
  const PersistentTabbar({
    required this.tabController,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // final isDark = isDarkMode(context);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: TabBar(
        controller: tabController,
        splashFactory: NoSplash.splashFactory,
        indicatorColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerHeight: 0.5,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        labelPadding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        tabs: const [
          Text(
            "Threads",
            style: TextStyle(
              fontSize: Sizes.size16,
            ),
          ),
          Text(
            "Replies",
            style: TextStyle(
              fontSize: Sizes.size16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 43;

  @override
  double get minExtent => 43;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
