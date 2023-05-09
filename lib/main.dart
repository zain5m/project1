import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:project1/shared/network/remote/pusher.dart';
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
  // Pusher.initPusherClient();
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
            theme: ThemeData(
              applyElevationOverlayColor: true,
              primarySwatch:
                  ColorToMaterialColor(defaultColor).toMaterialByOpacity(),
              scaffoldBackgroundColor: Colors.white,
              iconTheme: const IconThemeData(
                color: defaultColor,
              ),
              appBarTheme: AppBarTheme(
                titleSpacing: 20,
                surfaceTintColor: Colors.amber,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                  statusBarColor: Colors.white,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                titleTextStyle: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
                selectedItemColor: defaultColor,
              ),
              primaryTextTheme: TextTheme(
                titleMedium: TextStyle().copyWith(
                  color: Colors.white,
                ),
              ),
              textTheme: TextTheme().copyWith(
                caption: TextStyle().copyWith(
                  color: Colors.white,
                  fontSize: 10,
                ),
                bodyText1: TextStyle(),
              ),
            ),
            //lightTheme,
            darkTheme: darkTheme,
            themeMode: cubit.isDark! ? ThemeMode.dark : ThemeMode.light,
            routes: routes,
            // initialRoute:
            // AddPhotoRegisterScreen.routeName,

            // initialRoute: AddPhotoRegisterScreen.routeName,
            home: token != null ? AppLayout() : WelcomScreen(),
          );
        },
      ),
    );
  }
}

class _CascadeLayoutDelegate extends MultiChildLayoutDelegate {
  _CascadeLayoutDelegate({
    required this.colors,
    required this.overlap,
    required this.textDirection,
  });

  final Map<String, Color> colors;
  final double overlap;
  final TextDirection textDirection;

  // Perform layout will be called when re-layout is needed.
  @override
  void performLayout(Size size) {
    final double columnWidth = size.width / colors.length;
    Offset childPosition = Offset.zero;
    switch (textDirection) {
      case TextDirection.rtl:
        childPosition += Offset(size.width, 0);
        break;
      case TextDirection.ltr:
        break;
    }
    for (final String color in colors.keys) {
      // layoutChild must be called exactly once for each child.
      final Size currentSize = layoutChild(
        color,
        BoxConstraints(maxHeight: size.height, maxWidth: columnWidth),
      );
      // positionChild must be called to change the position of a child from
      // what it was in the previous layout. Each child starts at (0, 0) for the
      // first layout.
      switch (textDirection) {
        case TextDirection.rtl:
          positionChild(color, childPosition - Offset(currentSize.width, 0));
          childPosition +=
              Offset(-currentSize.width, currentSize.height - overlap);
          break;
        case TextDirection.ltr:
          positionChild(color, childPosition);
          childPosition +=
              Offset(currentSize.width, currentSize.height - overlap);
          break;
      }
    }
  }

  // shouldRelayout is called to see if the delegate has changed and requires a
  // layout to occur. Should only return true if the delegate state itself
  // changes: changes in the CustomMultiChildLayout attributes will
  // automatically cause a relayout, like any other widget.
  @override
  bool shouldRelayout(_CascadeLayoutDelegate oldDelegate) {
    return oldDelegate.textDirection != textDirection ||
        oldDelegate.overlap != overlap;
  }
}

class s extends StatelessWidget {
  static const Map<String, Color> _colors = <String, Color>{
    'Red': Colors.red,
    'Green': Colors.green,
    'Blue': Colors.blue,
    'Cyan': Colors.cyan,
  };
  const s({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: _CascadeLayoutDelegate(
        colors: _colors,
        overlap: 30.0,
        textDirection: Directionality.of(context),
      ),
      children: <Widget>[
        // Create all of the colored boxes in the colors map.

        for (MapEntry<String, Color> entry in _colors.entries)
          // The "id" can be any Object, not just a String.
          LayoutId(
            id: entry.key,
            child: Container(
              color: entry.value,
              width: 100.0,
              height: 100.0,
              alignment: Alignment.center,
              child: Text(entry.key),
            ),
          ),
      ],
    );
  }
}
