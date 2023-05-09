part of 'profile_cubit.dart';

@immutable
abstract class ProfileStates {}

class ProfileInitial extends ProfileStates {}

class ProfileChangeTabIndexStates extends ProfileStates {}

class ProfileGetDataLoadingStates extends ProfileStates {}

class ProfileGetDataSucssesStates extends ProfileStates {}

class ProfileGetDataErrorStates extends ProfileStates {
  String error;
  ProfileGetDataErrorStates(this.error);
}

// !! BLOC
class ProfileBlockUserLoadingStates extends ProfileStates {}

class ProfileBlockUserSucssesStates extends ProfileStates {}

class ProfileBlockUserErrorStates extends ProfileStates {
  final String error;

  ProfileBlockUserErrorStates(this.error);
}

// !! BLOC
class ProfileFollowkUserLoadingStates extends ProfileStates {}

class ProfileFollowkUserSucssesStates extends ProfileStates {}

class ProfileFollowkUserErrorStates extends ProfileStates {
  final String error;

  ProfileFollowkUserErrorStates(this.error);
}
