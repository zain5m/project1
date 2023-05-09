part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearshinterestLoading extends SearchState {}

class SearshinterestSucsses extends SearchState {}

class SearshinterestError extends SearchState {
  String error;
  SearshinterestError(this.error);
}

class SearshUserLoading extends SearchState {}

class SearshUserSucsses extends SearchState {}

class SearshUserError extends SearchState {
  String error;
  SearshUserError(this.error);
}
