class PostModel {
  String id;
  String userName;
  String? userImg;
  String userId;
  String content;
  List<String>? imgs;
  int createdAt;

  PostModel({
    required this.id,
    required this.userName,
    this.userImg,
    required this.userId,
    required this.content,
    required this.createdAt,
    this.imgs,
  });

  PostModel.fromJson(Map<String, dynamic> json)
      : userName = json["userName"],
        userImg = json["userImg"],
        content = json["content"],
        userId = json["userId"],
        createdAt = json["createdAt"],
        id = json["id"],
        imgs = (json['imgs'] as List<dynamic>).map((e) => e as String).toList();

  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "userImg": userImg,
      "content": content,
      "userId": userId,
      "createdAt": createdAt,
      "id": id,
      "imgs": imgs,
    };
  }
}
