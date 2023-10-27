import 'package:flutter/material.dart';

class ArrowPainter extends CustomPainter {
  ArrowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(-16, 32)
      ..lineTo(16, 32)
      ..close();
    canvas.drawShadow(
        Path()
          ..moveTo(0, -3)
          ..lineTo(-16, 23)
          ..lineTo(16, 23)
          ..close(),
        Colors.black,
        2.0,
        true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) {
    return true;
  }
}
