import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_time/constants/gaps.dart';
import 'package:navigation_time/constants/sizes.dart';
import 'package:navigation_time/features/posts/view_models/replies_view_model.dart';
import 'package:navigation_time/features/posts/view_models/threads_view_model.dart';
import 'package:navigation_time/features/posts/view_models/timeline_view_model.dart';
import 'package:navigation_time/features/posts/views/widgets/post.dart';
import 'package:navigation_time/features/settings/settings_screen.dart';
import 'package:navigation_time/features/users/views/widgets/persistent_tabbar.dart';
import 'package:navigation_time/features/users/views/widgets/profile_button.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;

  const ProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // _tabController.addListener(_handleTabChange);
    Future.delayed(
      Duration.zero,
      () {
        for (var i = 0; i < 10; i++) {
          ref.read(timelineProvider.notifier).addFaker();
        }
      },
    );
  }

  @override
  void dispose() {
    // _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // void _handleTabChange() {
  //   print('changed');
  //   print("Current Tab Index: ${_tabController.index}");
  //   if (_tabController.indexIsChanging) {
  //     print("Current Tab Index: ${_tabController.index}");
  //   }
  // }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // 스크롤이 맨 아래에서 200픽셀 이내에 도달했을 때
      print("Almost reached the bottom");
      for (var i = 0; i < 10; i++) {
        if (_tabController.index == 0) {
          ref.read(threadsProvider.notifier).addFaker();
        } else {
          ref.read(repliesProvider.notifier).addFaker();
        }
      }
    }
  }

  void _onBarsPressed() {
    // context.go(SettingsScreen.routeURL);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final threadPosts = ref.watch(threadsProvider);
    final repliesPosts = ref.watch(repliesProvider);

    return SafeArea(
      child: DefaultTabController(
        initialIndex: widget.tab == "threads" ? 1 : 0,
        length: 2,
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                leading: IconButton(
                  onPressed: () {},
                  icon: const FaIcon(
                    FontAwesomeIcons.globe,
                    size: Sizes.size20,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.instagram,
                      size: Sizes.size20,
                    ),
                  ),
                  IconButton(
                    onPressed: _onBarsPressed,
                    icon: const FaIcon(
                      FontAwesomeIcons.bars,
                      size: Sizes.size20,
                    ),
                  )
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Rafy",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Gaps.v10,
                              Row(
                                children: [
                                  const Text(
                                    "juvwind",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Gaps.h10,
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(
                                          20,
                                        )),
                                    child: Text(
                                      "threads.net",
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const CircleAvatar(
                            radius: 36,
                            foregroundImage: NetworkImage(
                                "https://d1telmomo28umc.cloudfront.net/media/public/avatars/juvwind-avatar.jpg"),
                            child: Text("rafy"),
                          ),
                        ],
                      ),
                      Gaps.v10,
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Realizer!",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gaps.v20,
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                            height: 30,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  left: 0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.teal[200],
                                    foregroundColor: Colors.white,
                                    radius: 15.0,
                                    child: const Text("A"),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.amber[200],
                                    foregroundColor: Colors.white,
                                    radius: 15.0,
                                    child: const Text("B"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gaps.h10,
                          const Expanded(child: Text("2 followers")),
                        ],
                      ),
                      Gaps.v20,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProfileButton(
                            name: "Edit profile",
                          ),
                          ProfileButton(
                            name: "Share profile",
                          ),
                        ],
                      ),
                      Gaps.v20,
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: PersistentTabbar(
                  tabController: _tabController,
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              threadPosts.when(
                data: (posts) => ListView.separated(
                  itemCount: posts.length,
                  itemBuilder: (context, index) => Post(
                    userName: posts[index].userName,
                    content: posts[index].content,
                    imgs: posts[index].imgs ?? [],
                  ),
                  separatorBuilder: (context, index) => Gaps.v10,
                ),
                error: (error, stack) => Center(child: Text('Error: $error')),
                loading: () =>
                    const Center(child: CircularProgressIndicator.adaptive()),
              ),
              repliesPosts.when(
                data: (posts) => ListView.separated(
                  itemCount: posts.length,
                  itemBuilder: (context, index) => Post(
                    userName: posts[index].userName,
                    content: posts[index].content,
                    imgs: posts[index].imgs ?? [],
                  ),
                  separatorBuilder: (context, index) => Gaps.v10,
                ),
                error: (error, stack) => Center(child: Text('Error: $error')),
                loading: () =>
                    const Center(child: CircularProgressIndicator.adaptive()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
