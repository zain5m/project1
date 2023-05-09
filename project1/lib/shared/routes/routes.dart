import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project1/layout/app_layout/app_layout.dart';
import 'package:project1/layout/my_profile_layout/my_profile_layout.dart';
import 'package:project1/module/add_photo/add_photo_register_screen.dart';
import 'package:project1/module/add_post/add_post_screen.dart';
import 'package:project1/module/add_post/gallery_add_post_screen.dart';
import 'package:project1/module/follow/followers_screen.dart';
import 'package:project1/module/forgot_password/confirm_screen.dart';
import 'package:project1/module/forgot_password/new_password.dart';
import 'package:project1/module/home_post/home_post_screen.dart';
import 'package:project1/module/welcom/welcom_screen.dart';
import 'package:project1/module/intersts/interests_screen.dart';
import 'package:project1/module/login/login_screen.dart';
import 'package:project1/module/register/register_screen.dart.dart';
import 'package:project1/module/forgot_password/reset_password_screen.dart';
import 'package:project1/module/show_post/show_post_screen.dart';
import 'package:project1/layout/home_layout/home_layout.dart';

// class ScreenArguments {
//   var message;
//   bool? isfollow;
//   File? image;
//   int? userId;
//   String? postId;

//   ScreenArguments({
//     this.message,
//     this.isfollow,
//     this.image,
//     this.userId,
//     this.postId,
//   });
// }
//  if (ModalRoute.of(context)!.settings.arguments != null) {
//       final args =
//           ModalRoute.of(context)!.settings.arguments as ScreenArguments;
//       print(args.message);
//     }

final Map<String, WidgetBuilder> routes = {
  WelcomScreen.routeName: (context) => WelcomScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  AddPhotoRegisterScreen.routeName: (context) => AddPhotoRegisterScreen(),
  InterestsScreen.routeName: (context) => InterestsScreen(),
  AppLayout.routeName: (context) => AppLayout(),
  MyProfileLayout.routeName: (context) => MyProfileLayout(),
  GalleryAddPostScreen.routeName: (context) => GalleryAddPostScreen(),
  AddPostScreen.routeName: (context) => AddPostScreen(),
  // ShowPostScreen.routeName: (context) => ShowPostScreen(),
  // FollowersScreen.routeName: (context) => FollowersScreen(),

  // !
  HomePostScreen.routeName: (context) => HomePostScreen(),
  ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),

  HomeLayout.routeName: (context) => HomeLayout(),
};
