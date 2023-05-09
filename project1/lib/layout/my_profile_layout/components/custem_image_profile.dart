import 'package:flutter/material.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:project1/tes/s.dart';
import 'dart:math';

class CustomPainterImageProfile extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = defaultColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    //    canvas.drawArc(
    //   Rect.fromCenter(
    //     center: Offset(size.height / 2, size.width / 2),
    //     height: size.height,
    //     width: size.width,
    //   ),
    //   // math.pi,
    //   // math.pi,
    //   false,
    //   paint,
    // );
    // double degToRad(num deg) => deg * (3.14 / 180.0);

    Path path = Path();

    // path.arcToPoint(
    //   Offset(0, size.height),
    //   radius: Radius.circular(20),
    //   // clockwise: true,
    // );
    // path.conicTo(size.width, 0, size.width, size.height * 0.5, 0.9);
    // path.conicTo(
    //     size.width, size.height * 0.5, size.width * 0, size.height, -5);
    path.moveTo(0, 0);
    // path.relativeArcToPoint(
    //   Offset(0, size.height),
    //   radius: Radius.circular(size.width),
    // );

// ! TEst
    path.cubicTo(
      size.width,
      size.height * 0,
      size.width, //* 0.95,
      size.height * 0.5,
      size.width, //* 0.95,
      size.height * 0.5,
    );

    path.cubicTo(
      size.width, //* 0.95,
      size.height * 0.55,
      size.width, //* 0.99,
      size.height,
      size.width * 0,
      size.height,
    );
// !
    canvas.drawPath(path, paint);

    // path.cubicTo(
    //   size.width * 0.93,
    //   size.height * 0.39,
    //   size.width * 0.99,
    //   size.height * 0.4,
    //   size.width * 0.9,
    //   size.height * 0.5,
    // );

    // path.quadraticBezierTo(size.width * 2, size.height / 2, 0, size.height);
    // path.arcTo(rect, startAngle, sweepAngle, forceMoveTo);
    // path.quadraticBezierTo(size.width, size.height / 2, 0, size.height);
    // path.quadraticBezierTo(size.width, size.height / 2, 0, size.height);
    // path.arcToPoint(Offset(0, size.height),
    //     radius: Radius.circular(20), clockwise: true);
    // canvas.drawPath(path, paint);

    // canvas.drawArc(
    //   Rect.fromCenter(
    //     center: Offset(0, size.height),
    //     height: size.width,
    //     width: size.width,
    //   ),
    //   pi,
    //   pi,
    //   false,
    //   paint,
    // );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MyPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final redCircle = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    final arcRect = Rect.fromCircle(
      center: Offset.zero,
      radius: size.shortestSide,
    );
    canvas.drawArc(arcRect, pi, 0, false, redCircle);
  }

  @override
  bool shouldRepaint(MyPainter1 oldDelegate) => false;
}

class MyPainter extends CustomPainter {
  MyPainter({this.sweepAngle, this.color});
  final double? sweepAngle;
  final Color? color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = 60.0 // 1.
      ..style = PaintingStyle.stroke // 2.
      ..color = color!; // 3.

    double degToRad(double deg) => deg * (pi / 180.0);

    final path = Path()
      ..arcTo(
          // 4.
          Rect.fromCenter(
            center: Offset(size.height / 2, size.width / 2),
            height: size.height,
            width: size.width,
          ), // 5.
          degToRad(180), // 6.
          degToRad(sweepAngle!), // 7.
          false);

    canvas.drawPath(path, paint); // 8.
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// <Path>
class CustomClipperImageProfile extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    // path.arcToPoint(
    //   Offset(0, size.height),
    //   radius: Radius.circular(30),
    // );
    // path.relativeArcToPoint(
    //   Offset(0, size.height),
    //   radius: Radius.circular(size.width * 0.9),
    // );
    path.cubicTo(
      size.width,
      size.height * 0,
      size.width, //* 0.95,
      size.height * 0.5,
      size.width, //* 0.95,
      size.height * 0.5,
    );

    path.cubicTo(
      size.width, //* 0.95,
      size.height * 0.5,
      size.width, //* 0.99,
      size.height,
      size.width * 0,
      size.height,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}


//! Test
// class A3 extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint_0_fill = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;
//     // paint_0_fill.color = Colors.white;
//     Path path_0 = Path();
//     path_0.moveTo(size.width * 0.4426891, size.height * 2.715845);
//     // path_0.moveTo(size.width * 0.4426891, size.height * 2.715845);
//     path_0.lineTo(size.width * 0.3825483, size.height * 2.716557);
//     // path_0.cubicTo(
//     //     size.width * 0.3825483,
//     //     size.height * 2.716557,
//     //     size.width * 0.3825483,
//     //     size.height * 2.715875,
//     //     size.width * 0.3825483,
//     //     size.height * 2.714564);
//     path_0.lineTo(size.width * 0, size.height * 2.706392);
//     path_0.lineTo(size.width * 0, size.height * 2.209508);
//     path_0.lineTo(size.width * 0, size.height * 2.209508);
//     path_0.cubicTo(
//       size.width * 0.2790633,
//       size.height * 2.209508,
//       size.width * 0.3299170,
//       size.height * 2.215099,
//       size.width * 0.3703818,
//       size.height * 2.122769,
//     );
//     path_0.cubicTo(
//         size.width * 0.3921328,
//         size.height * 2.080049,
//         size.width * 0.4125995,
//         size.height * 2.067986,
//         size.width * 0.4293893,
//         size.height * 2.069379);
//     path_0.cubicTo(
//         size.width * 0.4461790,
//         size.height * 2.067980,
//         size.width * 0.4666458,
//         size.height * 2.080049,
//         size.width * 0.4883968,
//         size.height * 2.122769);
//     path_0.cubicTo(
//         size.width * 0.5288616,
//         size.height * 2.215105,
//         size.width * 0.5797153,
//         size.height * 2.209508,
//         size.width * 0.5797153,
//         size.height * 2.209508);
//     path_0.lineTo(size.width, size.height * 2.209508);
//     path_0.lineTo(size.width, size.height * 2.710866);
//     path_0.lineTo(size.width, size.height * 2.715445);
//     // path_0.cubicTo(
//     //     size.width * 0.4762348,
//     //     size.height * 2.716180,
//     //     size.width * 0.4762348,
//     //     size.height * 2.716557,
//     //     size.width * 0.4762348,
//     //     size.height * 2.716557);
//     path_0.close();

//     canvas.drawPath(path_0, paint_0_fill);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

