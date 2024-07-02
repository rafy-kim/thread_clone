import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/features/authentication/repos/authentication_repository.dart';
import 'package:thread_clone/features/posts/models/post_model.dart';
import 'package:thread_clone/features/posts/repos/post_repository.dart';

class ThreadsViewModel extends AsyncNotifier<List<PostModel>> {
  late final PostRepository _repository;
  List<PostModel> _list = [];

  Future<List<PostModel>> _fetchMyPosts({
    int? lastItemCreatedAt,
  }) async {
    final uid = ref.read(authRepo).user!.uid;
    final result = await _repository.fetchUserPosts(
      lastItemCreatedAt: lastItemCreatedAt,
      uid: uid,
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
    _list = await _fetchMyPosts(lastItemCreatedAt: null);
    return _list;
  }

  Future<void> fetchNextPage() async {
    print("fetch next");
    final nextPage =
        await _fetchMyPosts(lastItemCreatedAt: _list.last.createdAt);
    _list = [..._list, ...nextPage];
    state = AsyncValue.data(_list);
  }

  Future<void> refresh(String uid) async {
    final posts = await _fetchMyPosts(lastItemCreatedAt: null);
    _list = posts;
    state = AsyncValue.data(posts);
  }
}

final threadsProvider =
    AsyncNotifierProvider<ThreadsViewModel, List<PostModel>>(
  () => ThreadsViewModel(),
);
