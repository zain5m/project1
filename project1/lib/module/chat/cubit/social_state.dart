part of 'social_cubit.dart';

@immutable
abstract class SocialStates {}

class SocialInitialStates extends SocialStates {}

// !Get user
class SocialGetUserLoadingStates extends SocialStates {}

class SocialGetUserSuccessStates extends SocialStates {}

class SocialGetUserErrorStates extends SocialStates {
  final String error;
  SocialGetUserErrorStates(this.error);
}

// !Get All user
class SocialGetAllUserLoadingStates extends SocialStates {}

class SocialGetAllUserSuccessStates extends SocialStates {}

class SocialGetAllUserErrorStates extends SocialStates {
  final String error;
  SocialGetAllUserErrorStates(this.error);
}

// !Get && Send message

class SocialSendMessageSuccessStates extends SocialStates {}

class SocialSendMessageErrorStates extends SocialStates {}

class SocialGetMessageSuccessStates extends SocialStates {}

class SocialGetMessageErrorStates extends SocialStates {}

class e extends SocialStates {}
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !Cerat USER MODEL

class SocialCreateandUpdateUserLoadingState extends SocialStates {}

class SocialCreateandUpdateUserSccessState extends SocialStates {}

class SocialCreateandUpdateUserErrorState extends SocialStates {
  final String error;
  SocialCreateandUpdateUserErrorState(this.error);
}
