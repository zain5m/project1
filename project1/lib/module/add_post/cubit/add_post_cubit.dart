import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:project1/models/error_model%20.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/network/remote/dio_helper.dart';
import 'package:project1/shared/network/remote/end_points.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostStates> {
  AddPostCubit() : super(AddPostInitialState());
  static AddPostCubit get(context) => BlocProvider.of(context);

  bool showInterste = false;
  IconData iconshowInterste = FluentIcons.arrow_circle_right_48_filled;

  void changeShowInterste() {
    showInterste = !showInterste;

    iconshowInterste = showInterste
        ? FluentIcons.arrow_circle_down_48_filled
        : FluentIcons.arrow_circle_right_48_filled;

    emit(AddPostChangeShowIntersteState());
  }

  List<int> selected = [];
  List<int> selectedForAPI = [];

  void changeInterstsSelected(int interestsid) {
    if (selected.contains(interestsid)) {
      selected.remove(interestsid);
      selectedForAPI.remove(interestsid + 1);
    } else {
      selected.add(interestsid);
      selectedForAPI.add(interestsid + 1);
    }
    emit(AddPostChangeInterstsSelectedState());
  }

  void creatPost({
    required File? image,
    required String? content,
    required List<int>? interestid,
  }) async {
    emit(AddPostCreatPostLoadingStates());
    String fileName = image!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "content": content,
      "photo": await MultipartFile.fromFile(image.path, filename: fileName),
      "interest_id": interestid.toString().replaceAll(' ', '').toString(),
      "is_prometed": 0,
    });
    final token = CacheHelper.getData(key: TOKEN);
    DioHelper.postData(
      url: CREAT,
      token: token,
      data: formData,
    ).then((response) {
      if (response.statusCode == 200) {
        emit(AddPostCreatPostSuccessStates());
      } else if (response.statusCode! >= 500) {
        print(response.data);
        emit(AddPostCreatPostErrorStates("Error on server"));
      } else {
        print(response.data);
        emit(AddPostCreatPostErrorStates(
            ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      print(error);
      emit(AddPostCreatPostErrorStates("Error on server"));
    });
  }
}
