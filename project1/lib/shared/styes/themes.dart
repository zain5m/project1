import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project1/shared/styes/colors.dart';

// import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: ColorToMaterialColor(defaultColor).toMaterialByOpacity(),
  scaffoldBackgroundColor: Color(0XFF333739),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      // statusBarColor: HexColor("#333739"),
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    // backgroundColor: HexColor("#333739"),
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    // backgroundColor: HexColor("#333739"),
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    selectedItemColor: defaultColor,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
);

ThemeData lightTheme = ThemeData(
  primarySwatch: ColorToMaterialColor(defaultColor).toMaterialByOpacity(),
  scaffoldBackgroundColor: Colors.white,
  iconTheme: IconThemeData(
    color: defaultColor,
  ),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
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
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    selectedItemColor: defaultColor,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
);
