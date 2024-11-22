import 'package:flutter/material.dart';

class RectWithGap extends StatelessWidget {
  const RectWithGap({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 300),
      painter: RectangleWithGapPainter(),
    );
  }
}

class RectangleWithGapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue // Outer rectangle color
      ..style = PaintingStyle.fill;

    // Draw the outer rectangle
    canvas.drawRect(Offset.zero & size, paint);

    // Define the inner gap (rectangle in the middle)
    double gapLeft = size.width / 4;
    double gapTop = size.height / 4;
    double gapWidth = size.width / 2;
    double gapHeight = size.height / 2;

    // Make a paint for the gap area (transparent)
    Paint gapPaint = Paint()..color = Colors.black;

    // Draw the gap in the middle by creating a transparent rectangle in the middle
    canvas.drawRect(
        Rect.fromLTWH(gapLeft, gapTop, gapWidth, gapHeight), gapPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
