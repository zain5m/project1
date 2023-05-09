import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  int? senderId;
  int? receiverId;
  String? dateTime;
  String? text;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.text,
  });

  MessageModel.fromJson(dynamic json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json["dateTime"];
    text = json['text'];
  }
  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "dateTime": dateTime,
      "text": text,
    };
  }
}
