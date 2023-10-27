import 'package:flutter/material.dart';

class BoundaryClipper extends CustomClipper<Path> {
  BoundaryClipper();

  @override
  Path getClip(Size size) {
    final double width = size.width;
    final Offset center = size.center(Offset.zero);

    final Path path = Path()
      ..addOval(Rect.fromCircle(center: center, radius: width / 2 + 20))
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
