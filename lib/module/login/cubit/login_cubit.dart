import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project1/models/error_model%20.dart';
import 'package:project1/models/register/register_model.dart';
import 'package:project1/shared/network/remote/dio_helper.dart';
import 'package:project1/shared/network/remote/end_points.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;

  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  RegisterModel? user;
  void userLogin({
    required var email,
    required var password,
    required var fcm,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
        'FCM': fcm,
      },
    ).then((response) {
      print(response.data);

      if (response.statusCode == 201) {
        user = RegisterModel.fromJson(response.data);
        emit(LoginSuccessState(user!));
      } else if (response.statusCode! >= 500) {
        emit(LoginErrorState("Error on server"));
      } else {
        emit(LoginErrorState(ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      print(error);
    });
  }
}
