part of 'forgot_password_cubit.dart';

@immutable
abstract class ForgotPasswordStates {}

class ForgotPasswordInitialState extends ForgotPasswordStates {}

class ChangePasswordVisibilityState extends ForgotPasswordStates {}

class ChangeConfirmPasswordVisibilityState extends ForgotPasswordStates {}

class RestPasswordLoadingState extends ForgotPasswordStates {}

class RestPasswordSucssesState extends ForgotPasswordStates {
  String? sucsses;
  RestPasswordSucssesState(this.sucsses);
}

class RestPasswordErrorState extends ForgotPasswordStates {
  String? error;
  RestPasswordErrorState(this.error);
}

class ComfirmCodeLoadingState extends ForgotPasswordStates {}

class ComfirmCodeSucssesState extends ForgotPasswordStates {
  String? sucsses;
  ComfirmCodeSucssesState(this.sucsses);
}

class ComfirmCodeErrorState extends ForgotPasswordStates {
  String? error;
  ComfirmCodeErrorState(this.error);
}

class NewPasswordLoadingState extends ForgotPasswordStates {}

class NewPasswordSucssesState extends ForgotPasswordStates {
  String? sucsses;
  NewPasswordSucssesState(this.sucsses);
}

class NewPasswordErrorState extends ForgotPasswordStates {
  String? error;
  NewPasswordErrorState(this.error);
}
