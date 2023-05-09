import 'package:flutter/material.dart';

class CustemLanguageMeunShapeBorder extends ShapeBorder {
  const CustemLanguageMeunShapeBorder();

  final BorderSide _side = BorderSide.none;
  final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final Path path = Path();

    path.addRRect(
      _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
    );

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);
    path.moveTo(0, 10); //!----------------------------------------------1
    path.quadraticBezierTo(0, 0, 10, 0); //!-----------------------------2 3
    // path.lineTo(rrect.width - 30, 0); //!--------------------------------4
    // path.lineTo(rrect.width - 20, -10); //!------------------------------5
    path.lineTo(rrect.width - 10, 0); //!--------------------------------6
    path.quadraticBezierTo(rrect.width, 0, rrect.width, 10); //!---------7 8
    path.lineTo(rrect.width, rrect.height - 10); //!---------------------9
    path.quadraticBezierTo(
        //!-------------------------------------------!
        rrect.width,
        rrect.height,
        rrect.width - 10,
        rrect.height); //!--10 11
    path.lineTo(10, rrect.height); //!-----------------------------------!
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 10); //!---13 14
    path.lineTo(0, rrect.height / 2 - 10);
    path.lineTo(-10, rrect.height / 2); //!-----------------------------------!
    path.lineTo(0, rrect.height / 2 + 10);
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
      );
}
