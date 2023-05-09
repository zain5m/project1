part of 'explore_cubit.dart';

@immutable
abstract class ExploreStates {}

class ExploreInitialState extends ExploreStates {}

// !
class ExploreGetDataLoadingState extends ExploreStates {}

class ExploreGetDataSucssesState extends ExploreStates {}

class ExploreGetDataErrorState extends ExploreStates {
  final String error;
  ExploreGetDataErrorState(this.error);
}
