import 'package:flutter/material.dart';

class CircleClipPath extends StatelessWidget {
  const CircleClipPath({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CircleClipper(),
      child: Container(
        width: 300,
        height: 300,
        color: Colors.transparent, // Outer area color
      ),
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Draw the whole rectangular path
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
   

    // Cut out a circular path in the middle
    final circleCenter = Offset(size.width / 2, size.height / 2);
    final circleRadius = size.width / 4;
    path.addOval(Rect.fromCircle(center: circleCenter, radius: circleRadius));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}


// class CircleClipper2 extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     // Define the circular hole at the center
//     path.addCircle(Offset(size.width / 2, size.height / 2), 100); // 100 is the radius of the circle
//     path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
//     path.fillType = PathFillType.evenOdd;
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }