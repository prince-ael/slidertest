import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';

class JumpingDotsApp extends StatelessWidget {
  const JumpingDotsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyJumpingDotPage(title: 'Jumping Dot Demo '),
    );
  }
}

class MyJumpingDotPage extends StatelessWidget {
  final String title;

  const MyJumpingDotPage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: JumpingDots(
          color: Colors.black,
          innerPadding: 8,
          radius: 10,
          numberOfDots: 2,
        ),
      ),
    );
  }
}
