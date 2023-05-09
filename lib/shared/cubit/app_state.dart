part of 'app_cubit.dart';

@immutable
abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeLocalState extends AppStates {}

class AppChangeDropdownButtonState extends AppStates {}

class AppChangeModeState extends AppStates {}
