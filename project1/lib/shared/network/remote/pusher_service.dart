// import 'dart:convert';

// import 'package:laravel_flutter_pusher/laravel_flutter_pusher.dart';
// import 'package:project1/models/home_post/home_post_model.dart';
// import 'package:project1/module/home_post/cubit/home_post_cubit.dart';

// class PusherService {
//   /// Init Pusher Listener
//   // static ;
//   static LaravelFlutterPusher initPusher(
//       String appKey, String host, int port, String cluster) {
//     LaravelFlutterPusher pusher = LaravelFlutterPusher(
//       appKey,
//       PusherOptions(
//         host: host,
//         port: port,
//         encrypted: true,
//         cluster: cluster,
//       ),
//       enableLogging: true,
//       onConnectionStateChange: (status) {
//         // print()
//       },
//     );
//     return pusher;
//   }

//   static void listen({
//     String? channel,
//     String? event,
//     LaravelFlutterPusher? pusher,
//     bool ispost = false,
//     HomePostCubit? cubit,
//   }) {
//     pusher!.subscribe(channel!).bind(event!, (event) {
//       if (ispost) {
//         event.addEntries({
//           "Post": {
//             "_id": event['post_id'],
//             "photo": event['photo'],
//             "user_id": event['user_id'],
//             "interest_id": event['interest_id'],
//             "updated_at": '',
//             "created_at": event['created_at'],
//             "content": event['content'],
//             "is_prometed": event['is_prometed'],
//             "upvotes_user_id": [],
//             "downvotes_user_id": [],
//             "User": {
//               'Name': event['user_name'],
//               'Photo': event['user_photo'],
//             },
//             "Comments_Number": {
//               "headers": {},
//               "original": 0,
//               "exception": null
//             },
//             "UpVotes_Number": 0,
//             "DownVotes_Number": 0,
//             "React": "No React"
//           }
//         }.entries);
//         // cubit!.data!.posts!.homeModel!.add(HomeModel.fromJson(event));
//         print(event["photo"]);
//       }
//     });
//   }
// }

// class ss {
//   String? photo;
//   int? userId;
//   String? createdAt;
//   List<String>? interestId;
//   String? content;
//   String? isPrometed;
//   String? userName;
//   String? userPhoto;

//   ss(
//       {this.photo,
//       this.userId,
//       this.createdAt,
//       this.interestId,
//       this.content,
//       this.isPrometed,
//       this.userName,
//       this.userPhoto});

//   ss.fromJson(Map<String, dynamic> json) {
//     photo = json['photo'];
//     userId = json['user_id'];
//     createdAt = json['created_at'];
//     interestId = json['interest_id'].cast<String>();
//     content = json['content'];
//     isPrometed = json['is_prometed'];
//     userName = json['user_name'];
//     userPhoto = json['user_photo'];
//   }
// }

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:laravel_flutter_pusher/laravel_flutter_pusher.dart';
import 'package:project1/module/home_post/cubit/home_post_cubit.dart';
import 'package:project1/module/show_post/cubit/show_post_cubit.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/network/remote/end_points.dart';

class PusherService {
  /// Init Pusher Listener

  LaravelFlutterPusher initPusher(
      String appKey, String host, int port, String cluster) {
    var token = CacheHelper.getData(key: TOKEN);

    return LaravelFlutterPusher(
      appKey,
      PusherOptions(
        host: host,
        port: port,
        encrypted: false,
        cluster: cluster,
        auth: PusherAuth(
          '$HOST/api/broadcasting/auth',
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': 'Bearer $token',
          },
        ),
      ),
      enableLogging: true,
      onConnectionStateChange: (status) {
        print(status.currentState);
      },
    );
  }

  void listen(
      LaravelFlutterPusher pusher, String channel, String event1, context) {
    switch (event1) {
      case "App\\Events\\CommentEvent":
        pusher.subscribe(channel).bind(event1, (event) {
          FormData formData = FormData.fromMap({
            "user_id": event['user_id'],
            "user_name": event['user_name'],
            "user_photo": event['user_photo'],
            "id": event['id'],
            "content": event['content'],
            "created_at": event['created_at'],
          });

          ShowPostCubit.get(context).addComment(
            name: event['user_name'],
            photo: event['user_photo'],
            userId: event['user_id'],
            commentId: event['id'],
            content: event['content'],
            createdAt: event['created_at'],
          );
        });

        break;
      case "App\\Events\\PostEvent":
        pusher.subscribe(channel).bind(event1, (event) {
          //   FormData formData = FormData.fromMap({
          //     "user_id": event['user_id'],
          //     "user_name": event['user_name'],
          //     "user_photo": event['user_photo'],
          //     "post_id": event['post_id'],
          //     "photo": event['photo'],
          //     "created_at": event['created_at'],
          //     "interest_id": event['interest_id'],
          //     "content": event['content'],
          //     "is_prometed": event['is_prometed'],
          //   });
          List<dynamic>? interestId = [];
          List<String>? interestIdString = event['interest_id'].cast<String>();
          interestIdString!.forEach((element) {
            interestId.add(int.parse(element) - 1);
          });
          print(event['user_photo'] == "null");
          // HomePostCubit.get(context).addPost(
          //   userName: event['user_name'],
          //   userPhoto: event['user_photo'],
          //   userId: event['user_id'],
          //   interestId: interestId,
          //   // isPrometed: event['is_prometed'],
          //   content: event['content'],
          //   photo: event['photo'],
          //   postId: event['post_id'],
          // );
        });

        break;
      // default:
    }
  }
}
