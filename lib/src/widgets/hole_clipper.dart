import 'package:flutter/material.dart';

class HoleClipper extends CustomClipper<Path> {
  HoleClipper({required this.radius});

  final double radius;

  @override
  Path getClip(Size size) {
    final Rect rect = Rect.fromLTRB(0, 0, size.width, size.height);
    final Offset center = rect.center;
    var path = Path();
    path = Path.combine(
      PathOperation.difference,
      Path()..addOval(Rect.fromCircle(center: center, radius: size.width)),
      Path()
        ..addOval(Rect.fromCircle(center: center, radius: radius))
        ..close(),
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
