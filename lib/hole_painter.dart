import 'package:flutter/material.dart';

class CircularHolePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue // The color of the outer area
      ..style = PaintingStyle.fill;

    // Draw the outer background (solid color)
    canvas.drawRect(const Offset(0, 0) & size, paint);

    // Now, make the "hole" in the middle transparent (by drawing a white circle over the background)
    final holePaint = Paint()
      ..color = Colors.transparent
      ..blendMode = BlendMode.srcIn; // This clears out the area inside the circle

    // Set the circle position and size (centered in the canvas)
    final circleCenter = Offset(size.width / 2, size.height / 2);
    final circleRadius = size.width / 4;

    // Draw the transparent circle in the middle
    canvas.drawCircle(circleCenter, circleRadius, holePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}