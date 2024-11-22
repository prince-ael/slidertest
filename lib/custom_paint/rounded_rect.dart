import 'dart:developer';

import 'package:flutter/material.dart';

class RoundedRectWidget extends StatelessWidget {
  const RoundedRectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: OuterInnerRectPainter());
  }
}

class OuterInnerRectPainter extends CustomPainter {
  OuterInnerRectPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black.withOpacity(0.35),
        Colors.black.withOpacity(0.75),
        Colors.black,
      ],
    );

    final Paint outerPaint = Paint()
      ..shader =
          gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final Paint innerPaint = Paint()
    ..strokeWidth = 8.0
    ..color = const Color(0xFFFED2E8)
    ..style = PaintingStyle.stroke;

    // Outer rectangle size and position
    Rect outerRect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Inner rectangle size and position (smaller, inside the outer rectangle)
    final double innerX = size.width * 0.14;
    final double innerY = size.width * 0.17;
    double innerWidth = size.width * 0.71;
    innerWidth = innerWidth.ceilToDouble();
    double innerHeight = size.height * 0.43;
    innerHeight = innerHeight.ceilToDouble();

    log("innerWidth: $innerWidth, innerHeight: $innerHeight");
    log("outer Width: ${size.width}, outer Height: ${size.height}");
    final RRect innerRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(innerX, innerY, innerWidth, innerHeight),
      Radius.circular(innerWidth / 2),
    );

    // Clip path to exclude the inner rectangle
    Path path = Path()
      ..addRect(outerRect)
      ..addRRect(innerRect);
    path.fillType = PathFillType.evenOdd;

    // Clip the canvas to exclude the inner rectangle
    canvas.clipPath(path);

    // Paint the outer area (excluding the inner rectangle)
    canvas.drawRect(outerRect, outerPaint);

    // Paint the inner rectangle
    canvas.drawRRect(innerRect, innerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint unless the painter data changes
  }
}

// inner rect => W:H = 256:350
// outer rect => W:H = 360:800
// 256 / 360 = 0.71 (iwc)
// 350 / 800 = 0.43 (ihc)

// 142/800 = 0.175
// 52/350 = 0.14