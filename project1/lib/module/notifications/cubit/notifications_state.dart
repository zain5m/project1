part of 'notifications_cubit.dart';

@immutable
abstract class NotificationsStates {}

class NotificationsInitialState extends NotificationsStates {}

class NotificationsGetLoadingState extends NotificationsStates {}

class NotificationsGetSucssesState extends NotificationsStates {}

class NotificationsGetErorrState extends NotificationsStates {
  String error;
  NotificationsGetErorrState(this.error);
}

class NotificationsMarkAsReadLoadingState extends NotificationsStates {}

class NotificationsMarkAsReadSucssesState extends NotificationsStates {}

class NotificationsMarkAsReadErorrState extends NotificationsStates {
  String error;
  NotificationsMarkAsReadErorrState(this.error);
}

class NotificationsReadLoadingState extends NotificationsStates {}

class NotificationsReadSucssesState extends NotificationsStates {}

class NotificationsReadErorrState extends NotificationsStates {
  String error;
  NotificationsReadErorrState(this.error);
}
