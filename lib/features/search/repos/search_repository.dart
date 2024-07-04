import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> searchUsers({
    required String email,
  }) async {
    print(email);
    final users = await _db
        .collection("users")
        .where("email", isGreaterThanOrEqualTo: email)
        .where("email", isLessThanOrEqualTo: "$email~")
        .get();
    print(users);
    return users;
    // return _db.collection("videos").where("likes", isGreaterThan: 10).get();
  }
}

final searchRepo = Provider(
  (ref) => SearchRepository(),
);
