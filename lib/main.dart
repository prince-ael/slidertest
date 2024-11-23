import 'package:flutter/material.dart';
import 'package:slidertest/custom_paint/mask.dart';

const bg = Color(0xFF5B6355);
const clearColor = Colors.transparent;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            "assets/image/demo.jpeg",
            fit: BoxFit.fill,
          )),
          const Positioned.fill(
            child: Mask(
              widthFactor: 0.7,
              aspectRatio: 0.73,
            ),
          ),
        ],
      ),
    );
  }
}
