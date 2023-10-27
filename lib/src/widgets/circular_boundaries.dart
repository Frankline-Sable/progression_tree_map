import 'package:flutter/material.dart';

class CircularBoundaries extends CustomPainter {
  CircularBoundaries(
      {required this.radius,
      required this.color,
      this.paintingStyle = PaintingStyle.stroke,
      this.strokeWidth = 1});

  final double radius;
  final double strokeWidth;
  final Color color;
  final PaintingStyle paintingStyle;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    final Offset center = size.center(Offset.zero);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
