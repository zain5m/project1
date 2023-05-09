part of 'add_post_cubit.dart';

@immutable
abstract class AddPostStates {}

class AddPostInitialState extends AddPostStates {}

// !
class AddPostChangeShowIntersteState extends AddPostStates {}

// !
class AddPostChangeInterstsSelectedState extends AddPostStates {}

// !
class AddPostCreatPostLoadingStates extends AddPostStates {}

class AddPostCreatPostSuccessStates extends AddPostStates {}

class AddPostCreatPostErrorStates extends AddPostStates {
  final String error;
  AddPostCreatPostErrorStates(this.error);
}
