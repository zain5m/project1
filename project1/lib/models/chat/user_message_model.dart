class UserMessageModel {
  int? userId;
  String? userName;
  String? userPhoto;
  String? dateTimeLastMessage;
  String? lastMessage;

  UserMessageModel({
    this.userId,
    this.userName,
    this.userPhoto,
    this.dateTimeLastMessage,
    this.lastMessage,
  });

  UserMessageModel.fromJson(Map<String, dynamic>? json) {
    userId = json!['userId'];
    userName = json['userName'];
    userPhoto = json['userPhoto'];
    dateTimeLastMessage = json["dateTimeLastMessage"].toString();
    // DateTime.parse(json["dateTimeLastMessage"].toString());
    // dateTimeLastMessage = json['dateTimeLastMessage'];
    lastMessage = json['lastMessage'];
  }
  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "userName": userName,
      "userPhoto": userPhoto,
      "dateTimeLastMessage": dateTimeLastMessage,
      "lastMessage": lastMessage,
    };
  }
}
