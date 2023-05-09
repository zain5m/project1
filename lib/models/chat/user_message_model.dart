import 'package:cloud_firestore/cloud_firestore.dart';

class UserMessageModel {
  int? userId;
  String? userName;
  String? userPhoto;
  bool? isOnline;
  // !
  LastMessageModel? lastMessageModel;

  UserMessageModel({
    this.userId,
    this.userName,
    this.userPhoto,
    this.isOnline,
    this.lastMessageModel,
  });

  UserMessageModel.fromJson(
    Map<String, dynamic> jsonUserInfo,
    Map<String, dynamic> jsonLastMessage,
    // String receiver,
    // int messagesNotRead,
  ) {
    userId = jsonUserInfo['userId'];
    userName = jsonUserInfo['userName'];
    userPhoto = jsonUserInfo['userPhoto'];
    isOnline = jsonUserInfo['isOnline'];

    lastMessageModel = LastMessageModel.fromJson(jsonLastMessage);
  }
  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "userName": userName,
      "userPhoto": userPhoto,
      "online": isOnline,
    };
  }
}

class LastMessageModel {
  DateTime? dateTimeLastMessage;
  String? lastMessage;
  // !
  Timestamp? timetoJson;

  LastMessageModel({
    this.dateTimeLastMessage,
    this.lastMessage,
    this.timetoJson,
  });

  LastMessageModel.fromJson(Map<String, dynamic> json) {
    dateTimeLastMessage =
        DateTime.parse(json["dateTimeLastMessage"].toDate().toString());
    // var myDateTime = DateFormat. .format(timeStampDate);

    lastMessage = json['lastMessage'];
  }
  Map<String, dynamic> toMap() {
    return {
      "dateTimeLastMessage": timetoJson,
      "lastMessage": lastMessage,
    };
  }
}
