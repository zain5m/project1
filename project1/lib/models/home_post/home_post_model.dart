import 'package:project1/models/comment_model.dart';
import 'package:project1/models/post_model.dart';
import 'package:project1/models/story/story_model.dart';

class HomePostModel {
  int? restNumberOfPost;
  Posts? posts;
  List<UserStoryModel>? stories = [];

  HomePostModel({this.restNumberOfPost, this.posts, this.stories});

  HomePostModel.fromJson(Map<String, dynamic> json) {
    stories = [];
    restNumberOfPost = json['Rest_Number_of_post'];
    posts = json['Posts'] != null ? Posts.fromJson(json['Posts']) : null;

    json['Stories'].forEach((element) {
      if (element != null) {
        if (element['User']['Story'].isNotEmpty) {
          stories!.add(UserStoryModel.fromJson(element['User']));
        }
      }
    });
  }
}

class UserStoryModel {
  String? name;
  String? photo;
  List<Story>? story;

  UserStoryModel({this.name, this.photo, this.story});

  UserStoryModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    photo = json['Photo'];
    story = [];
    json['Story'].forEach((v) {
      story!.add(Story.fromJson(v));
    });
  }
}

// !!!!!!!!!!!!!!!!!!!!!!!
class Posts {
  List<InterestModel>? interest = [];
  List<FollowingModel>? following = [];
  List<HomeModel>? homeModel = [];

  Posts({this.interest, this.following});

  Posts.fromJson(Map<String, dynamic> json) {
    if (json['Interest'] != null) {
      interest = [];
      json['Interest'].forEach((v) {
        if (v != null) {
          interest!.add(InterestModel.fromJson(v));
        }
      });
    }
    if (json['Following'] != null) {
      following = [];

      if (json['Following'].first != null) {
        json['Following'].forEach((v) {
          if (v != null) {
            v['User']["Post"]['original']['Post'].forEach((v1) {
              v1.addEntries(
                {
                  "User": {
                    'Name': v['User']['Name'],
                    'Photo': v['User']['Photo'],
                  },
                }.entries,
              );
              following!.add(FollowingModel.fromJson(v1));
            });
          }
        });
      }
    }

    if (interest!.length > following!.length) {
      for (int i = 0; i < interest!.length; i++) {
        for (int j = 0; j < following!.length; j++) {
          if (interest![i].post!.postId == following![j].post!.postId) {
            following!.remove(following![i]);
          }
        }
      }
    } else {
      for (int i = 0; i < following!.length; i++) {
        for (int j = 0; j < interest!.length; j++) {
          if (following![i].post!.postId == interest![j].post!.postId) {
            interest!.remove(interest![i]);
          }
        }
      }
    }
    print(interest!.length + following!.length);
    int iff = 0;
    int iFollowing = 0;
    int iInterest = 0;
    for (int i = 0; i < (interest!.length + following!.length); i++) {
      if ((iff == 0 || iff == 1) && iInterest < interest!.length) {
        homeModel!.add(HomeModel(
          comments: interest![iInterest].comments,
          post: interest![iInterest].post,
        ));
        iff += 1;
        iInterest += 1;
      } else if (iff == 2 && iInterest < interest!.length) {
        homeModel!.add(HomeModel(
          comments: interest![iInterest].comments,
          post: interest![iInterest].post,
        ));
        iff += 1;
        iInterest += 1;
      } else if (iff == 3 && iFollowing < following!.length) {
        homeModel!.add(HomeModel(
          comments: following![iFollowing].comments,
          post: following![iFollowing].post,
        ));
        iff += 1;
        iFollowing += 1;
      } else if (iff == 4 && iFollowing < following!.length) {
        homeModel!.add(HomeModel(
          comments: following![iFollowing].comments,
          post: following![iFollowing].post,
        ));
        iFollowing += 1;
        iff = 0;
      } else if (iInterest < interest!.length) {
        homeModel!.add(HomeModel(
          comments: interest![iInterest].comments,
          post: interest![iInterest].post,
        ));
        iInterest += 1;
      } else if (iFollowing < following!.length) {
        homeModel!.add(HomeModel(
          comments: following![iFollowing].comments,
          post: following![iFollowing].post,
        ));
        iFollowing += 1;
      }
    }
  }
}

class HomeModel {
  PostModel? post;
  List<CommentModel>? comments = [];

  HomeModel({this.comments, this.post});
  HomeModel.fromJson(Map<String, dynamic> json) {
    post = json['Post'] != null ? PostModel.fromJson(json['Post']) : null;
  }
}

class InterestModel {
  PostModel? post;
  List<CommentModel>? comments = [];

  InterestModel({this.post, this.comments});

  InterestModel.fromJson(Map<String, dynamic> json) {
    post = json['Post'] != null ? PostModel.fromJson(json['Post']) : null;
    // if (json['comments'] != null) {
    //   comments = [];
    //   json['comments'].forEach((v) {
    //     comments!.add(Comment.fromJson(v));
    //   });
    // }
    // if (json['comments'] != null) {
    //   comments = [];
    //   json['comments'].forEach((v) {
    //     Comment? comment;
    //     comment = v['Comment'] != null ? Comment.fromJson(v['Comment']) : null;
    //     comments!.add(comment!);
    //   });
    //   print(comments!.length);
    // }
  }
}

class FollowingModel {
  PostModel? post;
  List<CommentModel>? comments = [];
  FollowingModel.fromJson(Map<String, dynamic> json) {
    post = PostModel.fromJson(json);
    // if (json['comments'] != null) {
    //   comments = [];
    //   json['comments'].forEach((v) {
    //     Comment? comment;
    //     comment = v['Comment'] != null ? Comment.fromJson(v['Comment']) : null;
    //     comments!.add(comment!);
    //   });
    //   print(comments!.length);
    // }
    // json['User']["Post"]['original']['Post'].forEach((v) {
    //   v.addEntries({
    //     'Name': json['User']['Name'],
    //     'Photo': json['User']['Photo'],
    //   }.entries);
    //   post!.add(PostModel.fromJson(v));
    // });
    // if (json['User']["Post"]['original']['Post']['comments'] != null) {
    //   comments = [];
    //   json['User']["Post"]['original']['Post']['comments'].forEach((v) {
    //     Comment? comment;
    //     comment = v['Comment'] != null ? Comment.fromJson(v['Comment']) : null;
    //     comments!.add(comment!);
    //   });
    // }
  }
}
