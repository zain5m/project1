part of 'show_post_cubit.dart';

@immutable
abstract class ShowPostStates {}

class ShowPostInitialState extends ShowPostStates {}

// !
class ShowPostLoadingState extends ShowPostStates {}

class ShowPostSuccessState extends ShowPostStates {}

class ShowPostErrorState extends ShowPostStates {
  final String? error;
  ShowPostErrorState(this.error);
}

//!
class SendCommentLoadingState extends ShowPostStates {}

class SendCommentSuccessState extends ShowPostStates {}

class SendCommentErrorState extends ShowPostStates {
  final String? error;
  SendCommentErrorState(this.error);
}

//!React
class ReactLoadingState extends ShowPostStates {}

class ReactSuccessState extends ShowPostStates {}

class ReactErrorState extends ShowPostStates {
  final String? error;
  ReactErrorState(this.error);
}

//!delet Comment
class DeletCommentLoadingState extends ShowPostStates {}

class DeletCommentSuccessState extends ShowPostStates {}

class DeletCommentErrorState extends ShowPostStates {
  final String? error;
  DeletCommentErrorState(this.error);
}

//!delet Comment
class UpdateCommentLoadingState extends ShowPostStates {}

class UpdateCommentSuccessState extends ShowPostStates {}

class UpdateCommentErrorState extends ShowPostStates {
  final String? error;
  UpdateCommentErrorState(this.error);
}

class AddCommentState extends ShowPostStates {}
