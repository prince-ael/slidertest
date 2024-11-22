import 'package:flutter/material.dart';
import 'package:slidertest/main.dart';

class SimpleStupidMask extends StatelessWidget {
  const SimpleStupidMask({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: bg,
          width: 100,
          height: 100,
        ),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.red),
          ),
        ),
        Container(
          color: bg,
          width: 100,
          height: 100,
        ),
      ],
    );
  }
}
