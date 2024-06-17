class UserModel {
  String? displayName;
  String userName;
  String bio;
  String? userImg;
  bool authorized;
  int followers;

  UserModel({
    this.displayName,
    required this.userName,
    required this.bio,
    this.userImg,
    required this.authorized,
    required this.followers,
  });
}
