part of 'follow_cubit.dart';

@immutable
abstract class FollowStates {}

class FollowInitialState extends FollowStates {}

// !
class FollowGetFollowersLoadingStates extends FollowStates {}

class FollowGetFollowersSucssesStates extends FollowStates {}

class FollowGetFollowersErrorStates extends FollowStates {
  final String? error;
  FollowGetFollowersErrorStates(this.error);
}

// !
class FollowGetFollowingLoadingStates extends FollowStates {}

class FollowGetFollowingSucssesStates extends FollowStates {}

class FollowGetFollowingErrorStates extends FollowStates {
  final String? error;
  FollowGetFollowingErrorStates(this.error);
}
