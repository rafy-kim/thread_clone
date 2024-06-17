import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_time/features/users/models/user_model.dart';

class UserViewModels extends AsyncNotifier<UserModel> {
  @override
  FutureOr<UserModel> build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}

final userProvider = AsyncNotifierProvider<UserViewModels, UserModel>(
  () => UserViewModels(),
);
