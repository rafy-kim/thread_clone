class PostModel {
  String userName;
  String? userImg;
  String content;
  List<String>? imgs;

  PostModel({
    required this.userName,
    this.userImg,
    required this.content,
    this.imgs,
  });
}
