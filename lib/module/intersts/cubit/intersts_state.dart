part of 'intersts_cubit.dart';

@immutable
abstract class InterstsStates {}

class InterstsInitialState extends InterstsStates {}

// !
class ChangeInterstsSelectedState extends InterstsStates {}

// !
class RegisterAddInsterstsLoadingState extends InterstsStates {}

class RegisterAddInsterstsSucssesState extends InterstsStates {}

class RegisterAddInsterstsErrorState extends InterstsStates {
  String error;
  RegisterAddInsterstsErrorState(this.error);
}

// !
class UpdateInsterstsLoadingState extends InterstsStates {}

class UpdateInsterstsSucssesState extends InterstsStates {}

class UpdateInsterstsErrorState extends InterstsStates {
  String error;
  UpdateInsterstsErrorState(this.error);
}
