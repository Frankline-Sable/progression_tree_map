import 'package:flutter/material.dart';
import '../../progression_tree_map.dart';
import 'arrow_painter.dart';
import '../classes/tree_node.dart';

class PopUpWidget extends StatelessWidget {
  const PopUpWidget({super.key, required this.popUpNode});

  final TreeNode popUpNode;

  @override
  Widget build(BuildContext context) {
    final double x = popUpNode.offset.dx;
    final double y = popUpNode.offset.dy + (popUpNode.size ?? 0) / 1.5;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
                top: y + 24,
                left: x - 64,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 2.0,
                            color: Colors.black12,
                            spreadRadius: 2),
                      ]),
                  child: popUpNode.popUpWidget,
                )),
            Positioned(
              top: y,
              left: x + 10,
              child: CustomPaint(
                painter: ArrowPainter(),
                size: viewportConstraints.smallest,
              ),
            ),
          ],
        );
      },
    );
  }
}
