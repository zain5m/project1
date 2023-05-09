const String Photo = "Photo";
const String Video = "Video";

class Story {
  int? id;
  String? photo;
  String? userName;
  String? userPhoto;
  String? dateType;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Story(
      {this.id,
      this.photo,
      this.userName,
      this.userPhoto,
      this.dateType,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Story.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    userName = json['user_name'];
    userPhoto = json['user_photo'];
    dateType = json['date_type'];
    userId = json['user_id'];
    createdAt = DateTime.parse(json["created_at"]);
    updatedAt = DateTime.parse(json["updated_at"]);
  }
}
