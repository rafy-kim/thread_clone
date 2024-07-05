import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/features/search/repos/search_repository.dart';
import 'package:thread_clone/features/users/models/user_profile_model.dart';

class SearchViewModels extends AsyncNotifier<List<UserProfileModel>> {
  late final SearchRepository _repository;
  List<UserProfileModel> _list = [];

  Future<List<UserProfileModel>> _searchUsers({String? email}) async {
    final result = await _repository.searchUsers(email: email ?? "");
    final users = result.docs.map(
      (doc) => UserProfileModel.fromJson(
        doc.data(),
      ),
    );
    return users.toList();
  }

  Future<void> updateSearchUsers(String email) async {
    final result = await _searchUsers(email: email);
    state = AsyncValue.data(result);
  }

  @override
  FutureOr<List<UserProfileModel>> build() async {
    _repository = ref.read(searchRepo);
    _list = await _searchUsers();
    return _list;
  }
}

final searchProvider =
    AsyncNotifierProvider<SearchViewModels, List<UserProfileModel>>(
  () => SearchViewModels(),
);
