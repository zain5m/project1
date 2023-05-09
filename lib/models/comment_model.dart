import 'package:project1/models/user_model.dart';

class CommentModel {
  int? commentId;
  String? content;
  int? userId;
  String? createdAt;
  UserModel? user;

  CommentModel(
      {this.commentId, this.content, this.userId, this.createdAt, this.user});

  CommentModel.fromJson(Map<String, dynamic> json) {
    commentId = json['id'];
    content = json['content'];
    userId = json['user_id'];
    createdAt = json['created_at'];

    user = json['User'] != null ? UserModel.fromJson(json['User']) : null;
  }
}
