import 'package:project1/models/user_data_model.dart';

class RegisterModel {
  UserDataModel1? user;
  String? token;
  RegisterModel({
    this.token,
    this.user,
  });
  RegisterModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserDataModel1.fromJson(json['user']) : null;
    token = json["token"];
  }
}

class UserDataModel1 {
  UserDataModel1({
    this.id,
  });

  int? id;

  UserDataModel1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }
}

// class UserData {
//   int? id;
//   String? name;
//   String? email;
//   String? emailVerifiedAt;
//   String? photo;
//   int? gender;
//   String? birthday;
//   String? code;
//   int? isPromtion;
//   int? numberOfPosts;
//   String? createdAt;
//   String? updatedAt;

//   UserData(
//       {this.id,
//       this.name,
//       this.email,
//       this.emailVerifiedAt,
//       this.photo,
//       this.gender,
//       this.birthday,
//       this.code,
//       this.isPromtion,
//       this.numberOfPosts,
//       this.createdAt,
//       this.updatedAt});

//   UserData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     emailVerifiedAt = json['email_verified_at'];
//     photo = json['photo'];
//     gender = json['gender'];
//     birthday = json['birthday'];
//     code = json['code'];
//     isPromtion = json['is_promtion'];
//     numberOfPosts = json['number_of_posts'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['photo'] = this.photo;
//     data['gender'] = this.gender;
//     data['birthday'] = this.birthday;
//     data['code'] = this.code;
//     data['is_promtion'] = this.isPromtion;
//     data['number_of_posts'] = this.numberOfPosts;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
