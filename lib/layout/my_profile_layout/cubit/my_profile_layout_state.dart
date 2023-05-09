part of 'my_profile_layout_cubit.dart';

@immutable
abstract class MyProfileLayoutStates {}

// !
class MyProfileLayoutInitialStates extends MyProfileLayoutStates {}

// !
class MyProfileLayoutChangeTabIndexStates extends MyProfileLayoutStates {}

// !
class ChangePasswordVisibilityState extends MyProfileLayoutStates {}

// !
class MyProfileLayoutChangeMenuIndexStates extends MyProfileLayoutStates {}

// !
class MyProfileLayoutGetDataProfileLoadingStates extends MyProfileLayoutStates {
}

class MyProfileLayoutGetDataProfileSucssesStates extends MyProfileLayoutStates {
}

class MyProfileLayoutGetDataProfileErrorStates extends MyProfileLayoutStates {
  final String error;

  MyProfileLayoutGetDataProfileErrorStates(this.error);
}

// !! LOGOUT
class MyProfileLogoutLoadingStates extends MyProfileLayoutStates {}

class MyProfileLogoutSucssesStates extends MyProfileLayoutStates {}

class MyProfileLogoutErrorStates extends MyProfileLayoutStates {
  final String error;

  MyProfileLogoutErrorStates(this.error);
}

// !! BLOCKING
class MyProfileBlockingLoadingStates extends MyProfileLayoutStates {}

class MyProfileBlockingSucssesStates extends MyProfileLayoutStates {}

class MyProfileBlockingErrorStates extends MyProfileLayoutStates {
  final String error;

  MyProfileBlockingErrorStates(this.error);
}

// !! BLOCKING
class MyProfileBlockUserLoadingStates extends MyProfileLayoutStates {}

class MyProfileBlockUserSucssesStates extends MyProfileLayoutStates {}

class MyProfileBlockUserErrorStates extends MyProfileLayoutStates {
  final String error;

  MyProfileBlockUserErrorStates(this.error);
}

// ! EDIT PROFILE
class MyProfileEditprofileLoadingStates extends MyProfileLayoutStates {}

class MyProfileEditprofileSucssesStates extends MyProfileLayoutStates {}

class MyProfileEditprofileErrorStates extends MyProfileLayoutStates {
  final String error;

  MyProfileEditprofileErrorStates(this.error);
}

// ! EDIT  PHOTO PROFILE
class MyProfileEditPhotoprofileLoadingStates extends MyProfileLayoutStates {}

class MyProfileEditPhotoprofileSucssesStates extends MyProfileLayoutStates {}

class MyProfileEditPhotoprofileErrorStates extends MyProfileLayoutStates {
  final String error;

  MyProfileEditPhotoprofileErrorStates(this.error);
}

// ! EDIT  PHOTO PROFILE
class PromoLoadingStates extends MyProfileLayoutStates {}

class PromoSucssesStates extends MyProfileLayoutStates {
  final String sucss;

  PromoSucssesStates(this.sucss);
}

class PromoErrorStates extends MyProfileLayoutStates {
  final String error;

  PromoErrorStates(this.error);
}
