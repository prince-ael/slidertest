import 'package:flutter/material.dart';
import 'package:slidertest/main.dart';

class RoundedRectWidget extends StatelessWidget {
  const RoundedRectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 200), // Specify the size of the custom widget
      painter: OuterInnerRectPainter(),
    );
  }
}

class OuterInnerRectPainter extends CustomPainter {
  final Color outerColor;
  final Color innerColor;
  final double outerBorderRadius;
  final double innerBorderRadius;

  OuterInnerRectPainter({
    this.outerColor = bg,
    this.innerColor = Colors.red,
    this.outerBorderRadius = 20.0,
    this.innerBorderRadius = 10.0,
  });

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
      ..color = outerColor
      ..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final Paint innerPaint = Paint()
      ..color = innerColor
      ..style = PaintingStyle.fill;

    // Outer rectangle size and position
    Rect outerRect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Inner rectangle size and position (smaller, inside the outer rectangle)
    RRect innerRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(30, 30, size.width - 60, size.height - 60),
      Radius.circular((size.width - 60) / 2),
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
