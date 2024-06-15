class ActivityModel {
  String userName;
  String userImg;
  int time;
  String actionType;
  String? actionDescription;
  bool? followButton;

  ActivityModel({
    required this.userName,
    required this.userImg,
    required this.time,
    required this.actionType,
    this.actionDescription,
    this.followButton,
  });
}
