import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/features/posts/models/post_model.dart';

class PostRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // upload a image file
  UploadTask uploadImageFile(File image, String uid) {
    final fileRef = _storage.ref().child(
          "/images/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}",
        );
    return fileRef.putFile(image);
  }

  // create a post document
  Future<DocumentReference<Map<String, dynamic>>> savePost(
      PostModel data) async {
    return await _db.collection("posts").add(data.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchPosts({
    int? lastItemCreatedAt,
  }) {
    final query =
        _db.collection("posts").orderBy("createdAt", descending: true).limit(3);
    if (lastItemCreatedAt == null) {
      return query.get();
    } else {
      print(lastItemCreatedAt);
      return query.startAfter([lastItemCreatedAt]).get();
    }
  }

  // Future<void> likeVideo(String videoId, String userId) async {
  //   final query = _db.collection("likes").doc("${videoId}000$userId");
  //   final like = await query.get();
  //   if (!like.exists) {
  //     await query.set(
  //       {
  //         "createdAt": DateTime.now().millisecondsSinceEpoch,
  //       },
  //     );
  //   } else {
  //     await query.delete();
  //   }
  // }
}

final postRepo = Provider(
  (ref) => PostRepository(),
);
