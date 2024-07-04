import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/constants/sizes.dart';
import 'package:thread_clone/features/search/view_models/search_users_view_models.dart';
import 'package:thread_clone/features/search/view_models/search_view_models.dart';
import 'package:thread_clone/features/users/views/widgets/user_tile.dart';
import 'package:thread_clone/utils.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final ScrollController _scrollController = ScrollController();
  String email = "";

  late final TextEditingController _textEditingController =
      TextEditingController(text: email);

  void _onSearchChanged(String value) {
    print("Searching form $value");
    setState(() {
      email = value;
    });
  }

  void _onSearchSubmitted(String value) {
    print("Submitted $value");
    setState(() {
      email = value;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return ref.watch(searchProvider(email)).when(
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
          data: (users) => RefreshIndicator(
            onRefresh: _onRefresh,
            displacement: 50,
            edgeOffset: 20,
            color: Theme.of(context).primaryColor,
            child: SafeArea(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    // pinned: true,
                    collapsedHeight: 60,
                    expandedHeight: 80,
                    flexibleSpace: FlexibleSpaceBar(
                      // title: const Text("Search"),
                      background: Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: const Text(
                          "Search",
                          style: TextStyle(
                            fontSize: Sizes.size32,
                            fontWeight: FontWeight.w800,
                          ),
                        ), // 상단에만 고정될 텍스트
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: _SliverSearchBarDelegate(
                      textEditingController: _textEditingController,
                      onSearchChanged: _onSearchChanged,
                      onSearchSubmitted: _onSearchSubmitted,
                    ),
                    // pinned: true, // CupertinoSearchTextField 고정
                    floating: true,
                  ),

                  SliverList.separated(
                    itemCount: users.length,
                    itemBuilder: (context, index) => UserTile(
                      userName: users[index].name,
                      bio: users[index].email,
                      userImg: "",
                      authorized: users[index].authorized,
                      followers: users[index].followers,
                    ),
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 0.5,
                    ),
                  ),

                  // MakeList(scrollController: _scrollController, posts: posts)
                ],
              ),
            ),
          ),
        );
  }
}

class _SliverSearchBarDelegate extends SliverPersistentHeaderDelegate {
  final TextEditingController _textEditingController;
  final Function _onSearchChanged;
  final Function _onSearchSubmitted;

  _SliverSearchBarDelegate({
    required TextEditingController textEditingController,
    required Function onSearchChanged,
    required Function onSearchSubmitted,
  })  : _textEditingController = textEditingController,
        _onSearchChanged = onSearchChanged,
        _onSearchSubmitted = onSearchSubmitted;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final isDark = isDarkMode(context);
    return Container(
      padding: const EdgeInsets.all(15),
      color: isDark ? Colors.black : Colors.white,
      alignment: Alignment.center,
      child: CupertinoSearchTextField(
        placeholder: "Search Email",
        controller: _textEditingController,
        onChanged: (value) => _onSearchChanged(value),
        onSubmitted: (value) => _onSearchSubmitted(value),
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
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
