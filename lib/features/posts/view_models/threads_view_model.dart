import 'dart:async';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/features/posts/models/post_model.dart';

List<String> images = [
  "https://i.namu.wiki/i/ieNO5Cow2iXxPzlKaW1DgzQ1WXsJCFtoz6axDlWH39NYFPwY78M8vsEqZUpSfglnE4ssQu_obfSisbMsjjahsw.webp",
  "https://i.namu.wiki/i/tmMDx5L1w6-c0I7nMCRj8QMMDtQaNERYKQTEnALw9tHf9scNsiP-gjIP7wpsx-XXDhuB6ZTqukf1aDYS8CtgsA.webp",
  "https://cdn.royalcanin-weshare-online.io/qFbm9noBBKJuub5qj7rJ/v3/bp-lot-2-norwegian-forest-cat-bw-1",
  "https://images.mypetlife.co.kr/content/uploads/2022/12/06170446/AdobeStock_253949356-1024x684.jpeg",
  "https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTdfMTI3/MDAxNjgxNzI0NTk4Nzg1.UavCqi_x6mOjniIYXbXobmK2xWKwhy8gGAfY8xWY57wg.6mZPFDISLsqgL15c9f2uZ_XD761uz_zOqjRsu2V4vqkg.JPEG.ftv77/%EB%9E%99%EB%8F%8C%EA%B3%A0%EC%96%91%EC%9D%B410.jpg?type=w800",
  "https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTdfMjM0/MDAxNjgxNzI0NjE1Mzk5.B8r3DtHe7F1LCRe6cz40hOqD6qQoXiU0Dflms_kbi00g.RdgMcs2iEU1Uw3sMvxIapBCbe9EtWqNx0MXP3N6mf1wg.JPEG.ftv77/%EB%9E%99%EB%8F%8C%EA%B3%A0%EC%96%91%EC%9D%B414.jpg?type=w800",
  "https://mblogthumb-phinf.pstatic.net/MjAyMjA5MjNfMjcx/MDAxNjYzOTEzMjI2MjEw.FBd103pylVi-nZy3nWW9iLXgMhWp8TLj_TF6FwNUVO0g.lArVFBKhdY0T4_PD1WTjH47UFK5KdCZhu0XZ9zLBIZcg.JPEG.vavidolls/DSC06687.JPG?type=w800",
];

List<T> getRandomElements<T>(List<T> list, int min, int max) {
  Random random = Random();
  int numberOfElements = random.nextInt(max - min + 1) + min;
  List<T> result = [];

  List<int> selectedIndices = [];

  while (selectedIndices.length < numberOfElements) {
    int randomIndex = random.nextInt(list.length);
    if (!selectedIndices.contains(randomIndex)) {
      selectedIndices.add(randomIndex);
      result.add(list[randomIndex]);
    }
  }

  return result;
}

class ThreadsViewModel extends AsyncNotifier<List<PostModel>> {
  List<PostModel> _list = [];

  void addFaker() async {
    state = const AsyncValue.loading();
    // await Future.delayed(const Duration(seconds: 1));
    List<String> randomImgs = getRandomElements(images, 0, 2);

    final faker = Faker();
    final newPost = PostModel(
      userName: faker.person.name(),
      content: faker.lorem.sentence(),
      imgs: randomImgs,
      id: faker.randomGenerator
          .fromCharSet("ABCDEFGHIJKLMONPQESTUVWXYZ!?@#%", 16),
      userId: faker.randomGenerator
          .fromCharSet("ABCDEFGHIJKLMONPQESTUVWXYZ!?@#%", 16),
      createdAt: faker.date.dateTime().millisecondsSinceEpoch,
    );
    _list = [..._list, newPost];
    state = AsyncValue.data(_list);
  }

  @override
  FutureOr<List<PostModel>> build() async {
    await Future.delayed(const Duration(seconds: 1));
    for (var i = 0; i < 10; i++) {
      ref.read(threadsProvider.notifier).addFaker();
    }

    return _list;
  }
}

final threadsProvider =
    AsyncNotifierProvider<ThreadsViewModel, List<PostModel>>(
  () => ThreadsViewModel(),
);
