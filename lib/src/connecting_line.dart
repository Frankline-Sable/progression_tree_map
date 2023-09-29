import 'package:flutter/material.dart';
import 'classes/tree_node.dart';

class ConnectingLine extends CustomPainter {
  ConnectingLine(
      {required this.uiNodesPrep,
      required this.color,
      required this.strokeWidth,
      required this.startFromCenter});

  final List<Map<TreeNode, List<TreeNode>>> uiNodesPrep;
  final double strokeWidth;
  final Color color;
  final bool startFromCenter;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path();

    final Offset center = size.center(Offset.zero);

    for (Map<TreeNode, List<TreeNode>> uiN in uiNodesPrep) {
      TreeNode keyNode = uiN.keys.first;
      if (startFromCenter && keyNode.depth == 1) {
        path.moveTo(center.dx, center.dy);
        path.lineTo(keyNode.offset.dx + (keyNode.size!) / 2,
            keyNode.offset.dy + (keyNode.size!) / 2);
      }
      for (TreeNode tNode in uiN.values.first) {
        path.moveTo(keyNode.offset.dx + (keyNode.size!) / 2,
            keyNode.offset.dy + (keyNode.size!) / 2);
        TreeNode valueNode = tNode;
        path.lineTo(valueNode.offset.dx + (valueNode.size!) / 2,
            valueNode.offset.dy + (valueNode.size!) / 2);
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
