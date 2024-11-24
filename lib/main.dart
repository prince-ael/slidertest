import 'package:flutter/material.dart';
import 'package:slidertest/custom_paint/mask.dart';
import 'package:slidertest/custom_paint/mask_window.dart';

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
        ],
      ),
    );
  }
}

class ScanProgressBar extends StatelessWidget {
  final MaskWindow maskWindow;
  const ScanProgressBar({
    super.key,
    required this.maskWindow,
  });

  @override
  Widget build(BuildContext context) {
    final scrSize = MediaQuery.of(context).size;
    final windowSize = maskWindow.getSize(scrSize);
    final offset = maskWindow.getOffset(windowSize, scrSize);
    return Positioned(
      top: offset.dy,
      left: offset.dx,
      child: Container(
        height: windowSize.height,
        width: windowSize.width,
        decoration: BoxDecoration(
          border: Border.all(
              width: 4.0,
              color: Colors.red,
              strokeAlign: BorderSide.strokeAlignOutside),
          borderRadius: BorderRadius.all(
            Radius.circular(windowSize.width / 2),
          ),
        ),
      ),
    );
  }
}
