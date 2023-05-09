import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double screentext;

  // static double? defaultSize;
  // static Orientation? orientation;
  // static double? sorientation;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    // orientation = mediaQueryData.orientation;
    screentext = MediaQuery.of(context).textScaleFactor;
  }
}

//! Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  //* 812 is the layout height that designer use
  // if (SizeConfig.orientation == Orientation.portrait) {
  return (inputHeight / 812.0) * screenHeight;
  // } else {
  // return (inputHeight / 375.0) * screenHeight;
  // }
}

//! Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  //* 375 is the layout width that designer use

  // if (SizeConfig.orientation == Orientation.portrait) {
  return (inputWidth / 375.0) * screenWidth;
  // } else {
  // return (inputWidth / 812.0) * screenWidth;
  // }
}
