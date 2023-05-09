import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:project1/models/error_model%20.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/network/remote/dio_helper.dart';
import 'package:project1/shared/network/remote/end_points.dart';
import 'package:project1/shared/styes/icon_broken.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  ChangePasswordCubit() : super(ChangePasswordInitialState());

  static ChangePasswordCubit get(context) => BlocProvider.of(context);

  IconData suffixOldPassword = Icons.visibility_outlined;

  bool isOldPassword = true;

  void changeOldPasswordVisibility() {
    isOldPassword = !isOldPassword;
    suffixOldPassword = isOldPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangeOldPasswordVisibilityState());
  }

  IconData suffixNewPassword = Icons.visibility_outlined;

  bool isNewPassword = true;

  void changeNewPasswordVisibility() {
    isNewPassword = !isNewPassword;
    suffixNewPassword = isNewPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangeNewPasswordVisibilityState());
  }

  IconData suffixNewConfirm = Icons.visibility_outlined;

  bool isNewConfirmPassword = true;

  void changeNewConfirmPasswordVisibility() {
    isNewConfirmPassword = !isNewConfirmPassword;
    suffixNewConfirm = isNewConfirmPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangeNewConfirmPasswordVisibilityState());
  }

  void changepassword({
    required String? oldPassword,
    required String? newPassword,
  }) {
    emit(ChangePasswordLoadingState());
    DioHelper.putData(
      url: CHANGEPASSWORD,
      token: CacheHelper.getData(key: TOKEN),
      data: {
        "old_password": oldPassword,
        "new_password": newPassword,
      },
    ).then((response) {
      if (response.statusCode == 200) {
        emit(ChangePasswordSuccessState(response.data));
      } else if (response.statusCode! >= 500) {
        emit(ChangePasswordErrorState("Error on server"));
      } else {
        emit(ChangePasswordErrorState(
            ErrorModel.fromJson(response.data).message!));
      }
    }).catchError((e) {
      print(e);
      emit(ChangePasswordErrorState("Error on server"));
    });
  }
}
