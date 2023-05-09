class UserDataModel {
  UserDataModel({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.photo,
    this.bio,
    this.gender,
    this.birthday,
    this.code,
    this.isPromtion,
    this.numberOfPosts,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? bio;
  String? photo;
  int? gender;
  DateTime? birthday;

  String? code;
  int? isPromtion;
  int? numberOfPosts;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    photo = json['photo'];
    bio = json['bio'];
    gender = json['gender'];
    String birthdayString = json["birthday"];
    birthday = DateTime.parse(birthdayString);

    code = json['code'];
    isPromtion = json['is_promtion'];
    numberOfPosts = json['number_of_posts'];
    updatedAt = DateTime.parse(json["updated_at"]);
    createdAt = DateTime.parse(json["created_at"]);
  }
}
