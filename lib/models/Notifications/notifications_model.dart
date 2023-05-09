class NotificationsModel {
  List<Notifications>? notifications;
  int? unRead;

  NotificationsModel({this.notifications, this.unRead});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    if (json['Notifications'] != null) {
      notifications = [];
      json['Notifications'].forEach((v) {
        notifications!.add(Notifications.fromJson(v));
      });
    }
    unRead = json['UnRead'];
  }
}

class Notifications {
  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  Data? data;
  String? readAt;
  DateTime? createdAt;
  String? updatedAt;

  Notifications(
      {this.id,
      this.type,
      this.notifiableType,
      this.notifiableId,
      this.data,
      this.readAt,
      this.createdAt,
      this.updatedAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    readAt = json['read_at'];
    createdAt = DateTime.parse(json['created_at'].toString());
    updatedAt = json['updated_at'];
  }
}

class Data {
  String? message;
  int? userId;
  String? userPhoto;
  String? postId;

  Data({this.message, this.userId, this.userPhoto, this.postId});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['user_id'];
    userPhoto = json['user_photo'];
    postId = json['post_id'];
  }
}
