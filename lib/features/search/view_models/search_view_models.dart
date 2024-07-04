import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/features/search/repos/search_repository.dart';
import 'package:thread_clone/features/users/models/user_profile_model.dart';

class SearchViewModels
    extends FamilyAsyncNotifier<List<UserProfileModel>, String> {
  late final SearchRepository _repository;
  List<UserProfileModel> _list = [];

  Future<List<UserProfileModel>> _searchUsers(String email) async {
    final result = await _repository.searchUsers(email: email);
    final users = result.docs.map(
      (doc) => UserProfileModel.fromJson(
        doc.data(),
      ),
    );
    return users.toList();
  }

  @override
  FutureOr<List<UserProfileModel>> build(String email) async {
    _repository = ref.read(searchRepo);
    _list = await _searchUsers(email);
    return _list;
  }
}

final searchProvider = AsyncNotifierProvider.family<SearchViewModels,
    List<UserProfileModel>, String>(
  () => SearchViewModels(),
);
