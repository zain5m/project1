import 'package:project1/models/comment_model.dart';
import 'package:project1/models/post_model.dart';

class ExploreModel {
  PostModel? post;
  List<CommentModel>? comments = [];
  ExploreModel({
    this.post,
    this.comments,
  });
  ExploreModel.fromJson(Map<String, dynamic> json) {
    post = PostModel.fromJson(json);
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments!.add(CommentModel.fromJson(v));
      });
    }
    // if (json['comments'] != null) {
    //   comments = [];
    //
    //   json['comments'].forEach((v) {
    //     Comment? comment;
    //     comment = v['Comment'] != null ? Comment.fromJson(v['Comment']) : null;
    //     comments!.add(comment!);
    //   });
    // }
  }
}
