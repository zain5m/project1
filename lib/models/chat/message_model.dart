import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  int? senderId;
  int? receiverId;
  DateTime? dateTime;
  Timestamp? timetoJson;
  String? text;
  bool? isRead;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.text,
    this.isRead,
    this.timetoJson,
  });

  MessageModel.fromJson(dynamic json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = DateTime.parse(json["dateTime"]!.toDate().toString());
    text = json['text'];
    isRead = json["isRead"];
  }
  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "dateTime": timetoJson,
      "text": text,
      "isRead": isRead,
    };
  }
}
