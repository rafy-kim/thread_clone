import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/constants/sizes.dart';
import 'package:thread_clone/features/activity/models/activity_model.dart';
import 'package:thread_clone/features/activity/view_models/activity_view_models.dart';
import 'package:thread_clone/features/activity/views/widgets/activity_tile.dart';
import 'package:thread_clone/features/search/view_models/search_users_view_models.dart';
import 'package:thread_clone/features/users/views/widgets/user_tile.dart';

final tabs = [
  "All",
  "Replies",
  "Mentions",
  "Verified",
];

class ActivityScreen extends ConsumerStatefulWidget {
  const ActivityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends ConsumerState<ActivityScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // 스크롤이 맨 아래에서 200픽셀 이내에 도달했을 때
      print("Almost reached the bottom");
      for (var i = 0; i < 10; i++) {
        ref.read(searchUsersProvider.notifier).addFaker();
      }
    }
  }

  Future<void> _onRefresh() {
    return Future.delayed(
      const Duration(seconds: 5),
    );
  }

  List<ActivityModel> filterActivitiesByActionType(
      List<ActivityModel> activities, String actionType) {
    return activities
        .where((activity) => activity.actionType == actionType)
        .toList();
  }

  int randomNumber() {
    Random random = Random();
    return random.nextInt(4);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(activitiesProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              "could not load videos: $error",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          data: (activities) => RefreshIndicator(
            onRefresh: _onRefresh,
            displacement: 50,
            edgeOffset: 20,
            color: Theme.of(context).primaryColor,
            child: DefaultTabController(
              length: 4,
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: false,
                  title: const Text(
                    "Activity",
                    style: TextStyle(
                      fontSize: Sizes.size32,
                      fontWeight: FontWeight.w800,
                    ),
                  ), //,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  bottom: TabBar(
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    dividerColor: Colors.white,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    tabs: [
                      for (var tab in tabs) _buildTab(tab),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverList.separated(
                          itemCount: activities.length,
                          itemBuilder: (context, index) => ActivityTile(
                            userImg: activities[index].userImg,
                            username: activities[index].userName,
                            timeAgo: "${activities[index].time}h",
                            actionType: activities[index].actionType,
                            actionDescription:
                                activities[index].actionDescription!,
                            hasTrailingWidget: activities[index].followButton!,
                            randNumber: randomNumber(),
                          ),
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 0.5,
                          ),
                        ),
                      ],
                    ),
                    CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverList.separated(
                          itemCount: filterActivitiesByActionType(
                                  activities, "Replied you")
                              .length,
                          itemBuilder: (context, index) => ActivityTile(
                            userImg: filterActivitiesByActionType(
                                    activities, "Replied you")[index]
                                .userImg,
                            username: filterActivitiesByActionType(
                                    activities, "Replied you")[index]
                                .userName,
                            timeAgo:
                                "${filterActivitiesByActionType(activities, "Replied you")[index].time}h",
                            actionType: filterActivitiesByActionType(
                                    activities, "Replied you")[index]
                                .actionType,
                            actionDescription: filterActivitiesByActionType(
                                    activities, "Replied you")[index]
                                .actionDescription!,
                            hasTrailingWidget: filterActivitiesByActionType(
                                    activities, "Replied you")[index]
                                .followButton!,
                            randNumber: randomNumber(),
                          ),
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 0.5,
                          ),
                        ),
                      ],
                    ),
                    CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverList.separated(
                          itemCount: filterActivitiesByActionType(
                                  activities, "Mentioned you")
                              .length,
                          itemBuilder: (context, index) => ActivityTile(
                            userImg: filterActivitiesByActionType(
                                    activities, "Mentioned you")[index]
                                .userImg,
                            username: filterActivitiesByActionType(
                                    activities, "Mentioned you")[index]
                                .userName,
                            timeAgo:
                                "${filterActivitiesByActionType(activities, "Mentioned you")[index].time}h",
                            actionType: filterActivitiesByActionType(
                                    activities, "Mentioned you")[index]
                                .actionType,
                            actionDescription: filterActivitiesByActionType(
                                    activities, "Mentioned you")[index]
                                .actionDescription!,
                            hasTrailingWidget: filterActivitiesByActionType(
                                    activities, "Mentioned you")[index]
                                .followButton!,
                            randNumber: randomNumber(),
                          ),
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 0.5,
                          ),
                        ),
                      ],
                    ),
                    for (var tab in tabs.skip(3))
                      Center(
                        child: Text(
                          tab,
                          style: const TextStyle(
                            fontSize: Sizes.size28,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        );
  }
}

Widget _buildTab(String text) {
  return Tab(
    height: 40,
    child: Container(
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      // padding: const EdgeInsets.symmetric(
      //   horizontal: 16.0,
      //   vertical: 10,
      // ),
      child: Align(
        alignment: Alignment.center,
        child: Text(text),
      ),
    ),
  );
}

class _SliverSearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      alignment: Alignment.center,
      child: const CupertinoSearchTextField(),
    );
  }

  @override
  double get maxExtent => 80.0;

  @override
  double get minExtent => 80.0;

  @override
  bool shouldRebuild(_SliverSearchBarDelegate oldDelegate) {
    return false;
  }
}


// SafeArea(
//               child: CustomScrollView(
//                 controller: _scrollController,
//                 slivers: [
//                   SliverAppBar(
//                     // pinned: true,
//                     collapsedHeight: 60,
//                     expandedHeight: 80,
//                     flexibleSpace: FlexibleSpaceBar(
//                       // title: const Text("Search"),
//                       background: Container(
//                         alignment: Alignment.bottomLeft,
//                         padding: const EdgeInsets.only(top: 20, left: 20),
//                         child: const Text(
//                           "Search",
//                           style: TextStyle(
//                             fontSize: Sizes.size32,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ), // 상단에만 고정될 텍스트
//                       ),
//                     ),
//                   ),
//                   SliverPersistentHeader(
//                     delegate: _SliverSearchBarDelegate(),
//                     // pinned: true, // CupertinoSearchTextField 고정
//                     floating: true,
//                   ),
//                   SliverList.separated(
//                     itemCount: activities.length,
//                     itemBuilder: (context, index) => ActivityTile(
//                       userImg: activities[index].userImg,
//                       username: activities[index].userName,
//                       timeAgo: "${activities[index].time}h",
//                       actionType: activities[index].actionType,
//                       actionDescription: activities[index].actionDescription!,
//                       hasTrailingWidget: activities[index]
//                           .followButton!, // 트레일링 위젯이 필요 없는 경우 null
//                     ),
//                     separatorBuilder: (context, index) => const Divider(
//                       thickness: 0.5,
//                     ),
//                   ),
//                 ],
//               ),
//             ),