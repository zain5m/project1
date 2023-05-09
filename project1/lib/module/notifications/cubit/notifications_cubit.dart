import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project1/models/Notifications/notifications_model.dart';
import 'package:project1/models/error_model%20.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/network/remote/dio_helper.dart';
import 'package:project1/shared/network/remote/end_points.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsStates> {
  NotificationsCubit() : super(NotificationsInitialState());
  static NotificationsCubit get(context) => BlocProvider.of(context);
  NotificationsModel? notifications;
  var token = CacheHelper.getData(key: TOKEN);
  void getNotifications() {
    emit(NotificationsGetLoadingState());
    DioHelper.getData(
      url: NOTIFICATIONS,
      token: token,
    ).then((response) {
      if (response.statusCode == 200) {
        notifications = NotificationsModel.fromJson(response.data);
        emit(NotificationsGetSucssesState());
      } else if (response.statusCode! >= 500) {
        emit(NotificationsGetErorrState("Error on server"));
      } else {
        emit(NotificationsGetErorrState(
            ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      print(error);
    });
  }

  void markAsRead() {
    emit(NotificationsGetLoadingState());
    DioHelper.getData(
      url: MAEKASREAD,
      token: token,
    ).then((response) {
      if (response.statusCode == 200) {
        getNotifications();
        emit(NotificationsGetSucssesState());
      } else if (response.statusCode! >= 500) {
        emit(NotificationsGetErorrState("Error on server"));
      } else {
        emit(NotificationsGetErorrState(
            ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      print(error);
    });
  }

  void notificationsRead({
    required String? idNot,
    required String? type,
    required int? userId,
    required String? postId,
  }) {
    emit(NotificationsReadLoadingState());
    FormData? formData;
    switch (type) {
      case "App\\Notifications\\FollowNotification":
        formData = FormData.fromMap({
          "user": null,
          "user_id": userId,
        });
        break;
      default:
        formData = FormData.fromMap({
          "post": null,
          "post_id": postId,
        });
    }
    DioHelper.postData(
      url: "$NOTIFICATIONS/$idNot",
      token: token,
      data: formData,
    ).then((response) {
      if (response.statusCode == 200) {
        // getNotifications();
        emit(NotificationsReadSucssesState());
      } else if (response.statusCode! >= 500) {
        emit(NotificationsReadErorrState("Error on server"));
      } else {
        emit(NotificationsReadErorrState(
            ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      print(error);
    });
  }

  void addPost({
    required String? userName,
    required String? userPhoto,
    required int? userId,
    required String? postId,
    required String? content,
    required String? photo,
    required String? isPrometed,
    required DateTime? createdAt,
    required List<dynamic>? interestId,
  }) {
    // NotificationsModel;
    // data!.posts!.homeModel!.add(post);
    // int index = data!.comments!.length;
    // List<HomeModel> myList = [comentREal, ...data!.comments!];
    // data!.comments = myList;
    // emit(AddPostState());
  }
}
