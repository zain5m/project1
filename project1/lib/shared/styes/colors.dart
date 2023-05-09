import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String ISDARK = 'ISDARK';

extension ColorToMaterialColor on Color {
  static List<int> palettes = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  MaterialColor toMaterialByOpacity() {
    Map<int, Color> colors = palettes.asMap().map((index, palette) =>
        MapEntry(palette, this.withOpacity((index + 1) / 10)));
    return MaterialColor(this.value, colors);
  }
}

const defaultColor = Color.fromRGBO(26, 35, 126, 1); //Color(0xFF5464FF);;
final Color textColor = Color(0xff7c7d7e);
final Color customNavigationBarColor = Colors.white;
final Color welcomColor = Colors.black;
final Color mycolor3 = Color(0xFF5464FF);
const Color formFieldColor = Color(0xfff2f2f2);
final Color hintFieldColor = Color(0xffb6b7b7);
final Color defaultSecondColor = Color.fromRGBO(33, 45, 164, 3);
