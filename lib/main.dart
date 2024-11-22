import 'package:flutter/material.dart';
import 'package:slidertest/custom_paint/rounded_rect.dart';

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
          Positioned.fill(child: Image.asset("assets/image/demo.jpeg", fit: BoxFit.fill,)),
          const Positioned.fill(child: RoundedRectWidget()),
        ],
      ),
    );
  }
}

class MyRow extends StatelessWidget {
  final bool isCenter;
  const MyRow({
    super.key,
    this.isCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: bg,
          ),
        ),
        isCenter
            ? Container(
                width: 200,
                height: 300,
                decoration: BoxDecoration(
                    color: isCenter ? clearColor : bg,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(100.0))),
              )
            : Expanded(
                child: Container(
                  color: bg,
                ),
              ),
        Expanded(
          child: Container(
            color: bg,
          ),
        )
      ],
    );
  }
}

// What are the options i see
// 1. Custom paint
// 2. ClipPath
// 3. Masking library