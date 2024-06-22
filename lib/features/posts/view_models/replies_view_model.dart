import 'dart:async';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/features/posts/models/post_model.dart';

List<String> images = [
  "https://mblogthumb-phinf.pstatic.net/MjAyMDA4MjFfNTcg/MDAxNTk3OTg0MTMyNjQw.wmPK-tavZSE9XS0EDp4KhoKPSTDrvqQjfqZV80oXzrkg.Y27ffGjvzhAaIImJWbCeBrUmJ8mScapI8DJzejuPmuAg.JPEG.dlwnsgur34/1.jpg?type=w800",
  "https://scontent-ssn1-1.xx.fbcdn.net/v/t39.30808-6/367382324_253773570935086_7471929128764276817_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=5f2048&_nc_ohc=i76-fZEg-pQQ7kNvgHHuMlJ&_nc_ht=scontent-ssn1-1.xx&oh=00_AYDa74N7o7oSZtdxeJRfD4MFMUtEwj7QGhG1mLkFHNRFWg&oe=6675E4D9",
  "https://mblogthumb-phinf.pstatic.net/MjAyMDA3MjNfNjkg/MDAxNTk1NTAxMzU3OTU0.c3cNYzSUnzwwFof34Ljr958vYCcDUZUTAju5AcPHncMg.GBkzSNM1CUEEtSP4RWJIxQ27_Qpx3eDyhS1zNwD1_VIg.JPEG.hyousang/2.jpg?type=w800",
  "https://i.namu.wiki/i/u6RY6Cwfgl5LU3zbiqxbOzmRfe2IEeICXexXNykfzxwnhMwIvV8KddLNkUxyNyDQzBwtvD9swGszVOXM_A0UFw.webp",
  "https://flexible.img.hani.co.kr/flexible/normal/960/960/imgdb/resize/2019/0121/00501111_20190121.JPG",
  "https://mblogthumb-phinf.pstatic.net/MjAyMjA4MjRfMTgy/MDAxNjYxMzIwNjIzODk5.OWc2z-YXeLFvyvYahPkySEAO2L4HtljLNqmL1y1D5l0g.jE14uKWjrHUYRNX7VfU95-PxStNktetch_hngxM3Q-Eg.JPEG.ages9090/KakaoTalk_20220824_140238973_17.jpg?type=w800",
  "https://images.mypetlife.co.kr/content/uploads/2023/02/03094318/AdobeStock_366413112-scaled.jpeg",
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

class RepliesViewModel extends AsyncNotifier<List<PostModel>> {
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
    );
    _list = [..._list, newPost];
    state = AsyncValue.data(_list);
  }

  @override
  FutureOr<List<PostModel>> build() async {
    await Future.delayed(const Duration(seconds: 1));
    for (var i = 0; i < 10; i++) {
      ref.read(repliesProvider.notifier).addFaker();
    }

    return _list;
  }
}

final repliesProvider =
    AsyncNotifierProvider<RepliesViewModel, List<PostModel>>(
  () => RepliesViewModel(),
);
