import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project1/models/error_model%20.dart';
import 'package:project1/models/register/register_model.dart';
import 'package:project1/models/user_data_model.dart';
import 'package:project1/module/login/cubit/login_cubit.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/constants.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/network/remote/dio_helper.dart';
import 'package:project1/shared/network/remote/end_points.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;

  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  IconData suffixConfirm = Icons.visibility_outlined;

  bool isPasswordConfirm = true;

  void changeConfirmPasswordVisibility() {
    isPasswordConfirm = !isPasswordConfirm;
    suffixConfirm = isPasswordConfirm
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangeConfirmPasswordVisibilityState());
  }

  RegisterModel? user;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required int gender,
    required String date,
    required String fcm,
  }) {
    emit(RegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data: {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "gender": gender,
        "birthday": date.toString(),
        "FCM": fcm,
      },
    ).then((response) {
      if (response.statusCode == 201) {
        user = RegisterModel.fromJson(response.data);
        emit(RegisterSuccessState(user!));
      } else if (response.statusCode! >= 500) {
        print(response.statusCode);
        print(response.data);
        emit(RegisterErrorState("Error on server"));
      } else {
        print(response.statusCode);
        print(response.data);
        emit(RegisterErrorState(ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      print(error);
    });
  }

  void userRegisterAddPhoto({
    required File? image,
  }) async {
    emit(RegisterAddPhotoLoadingState());
    String fileName = image!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "photo": await MultipartFile.fromFile(image.path, filename: fileName),
    });
    final token = CacheHelper.getData(key: TOKEN);

    DioHelper.postData(
      url: ADDPHOTO,
      token: token,
      data: formData,
    ).then((response) {
      if (response.statusCode == 200) {
        emit(RegisterAddPhotoSuccessState());
      } else if (response.statusCode! >= 500) {
        emit(RegisterAddPhotoErrorState("Error on server"));
      } else {
        emit(RegisterAddPhotoErrorState(
            ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      print(error);
    });
  }
}



// Future<File> getImageFileFromAssets1(String path) async {
  //   final byteData = await rootBundle.load('/$path');

  //   final file = File('${(await getTemporaryDirectory()).path}/$path');
  //   await file.writeAsBytes(byteData.buffer
  //       .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  //   return file;
  // }

  // Future<File> getLocalFile(String filename) async {
  //   String dir = (await getApplicationDocumentsDirectory()).path;
  //   File f = File('$dir/$filename');
  //   return f;
  // }

  // Future<File?> getImageFileFromAssets(String? path) async {
  //   final byteData = await rootBundle.load(path!);
  //   final file = File('${(await getTemporaryDirectory()).path}/$path');
  //   final file1 = await file.writeAsBytes(byteData.buffer
  //       .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  //   return file1;
  // }
