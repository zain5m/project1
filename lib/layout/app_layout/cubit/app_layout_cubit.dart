import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/home_layout/home_layout.dart';
import 'package:project1/layout/my_profile_layout/my_profile_layout.dart';
import 'package:project1/module/chat/chats_screen.dart';
import 'package:project1/module/notifications/notifications_screen.dart';
part 'app_layout_state.dart';

class AppLayoutCubit extends Cubit<AppLayoutStates> {
  AppLayoutCubit() : super(AppLayoutInitialState());

  static AppLayoutCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> screens = [
    HomeLayout(),
    NotificationsScreen(),
    ChatsScreen(),
    MyProfileLayout(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavStates());
  }
}
