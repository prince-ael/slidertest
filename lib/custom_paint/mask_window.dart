import 'package:flutter/material.dart';

class MaskWindow {
  final double _aspectRatio;
  final double _widthFactor;

  final double _statusbarHeight;
  final double _toolbarHeight;

  MaskWindow({
    required double aspectRatio,
    required double widthFactor,
    double? statusbarHeight,
    double? toolbarHeight,
  })  : _aspectRatio = aspectRatio,
        _widthFactor = widthFactor,
        _statusbarHeight = statusbarHeight ?? 0,
        _toolbarHeight = toolbarHeight ?? 0;

  Size getSize(Size windowParentSize) {
    final innerRectWidth = windowParentSize.width * _widthFactor;
    final innerRectHeight = innerRectWidth / _aspectRatio;
    return Size(innerRectWidth, innerRectHeight);
  }

  Offset getOffset(Size windowSize, Size windowParentSize) {
    final windowParentHeight = windowParentSize.width / 0.75;
    final dx = (windowParentSize.width - windowSize.width) / 2;
    final dy = ((windowParentHeight - windowSize.height) / 2) +
        _statusbarHeight +
        _toolbarHeight;
    return Offset(dx, dy);
  }
}
