part of 'home_post_cubit.dart';

@immutable
abstract class HomePostStates {}

class HomePostInitialState extends HomePostStates {}

// !Get image picker for Story
class StoryImagePickedSuccessStates extends HomePostStates {}

class StoryImagePickedErrorStates extends HomePostStates {}

///!
class GetHomePostsLoadingStates extends HomePostStates {}

class GetHomePostsSuccessStates extends HomePostStates {}

class GetHomePostsErrorStates extends HomePostStates {
  String error;
  GetHomePostsErrorStates(this.error);
}

class DeletPostLoadingStates extends HomePostStates {}

class DeletPostSuccessStates extends HomePostStates {}

class DeletPostErrorStates extends HomePostStates {
  String error;
  DeletPostErrorStates(this.error);
}

class DeletStoryLoadingStates extends HomePostStates {}

class DeletStorySuccessStates extends HomePostStates {}

class DeletStoryErrorStates extends HomePostStates {
  String error;
  DeletStoryErrorStates(this.error);
}

//!React
class ReactLoadingState extends HomePostStates {}

class ReactSuccessState extends HomePostStates {}

class ReactErrorState extends HomePostStates {
  final String? error;
  ReactErrorState(this.error);
}

class AddPostState extends HomePostStates {}

//!React
class UpdatePostLoadingState extends HomePostStates {}

class UpdatePostSuccessState extends HomePostStates {}

class UpdatePostErrorStat extends HomePostStates {
  final String? error;
  UpdatePostErrorStat(this.error);
}
