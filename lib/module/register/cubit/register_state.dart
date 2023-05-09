part of 'register_cubit.dart';

@immutable
abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

// !! Register
class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final RegisterModel user;

  RegisterSuccessState(this.user);
}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

// !! Register
class RegisterAddPhotoLoadingState extends RegisterStates {}

class RegisterAddPhotoSuccessState extends RegisterStates {}

class RegisterAddPhotoErrorState extends RegisterStates {
  final String error;
  RegisterAddPhotoErrorState(this.error);
}

// !! Change Password
class ChangePasswordVisibilityState extends RegisterStates {}

class ChangeConfirmPasswordVisibilityState extends RegisterStates {}
