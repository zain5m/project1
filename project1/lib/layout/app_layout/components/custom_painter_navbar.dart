import 'package:flutter/material.dart';

class CustomPainterNavigationBar extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;

    Path path = Path();
    path.moveTo(0, 0); // Start
    path.lineTo(size.width * 0.20, 0);
    path.quadraticBezierTo(size.width * 0.30, 0, size.width * 0.45, -35);
    path.arcToPoint(Offset(size.width * 0.55, -35),
        radius: Radius.elliptical(70, 70), clockwise: true);
    path.quadraticBezierTo(size.width * 0.69, 0, size.width * 0.75, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);

    ///???????
    // path.moveTo(0, 0); // Start
    // // path.moveTo(0, size.height / 2);
    // path.quadraticBezierTo(size.width * 0.10, 0, size.width * 0.40, 0);
    // path.quadraticBezierTo(size.width * 0.10, 0, size.width * 0.40, 0);
    // // path.quadraticBezierTo(size.width * 0.50, -60, size.width * 0.59, 0);
    // // path.lineTo(size.width, 0);
    // // path.lineTo(size.width, size.height);
    // // path.lineTo(0, size.height);
    // // path.lineTo(0, 0);
    // canvas.drawShadow(path, Colors.black, 5, true);

    //??????
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class CustomPainterNavigationBar2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    Path path = Path();
    path.moveTo(0, size.height * 0.2);
    path.cubicTo(0, size.height * 0.2, size.width * 0.2, size.height / 4,
        size.width, size.height);

    path.lineTo(size.width / 2, 0);
    // path.lineTo(size.width, 0);
    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);
    // path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
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