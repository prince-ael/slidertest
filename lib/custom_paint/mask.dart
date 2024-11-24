import 'package:flutter/material.dart';
import 'package:slidertest/custom_paint/mask_window.dart';

class Mask extends StatelessWidget {
  final MaskWindow maskWindow;
  final double strokeWidth;
  final Color strokeColor;

  const Mask({
    super.key,
    required this.maskWindow,
    this.strokeWidth = 8.0,
    this.strokeColor = const Color(0xFFFED2E8),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MaskPainter(
        maskWindow,
        strokeWidth,
        strokeColor,
      ),
    );
  }
}

class MaskPainter extends CustomPainter {
  final MaskWindow maskWindow;
  final double strokeWidth;
  final Color strokeColor;
  MaskPainter(
    this.maskWindow,
    this.strokeWidth,
    this.strokeColor,
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

    final Paint windowParentPaint = Paint()
      ..shader =
          gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final Paint windowPaint = Paint()
      ..strokeWidth = strokeWidth
      ..color = strokeColor
      ..style = PaintingStyle.stroke;

    // Outer rectangle size and position
    Rect windowParent = Rect.fromLTWH(0, 0, size.width, size.height);

    // Inner rectangle size and position (smaller, inside the outer rectangle)
    final Size windowSize = maskWindow.getSize(size);
    final Offset windowOffset = maskWindow.getOffset(windowSize, size);

    final RRect window = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        windowOffset.dx,
        windowOffset.dy,
        windowSize.width,
        windowSize.height,
      ),
      Radius.circular(windowSize.width / 2),
    );

    // Clip path to exclude the inner rectangle
    Path path = Path()
      ..addRect(windowParent)
      ..addRRect(window);
    path.fillType = PathFillType.evenOdd;

    // Clip the canvas to exclude the inner rectangle
    canvas.clipPath(path);

    // Paint the outer area (excluding the inner rectangle)
    canvas.drawRect(windowParent, windowParentPaint);

    // Paint the inner rectangle
    canvas.drawRRect(window, windowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint unless the painter data changes
  }
}
