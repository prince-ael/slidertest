import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/material.dart';

class MySlider extends StatelessWidget {
  const MySlider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularSeekBar(
        width: double.infinity,
        height: 250,
        progress: 40,
        barWidth: 8,
        startAngle: 90,
        sweepAngle: 360,
        strokeCap: StrokeCap.butt,
        progressColor: Colors.blue,
        innerThumbRadius: 5,
        innerThumbStrokeWidth: 3,
        innerThumbColor: Colors.white,
        outerThumbRadius: 5,
        outerThumbStrokeWidth: 10,
        outerThumbColor: Colors.blueAccent,
        animation: true,
      ),
    );
    // return Center(
    //   child: SliderTheme(
    //     data: SliderThemeData(
    //       thumbShape: CustomThumb(),

    //       // trackShape: CylindricalSliderTrack(),
    //     ),
    //     child: Slider(
    //       min: 0,
    //       max: 60,
    //       value: 25,
    //       onChanged: (val) {},
    //     ),
    //   ),
    // );
  }
}

class CustomThumb extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(50, 50);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final Paint paint = Paint()..color = sliderTheme.thumbColor ?? Colors.black;

    // Draw a circle for the thumb
    canvas.drawCircle(center, 20, paint);

    // Set up text style and paint
    final TextSpan span = TextSpan(
      text: '${value * 100}'.substring(0, 2), // Display the slider value
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );

    final TextPainter textPainter = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: double.infinity);

    // Position the text at the center of the thumb
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }
}

const double trackHeight = 50;
const double trackWidth = 60;
const double trackRadius = 30;

class CylindricalSliderTrack extends SliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = true,
    bool isDiscrete = true,
  }) {
    // Return the rect for the track
    return Rect.fromLTWH(
      parentBox.paintBounds.left,
      parentBox.paintBounds.top,
      trackWidth,
      trackHeight,
    );
  }

  @override
  void paint(PaintingContext context, Offset offset,
      {required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required Animation<double> enableAnimation,
      required Offset thumbCenter,
      Offset? secondaryOffset,
      bool isEnabled = true,
      bool isDiscrete = true,
      required TextDirection textDirection}) {
    final Canvas canvas = context.canvas;

    // Define the track height and radius

    final Paint paint = Paint()
      ..color = sliderTheme.inactiveTrackColor!
      ..style = PaintingStyle.fill;

    // Draw the inactive track as a cylindrical shape
    final Rect trackRect =
        Rect.fromLTWH(offset.dx, offset.dy, trackWidth, trackHeight);
    canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, const Radius.circular(trackWidth / 2)),
      paint,
    );

    // Draw the active part of the track
    const double activeTrackWidth = (trackWidth * 1);
    paint.color = sliderTheme.activeTrackColor!;
    final Rect activeTrackRect = Rect.fromLTWH(
      offset.dx,
      offset.dy - trackRadius,
      activeTrackWidth,
      trackHeight,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          activeTrackRect, const Radius.circular(trackRadius)),
      paint,
    );
  }
}
