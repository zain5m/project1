import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/firebase_options.dart';

import 'package:project1/layout/app_layout/app_layout.dart';
import 'package:project1/layout/app_layout/cubit/app_layout_cubit.dart';
import 'package:project1/layout/home_layout/cubit/home_layout_cubit.dart';
import 'package:project1/layout/my_profile_layout/cubit/my_profile_layout_cubit.dart';
import 'package:project1/module/add_photo/add_photo_register_screen.dart';
import 'package:project1/module/chat/chats_screen.dart';
import 'package:project1/module/chat/cubit/social_cubit.dart';
import 'package:project1/module/follow/cubit/follow_cubit.dart';
import 'package:project1/module/home_post/cubit/home_post_cubit.dart';
import 'package:project1/module/home_post/home_post_screen.dart';
import 'package:project1/module/show_post/cubit/show_post_cubit.dart';
import 'package:project1/module/welcom/welcom_screen.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/cubit/app_cubit.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/network/local/local_notifications.dart';
import 'package:project1/shared/network/remote/pusher_service.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:project1/shared/styes/themes.dart';
import 'shared/bloc_observer.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/routes/routes.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  LocalNotifications.display(message);
}

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DioHelper.init();
  await CacheHelper.init();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  messaging.getToken().then((value) {
    print(value);
    CacheHelper.saveData(key: FCM, value: value)
        .then((value) {})
        .catchError((e) {});
  });

  FirebaseMessaging.instance.getInitialMessage().then((message) {
    print(message);
  });
  // FirebaseMessaging.instance.getInitialMessage().then((message) {});

  // FirebaseMessaging.onMessage.listen((message) {});
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    LocalNotifications.display(message);
  });
  // print(token);
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!');
  //   print('Message data: ${message.data}');

  //   if (message.notification != null) {
  //     print('Message also contained a notification: ${message.notification}');
  //   }
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // });
  FirebaseMessaging.onMessage.listen((event) {
    LocalNotifications.display(event);
  });

  // ! whrn click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    LocalNotifications.display(event);

    //! show a notification at top of screen.
    // showSimpleNotification(Text("this is a message from simple notification"),
    // background: Colors.green);
  });

  runApp(MyApp());
  // },
  // blocObserver: MyBlocObserver(),
  // );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocalNotifications.initialze(context);
    final token = CacheHelper.getData(key: TOKEN);
    // LocalNotifications.initialze(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            ..changeAppMode(isMode: CacheHelper.getData(key: ISDARK) ?? false),
        ),
        BlocProvider(
          create: (context) => FollowCubit()..getFollowing(),
        ),
        BlocProvider(
          create: (context) => AppLayoutCubit(),
        ),
        BlocProvider(
          create: (context) => SocialCubit(),
        ),
        BlocProvider(
          create: (context) => HomePostCubit(),
        ),
        BlocProvider(
          create: (context) => HomeLayoutCubit(),
        ),
        BlocProvider(
          create: (context) => MyProfileLayoutCubit()..getDataProfile(),
        ),
        BlocProvider(
          create: (context) => ShowPostCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          // print(token);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // localizationsDelegates:  ,//AppLocalizations.localizationsDelegates,
            // supportedLocales: AppLocalizations.supportedLocales,
            // locale: Locale('en', 'US'), // AppCubit.get(context).localLang,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: cubit.isDark! ? ThemeMode.dark : ThemeMode.light,
            routes: routes,
            initialRoute:
                // AddPhotoRegisterScreen.routeName,
                token != null ? AppLayout.routeName : WelcomScreen.routeName,
            // initialRoute: AddPhotoRegisterScreen.routeName,
            // home: ChatsScreen(),
          );
        },
      ),
    );
  }
}
