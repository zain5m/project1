import 'package:project1/models/comment_model.dart';
import 'package:project1/models/post_model.dart';

class ShowPostModel {
  PostModel? post;
  List<CommentModel>? comments = [];
  List<CommentModel>? re = [];
  ShowPostModel({
    this.post,
    this.comments,
  });
  ShowPostModel.fromJson(Map<String, dynamic> json) {
    post = PostModel.fromJson(json);
    if (json['comments'].isNotEmpty) {
      comments = [];
      re = [];
      json['comments'].forEach((v) {
        re!.add(CommentModel.fromJson(v['Comment']));
      });
      // comments = [];
      // json['comments'].forEach((v) {
      //   comments!.add(CommentModel.fromJson(v['Comment']));
      // });
    }
    comments = List.from(re!.reversed);
  }
}
