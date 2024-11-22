To use gradients in a `CustomPainter` in Flutter, you'll be drawing on a `Canvas`, and you can apply gradients to fill shapes or backgrounds.

### Example: Drawing a Gradient Circle using `CustomPainter`

In this example, we will use `LinearGradient` to paint a gradient circle on the canvas.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Gradient in CustomPainter")),
        body: CustomPaint(
          size: Size(double.infinity, double.infinity),  // Full screen size
          painter: GradientPainter(),
        ),
      ),
    );
  }
}

class GradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Create a LinearGradient
    final gradient = LinearGradient(
      colors: [Colors.blue, Colors.purple],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    // Create a Paint object to hold the gradient
    final paint = Paint()..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Draw a circle with the gradient
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 100, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;  // You can return true if the painting needs to be updated
  }
}
```

### Explanation:
1. **`LinearGradient`**: Defines a gradient that will start from the top-left and end at the bottom-right, blending colors from blue to purple.
2. **`Paint`**: A `Paint` object is used to define the visual style (like color or gradient). We assign the gradient to the `shader` property of the `Paint`.
3. **`Canvas.drawCircle`**: Draws a circle at the center of the canvas with a radius of 100, using the gradient applied in the `Paint`.

### Example: Using Radial Gradient in `CustomPainter`

If you want a radial gradient instead of a linear one, here’s how to do it:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Radial Gradient in CustomPainter")),
        body: CustomPaint(
          size: Size(double.infinity, double.infinity),
          painter: RadialGradientPainter(),
        ),
      ),
    );
  }
}

class RadialGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Create a RadialGradient
    final gradient = RadialGradient(
      colors: [Colors.orange, Colors.red],
      center: Alignment.center,
      radius: 0.5,
    );

    // Create a Paint object to hold the gradient
    final paint = Paint()..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Draw a rectangle with the radial gradient
    canvas.drawRect(Rect.fromLTWH(100, 100, 200, 200), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
```

### Key Concepts:
- **RadialGradient**: Starts from the center and radiates outward. You can customize the center and the radius.
- **`createShader`**: Used to apply the gradient to a shape (like a circle or rectangle). The `Rect.fromLTWH` method defines the bounds of the gradient (you can tweak the size as needed).

### Example: Sweep Gradient in `CustomPainter`

A sweep gradient works well for circular or arc-like effects. Here's how you can apply it:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Sweep Gradient in CustomPainter")),
        body: CustomPaint(
          size: Size(double.infinity, double.infinity),
          painter: SweepGradientPainter(),
        ),
      ),
    );
  }
}

class SweepGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Create a SweepGradient
    final gradient = SweepGradient(
      colors: [Colors.blue, Colors.purple, Colors.red, Colors.yellow],
      startAngle: 0.0,
      endAngle: 3.14, // Half circle
    );

    // Create a Paint object to hold the gradient
    final paint = Paint()..shader = gradient.createShader(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 200));

    // Draw a circle with the sweep gradient
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 200, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
```

### Explanation:
- **SweepGradient**: Creates a gradient that rotates around a center point, creating an effect similar to a pie chart or color wheel.
- **`Rect.fromCircle`**: Defines the bounds of the circle where the gradient will be applied.

---

These are just a few examples of using gradients in `CustomPainter`. The flexibility of `CustomPainter` allows you to create complex shapes and gradients in Flutter with control over how you draw and apply colors.