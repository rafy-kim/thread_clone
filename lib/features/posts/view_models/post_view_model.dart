import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thread_clone/features/posts/models/post_model.dart';
import 'package:thread_clone/features/posts/repos/post_repository.dart';
import 'package:thread_clone/features/users/view_models/users_view_models.dart';

class PostViewModel extends AsyncNotifier<void> {
  late final PostRepository _postRepository;
  @override
  FutureOr<void> build() {
    _postRepository = ref.read(postRepo);
  }

  Future<void> savePost({
    List<File>? images,
    required post,
    required BuildContext context,
  }) async {
    // final user = ref.read(authRepo).user;
    final userProfile = ref.read(usersProvider).value;
    if (userProfile != null) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(
        () async {
          // img가 있을 경우 이미지 스토리지 저장
          List<String> imgUrls = images != null
              ? await Future.wait(
                  images.map((image) async {
                    final task = await _postRepository.uploadImageFile(
                        image, userProfile.uid);
                    final downloadUrl = await task.ref.getDownloadURL();
                    // print('Uploaded: $downloadUrl'); // 업로드된 URL을 출력하여 확인
                    return downloadUrl;
                  }).toList(),
                )
              : [];

          // 그 뒤 포스트 관련 정보 DB 저장
          final newPost = await _postRepository.savePost(
            PostModel(
              id: "",
              userName: userProfile.name,
              content: post,
              userImg: "",
              userId: userProfile.uid,
              imgs: imgUrls,
              createdAt: DateTime.now().millisecondsSinceEpoch,
            ),
          );

          context.pop();
        },
      );
      if (state.hasError) {
        print(state.error);
        // showFirebaseErrorSnack(context, state.error);
      }
    }
  }
}

final postProvider = AsyncNotifierProvider<PostViewModel, void>(
  () => PostViewModel(),
);
