import 'package:flutter/material.dart';
import 'package:thread_clone/constants/sizes.dart';
import 'package:thread_clone/utils.dart';

class PersistentTabbar extends SliverPersistentHeaderDelegate {
  final TabController tabController;
  const PersistentTabbar({
    required this.tabController,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final isDark = isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.black : Colors.white,
      ),
      child: TabBar(
        controller: tabController,
        splashFactory: NoSplash.splashFactory,
        indicatorColor: isDark ? Colors.white : Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerHeight: 0.5,
        labelColor: isDark ? Colors.white : Colors.black,
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
