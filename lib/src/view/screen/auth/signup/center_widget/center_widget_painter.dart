import 'dart:ui';

import 'package:flutter/material.dart';

class CenterWidgetPainter extends CustomPainter {
  final Path path;

  const CenterWidgetPainter({required this.path});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30
      ..imageFilter = ImageFilter.blur(sigmaY: 15, sigmaX: 15)
      ..color = Colors.black26;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CenterWidgetPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(CenterWidgetPainter oldDelegate) => false;
}
