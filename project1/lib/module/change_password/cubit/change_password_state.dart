part of 'change_password_cubit.dart';

@immutable
abstract class ChangePasswordStates {}

class ChangePasswordInitialState extends ChangePasswordStates {}

// !
class ChangeOldPasswordVisibilityState extends ChangePasswordStates {}

class ChangeNewPasswordVisibilityState extends ChangePasswordStates {}

class ChangeNewConfirmPasswordVisibilityState extends ChangePasswordStates {}
// !!

class ChangePasswordLoadingState extends ChangePasswordStates {}

class ChangePasswordSuccessState extends ChangePasswordStates {
  String success;
  ChangePasswordSuccessState(this.success);
}

class ChangePasswordErrorState extends ChangePasswordStates {
  String error;
  ChangePasswordErrorState(this.error);
}
