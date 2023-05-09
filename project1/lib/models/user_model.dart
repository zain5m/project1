class UserModel {
  String? name;
  String? photo;
  int? userId;

  UserModel({this.name, this.photo});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    photo = json['Photo'];
    dynamic id = json['id'];
    userId = id != null ? int.parse(id) : null;
  }
}
