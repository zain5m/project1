import 'package:project1/models/post_model.dart';
import 'package:project1/models/story/story_model.dart';
import 'package:project1/models/user_data_model.dart';

class ProfileModel {
  MyInfoProfileModel? myInfo;
  List<PostModel>? posts = [];
  List<PostModel>? postsPrometed = [];

  ProfileModel({this.myInfo, this.posts});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    myInfo = json['My Info'] != null
        ? MyInfoProfileModel.fromJson(json['My Info'])
        : null;
    posts = [];
    postsPrometed = [];
    if (json['My Posts']['original']['Post'].isNotEmpty) {
      json['My Posts']['original']['Post'].forEach((v) {
        // // if (v['is_prometed'] == "0") {
        posts!.add(PostModel.fromJson(v));
        // } else {
        // postsPrometed!.add(PostModel.fromJson(v));
        // }
        // ['is_prometed']1 ? 0
        // posts!.add(PostModel.fromJson(v));
      });
    }
  }
}

class MyInfoProfileModel {
  UserDataModel? personal;
  List<int>? interest = [];
  int? followers;
  int? following;
  List<Story>? stores;
  String? state;
  MyInfoProfileModel(
      {this.personal, this.followers, this.following, this.stores});

  MyInfoProfileModel.fromJson(Map<String, dynamic> json) {
    personal = json['Personal'] != null
        ? UserDataModel.fromJson(json['Personal'])
        : null;
    if (json['Interest'] != null) {
      interest = [];
      json['Interest'].forEach((v) {
        interest!.add(v['interest_id']);
      });
    }

    followers = json['Followers'];
    following = json['Following'];
    if (json['Stores'].isNotEmpty) {
      stores = [];
      json['Stores'].forEach((v) {
        stores!.add(Story.fromJson(v));
      });
    }
    state = json['State'];
  }
}
