import 'dart:async';

import 'package:flutter/material.dart';
import 'package:slidertest/custom_paint/mask.dart';
import 'package:slidertest/custom_paint/mask_window.dart';
import 'package:slidertest/dot_animation/jumping_dots.dart';
import 'package:slidertest/progressbar/square_progressbar.dart';

const bg = Color(0xFF5B6355);
const clearColor = Colors.transparent;

void main() {
  runApp(const JumpingDotsApp());
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
    final maskWindow = MaskWindow(
      aspectRatio: 0.73,
      widthFactor: 0.7,
      statusbarHeight: MediaQuery.of(context).padding.top,
      toolbarHeight: kToolbarHeight,
    );
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
              child: Image.asset(
            "assets/image/demo.jpeg",
            fit: BoxFit.fill,
          )),
          SizedBox.expand(
            child: Mask(maskWindow: maskWindow),
          ),
          ScanProgressBar(
            maskWindow: maskWindow,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ScanProgressBar extends StatefulWidget {
  final MaskWindow maskWindow;
  const ScanProgressBar({
    super.key,
    required this.maskWindow,
  });

  @override
  State<ScanProgressBar> createState() => _ScanProgressBarState();
}

class _ScanProgressBarState extends State<ScanProgressBar> {
  int _secondsElapsed = 0;
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsElapsed < 60) {
        setState(() {
          _secondsElapsed = _secondsElapsed + 1;
        });
      } else {
        timer.cancel();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scrSize = MediaQuery.of(context).size;
    final windowSize = widget.maskWindow.getSize(scrSize);
    final offset = widget.maskWindow.getOffset(windowSize, scrSize);
    final progress = _secondsElapsed / 60;
    return Positioned(
      top: offset.dy,
      left: offset.dx,
      child: SquareProgressIndicator(
        value: progress,
        strokeWidth: 8.0,
        borderRadius: windowSize.width / 2,
        width: windowSize.width,
        height: windowSize.height,
        color: const Color(0xFFCC0066),
        strokeCap: StrokeCap.square,
        strokeAlign: SquareStrokeAlign.center,
      ),
    );
  }
}
