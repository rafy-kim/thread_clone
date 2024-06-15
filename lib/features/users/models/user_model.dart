class UserModel {
  String userName;
  String bio;
  String? userImg;
  bool authorized;
  int followers;

  UserModel({
    required this.userName,
    required this.bio,
    this.userImg,
    required this.authorized,
    required this.followers,
  });
}
