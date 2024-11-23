
import 'package:flutter/material.dart';

class Mask extends StatelessWidget {
  final double widthFactor;
  final double aspectRatio;
  const Mask({
    super.key,
    required this.widthFactor,
    required this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MaskPainter(
        widthFactor,
        aspectRatio,
        MediaQuery.of(context).padding.top,
      ),
    );
  }
}

class MaskPainter extends CustomPainter {
  final double widthFactor;
  final double aspectRatio;
  final double statusbarHeight;
  MaskPainter(
    this.widthFactor,
    this.aspectRatio,
    this.statusbarHeight,
  );

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
    final Size innerRectSize = computeInnerRectSize(size);
    final Offset innerRectOffset = computeInnerRectOffset(innerRectSize, size);

    final RRect innerRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        innerRectOffset.dx,
        innerRectOffset.dy,
        innerRectSize.width,
        innerRectSize.height,
      ),
      Radius.circular(innerRectSize.width / 2),
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

  Size computeInnerRectSize(Size outerRectSize) {
    final innerRectWidth = outerRectSize.width * widthFactor;
    final innerRectHeight = innerRectWidth / aspectRatio;
    return Size(innerRectWidth, innerRectHeight);
  }

  Offset computeInnerRectOffset(Size innerRectSize, Size outerRectSize) {
    final outerRectHeight = outerRectSize.width / 0.75;
    final dx = (outerRectSize.width - innerRectSize.width) / 2;
    final dy = ((outerRectHeight - innerRectSize.height) / 2) +
        statusbarHeight +
        kToolbarHeight;
    return Offset(dx, dy);
  }
}

// inner rect => W:H = 256:350
// outer rect => W:H = 360:800
// 256 / 360 = 0.71 (iwc)
// 350 / 800 = 0.43 (ihc)

// 142/800 = 0.175
// 52/350 = 0.14