import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project1/models/error_model%20.dart';
import 'package:project1/shared/network/remote/dio_helper.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordStates> {
  ForgotPasswordCubit() : super(ForgotPasswordInitialState());

  static ForgotPasswordCubit get(context) => BlocProvider.of(context);

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

  void restPassword({
    required String email,
  }) {
    emit(RestPasswordLoadingState());
    DioHelper.postData(
      url: "checkemail",
      data: {
        'email': email,
      },
    ).then((response) {
      if (response.statusCode == 200) {
        emit(RestPasswordSucssesState(response.data.toString()));
      } else if (response.statusCode! >= 500) {
        emit(RestPasswordErrorState("Error on server"));
      } else {
        emit(RestPasswordErrorState(
            ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      print(error);
      emit(RestPasswordErrorState(error.toString()));
    });
  }

  void comfirmCode({
    required String email,
    required String code,
  }) {
    emit(ComfirmCodeLoadingState());
    DioHelper.postData(
      url: "chkcode",
      data: {
        'email': email,
        "code": code,
      },
    ).then((response) {
      if (response.statusCode == 200) {
        emit(ComfirmCodeSucssesState(response.data.toString()));
      } else if (response.statusCode! >= 500) {
        emit(ComfirmCodeErrorState("Error on server"));
      } else {
        emit(
            ComfirmCodeErrorState(ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      print(error);
      emit(ComfirmCodeErrorState(error.toString()));
    });
  }

  void newPassword({
    required String email,
    required String password,
    required String compassword,
  }) {
    emit(NewPasswordLoadingState());
    DioHelper.postData(
      url: "resetpassword",
      data: {
        "newpassword": password,
        "newpassword_confirmation": compassword,
        'email': email
      },
    ).then((response) {
      if (response.statusCode == 200) {
        emit(NewPasswordSucssesState(response.data.toString()));
      } else if (response.statusCode! >= 500) {
        print(response.data);
        emit(NewPasswordErrorState("Error on server"));
      } else {
        print(response.data);
        emit(
            NewPasswordErrorState(ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((error) {
      print(error);
      emit(NewPasswordErrorState(error.toString()));
    });
  }
}
