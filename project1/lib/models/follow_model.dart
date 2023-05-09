class FollowAndBlockModel {
  int? userId;
  String? name;
  String? photo;

  FollowAndBlockModel({this.userId, this.name, this.photo});

  FollowAndBlockModel.fromJson(Map<String, dynamic> json) {
    dynamic id = json['id'];
    userId = int.parse(id);
    name = json['Name'];
    photo = json['Photo'];
  }
}

// class Following_BlockingModel {
//   int? userId;
//   String? name;
//   String? photo;

//   Following_BlockingModel({this.userId, this.name, this.photo});

//   Following_BlockingModel.fromJson(Map<String, dynamic> json) {
//     String id = json['id'];
//     userId = int.parse(id);
//     name = json['Name'];
//     photo = json['Photo'];
//   }
// }
