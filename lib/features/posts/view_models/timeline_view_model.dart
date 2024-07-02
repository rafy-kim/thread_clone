import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/features/posts/models/post_model.dart';
import 'package:thread_clone/features/posts/repos/post_repository.dart';

class TimelineViewModel extends AsyncNotifier<List<PostModel>> {
  late final PostRepository _repository;
  List<PostModel> _list = [];

  Future<List<PostModel>> _fetchPosts({
    int? lastItemCreatedAt,
  }) async {
    final result = await _repository.fetchPosts(
      lastItemCreatedAt: lastItemCreatedAt,
    );
    final posts = result.docs.map(
      (doc) => PostModel.fromJson(
        doc.data(),
      ),
    );
    return posts.toList();
  }

  @override
  FutureOr<List<PostModel>> build() async {
    // await Future.delayed(const Duration(seconds: 1));
    _repository = ref.read(postRepo);
    _list = await _fetchPosts(lastItemCreatedAt: null);

    return _list;
  }

  Future<void> fetchNextPage() async {
    print("fetch next");
    final nextPage = await _fetchPosts(lastItemCreatedAt: _list.last.createdAt);
    _list = [..._list, ...nextPage];
    state = AsyncValue.data(_list);
  }

  Future<void> refresh() async {
    final posts = await _fetchPosts(lastItemCreatedAt: null);
    _list = posts;
    state = AsyncValue.data(posts);
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<PostModel>>(
  () => TimelineViewModel(),
);
