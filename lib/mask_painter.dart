import 'package:flutter/material.dart';

class RectMaskPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black.withOpacity(0.0)
      ..style = PaintingStyle.fill;

    // Draw a rectangular mask
    Rect rect = Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 200, height: 300);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


class CircMaskPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      // ..color = Colors.transparent
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    // Draw a circular mask (for example)
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = 100;

    // Draw an opaque circle
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);

    // Optional: Draw a border for the mask
    paint
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}