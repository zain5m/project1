import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project1/models/error_model%20.dart';
import 'package:project1/models/follow_model.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/network/remote/dio_helper.dart';
import 'package:project1/shared/network/remote/end_points.dart';

part 'follow_state.dart';

class FollowCubit extends Cubit<FollowStates> {
  FollowCubit() : super(FollowInitialState());

  static FollowCubit get(context) => BlocProvider.of(context);
  var token = CacheHelper.getData(key: TOKEN);
  List<FollowAndBlockModel>? followers = [];
  void getFollowers({
    int? userId,
  }) {
    emit(FollowGetFollowersLoadingStates());
    followers = [];
    DioHelper.getData(
      url: "$FOLLOWERS/$userId",
      token: token,
    ).then((response) {
      if (response.statusCode == 200) {
        if (response.data.first != null) {
          response.data.forEach((data) {
            followers!.add(FollowAndBlockModel.fromJson(data));
          });
        }

        emit(FollowGetFollowersSucssesStates());
      } else if (response.statusCode! >= 500) {
        emit(FollowGetFollowersErrorStates("Error on server"));
      } else {
        emit(FollowGetFollowersErrorStates(
            ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      print(error);
    });
  }

  List<FollowAndBlockModel>? following = [];
  void getFollowing({
    int? userId,
  }) {
    emit(FollowGetFollowingLoadingStates());
    followers = [];
    DioHelper.getData(
      url: "$FOLLOWING/$userId",
      token: token,
    ).then((response) {
      if (response.statusCode == 200) {
        if (response.data.first != null) {
          response.data.forEach((data) {
            following!.add(FollowAndBlockModel.fromJson(data));
          });
        }

        emit(FollowGetFollowingSucssesStates());
      } else if (response.statusCode! >= 500) {
        emit(FollowGetFollowingErrorStates("Error on server"));
      } else {
        emit(FollowGetFollowingErrorStates(
            ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      print(error);
    });
  }
}
