import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project1/models/error_model%20.dart';
import 'package:project1/models/follow_model.dart';
import 'package:project1/models/profile_model.dart';
import 'package:project1/shared/components/constants.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/network/remote/dio_helper.dart';
import 'package:project1/shared/network/remote/end_points.dart';

part 'my_profile_layout_state.dart';

class MyProfileLayoutCubit extends Cubit<MyProfileLayoutStates> {
  MyProfileLayoutCubit() : super(MyProfileLayoutInitialStates());

  static MyProfileLayoutCubit get(context) => BlocProvider.of(context);
  var token = CacheHelper.getData(key: TOKEN);
  int currentTabIndex = 0;
  void changeTabIndex(int index) {
    currentTabIndex = index;
    emit(MyProfileLayoutChangeTabIndexStates());
  }

  int currentMenuIndex = 2;
  void changeMenuIndex(int index) {
    currentMenuIndex = index;
    emit(MyProfileLayoutChangeMenuIndexStates());
  }

  IconData suffix = Icons.visibility_outlined;

  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  ProfileModel? myProfileData;
  // ProfileModel? profileData;
  void getDataProfile({
    int? userId,
  }) {
    emit(MyProfileLayoutGetDataProfileLoadingStates());
    DioHelper.getData(
      url: userId != null
          ? "$MYPROFILE/$userId"
          : "$MYPROFILE/${CacheHelper.getData(key: USERID)}",
      token: token,
    ).then((response) {
      if (response.statusCode == 200) {
        myProfileData = ProfileModel.fromJson(response.data);
        emit(MyProfileLayoutGetDataProfileSucssesStates());
      } else if (response.statusCode! >= 500) {
        emit(MyProfileLayoutGetDataProfileErrorStates("Error on server"));
      } else {
        emit(MyProfileLayoutGetDataProfileErrorStates(
            ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      print(error);
    });
  }

// ! LOGOUT
  void logout() {
    // final token = CacheHelper.getData(key: TOKEN);
    emit(MyProfileLogoutLoadingStates());
    DioHelper.postData(
      url: LOGOUT,
      token: token,
    ).then((response) {
      if (response.statusCode == 200) {
        CacheHelper.removeData(key: TOKEN).then((value) {
          CacheHelper.removeData(key: USERID).then((value) {
            emit(MyProfileLogoutSucssesStates());
          }).catchError((e) {});
        }).catchError((e) {});
      } else if (response.statusCode! >= 500) {
        emit(MyProfileLogoutErrorStates("Error on server"));
      } else {
        emit(MyProfileLogoutErrorStates(
            ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((e) {});
  }

  List<FollowAndBlockModel>? blockingPeople = [];
// ! Blocking
  void blocking() {
    emit(MyProfileBlockingLoadingStates());
    blockingPeople = [];
    DioHelper.getData(
      url: BLOCKING,
      token: token,
    ).then((response) {
      if (response.statusCode == 200) {
        response.data.forEach((data) {
          blockingPeople!.add(FollowAndBlockModel.fromJson(data));
        });
        emit(MyProfileBlockingSucssesStates());
      } else if (response.statusCode! >= 500) {
        emit(MyProfileBlockingErrorStates("Error on server"));
      } else {
        emit(MyProfileBlockingErrorStates(
            ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((e) {});
  }

// !!!unBLOCK
  void uNblockUser({
    required int? userId,
  }) {
    emit(MyProfileBlockUserLoadingStates());
    DioHelper.postData(
      url: "$BLOCK/$userId",
      token: token,
    ).then((response) {
      print(response.data);
      if (response.statusCode == 200) {
        blocking();
        emit(MyProfileBlockUserSucssesStates());
      } else if (response.statusCode! >= 500) {
        emit(MyProfileBlockUserErrorStates("Error on server"));
      } else {
        emit(MyProfileBlockUserErrorStates(
            ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((e) {});
  }

// !  EDit profile
  void editprofile({
    required String? name,
    required String? birthDay,
    required int? gender,
    required String? bio,
  }) {
    emit(MyProfileEditprofileLoadingStates());

    DioHelper.putData(
      url: UPDATEINFO,
      token: token,
      data: {
        "name": name,
        "birthday": birthDay,
        "gender": gender,
        "bio": bio,
      },
    ).then((response) {
      if (response.statusCode == 200) {
        getDataProfile();
        emit(MyProfileEditprofileSucssesStates());
      } else if (response.statusCode! >= 500) {
        emit(MyProfileEditprofileErrorStates("Error on server"));
      } else {
        emit(MyProfileEditprofileErrorStates(
            ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      emit(MyProfileEditprofileErrorStates("Error on server"));
    });
  }
// !  EDit PHOTO  profile

  void editPhotoProfile({
    required File? image,
  }) async {
    emit(MyProfileEditPhotoprofileLoadingStates());
    String fileName = image!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "photo": await MultipartFile.fromFile(image.path, filename: fileName),
    });
    final token = CacheHelper.getData(key: TOKEN);

    DioHelper.postData(
      url: UPDATEIMAGE,
      token: token,
      data: formData,
    ).then((response) {
      if (response.statusCode == 200) {
        getDataProfile();
        emit(MyProfileEditPhotoprofileSucssesStates());
      } else if (response.statusCode! >= 500) {
        emit(MyProfileEditPhotoprofileErrorStates("Error on server"));
      } else {
        emit(MyProfileEditPhotoprofileErrorStates(
            ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      print(error);
    });
  }

  void proomotion({
    required String code,
    required int namperOf,
  }) {
    emit(PromoLoadingStates());

    DioHelper.postData(
      url: "myprofile/promotion",
      token: token,
      data: {
        'code': code,
        "number_of_posts": namperOf,
      },
    ).then((response) {
      if (response.statusCode == 200) {
        emit(PromoSucssesStates(response.data.toString()));
      } else if (response.statusCode! >= 500) {
        emit(PromoErrorStates("Error on server"));
      } else {
        emit(PromoErrorStates(ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      print(error);
    });
  }

  void deletAcont({
    required String pass,
  }) {
    emit(PromoLoadingStates());

    DioHelper.deleteData(
      url: "myprofile/delete",
      token: token,
      data: {
        'password': pass,
      },
    ).then((response) {
      if (response.statusCode == 200) {
        emit(PromoSucssesStates(response.data.toString()));
      } else if (response.statusCode! >= 500) {
        emit(PromoErrorStates("Error on server"));
      } else {
        emit(PromoErrorStates(ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      print(error);
    });
  }
}
