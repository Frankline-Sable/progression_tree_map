import 'package:flutter/material.dart';

class TreeNode {
  final Widget? child;
  final List<TreeNode> nodes;
  final Offset offset;
  final double? size;
  final double angle;
  final int depth;
  final BoxDecoration? decoration;
  final Widget? partnerWidget;
  final Offset? partnerWidgetOffset;

  const TreeNode(
      {this.child,
      this.nodes = const [],
      this.offset = Offset.zero,
      this.angle = 0,
      this.depth = 0,
      this.decoration,
      this.partnerWidget,
      this.partnerWidgetOffset,
      this.size});

  TreeNode copyWith(
      {Widget? child,
      List<TreeNode>? nodes,
      Offset? offset,
      String? id,
      int? depth,
      double? size,
      double? angle,
      Widget? partnerWidget,
      Offset? partnerWidgetOffset,
      BoxDecoration? decoration}) {
    return TreeNode(
        child: child ?? this.child,
        nodes: nodes ?? this.nodes,
        depth: depth ?? this.depth,
        offset: offset ?? this.offset,
        size: size ?? this.size,
        partnerWidget: partnerWidget ?? this.partnerWidget,
        partnerWidgetOffset: partnerWidgetOffset ?? this.partnerWidgetOffset,
        angle: angle ?? this.angle,
        decoration: decoration ?? this.decoration);
  }
}
