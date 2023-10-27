import 'package:flutter/material.dart';

/// This is the individual node that forms the tree
class TreeNode {
  /// The [Widget] the node contains
  final Widget? child;

  /// The children of the node
  final List<TreeNode> nodes;

  /// The offset of the node
  final Offset offset;

  /// The [Size] of the node
  final double? size;

  /// The angle to rotate the node
  final double angle;

  /// The position of the node in relation to the center node
  final int depth;

  /// Configures the node decoration
  final BoxDecoration? decoration;

  /// [Widget] that runs alongside the node
  final Widget? partnerWidget;

  /// The [Offset] of the [Widget] that runs alongside the node
  final Offset? partnerWidgetOffset;

  /// The popup widget to show when the node is tapped
  final Widget? popUpWidget;

  const TreeNode(
      {this.child,
      this.nodes = const [],
      this.offset = Offset.zero,
      this.angle = 0,
      this.depth = 0,
      this.decoration,
      this.partnerWidget,
      this.partnerWidgetOffset,
      this.size,
      this.popUpWidget});

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
      BoxDecoration? decoration,
      Widget? popUpWidget}) {
    return TreeNode(
        child: child ?? this.child,
        nodes: nodes ?? this.nodes,
        depth: depth ?? this.depth,
        offset: offset ?? this.offset,
        size: size ?? this.size,
        partnerWidget: partnerWidget ?? this.partnerWidget,
        partnerWidgetOffset: partnerWidgetOffset ?? this.partnerWidgetOffset,
        angle: angle ?? this.angle,
        decoration: decoration ?? this.decoration,
        popUpWidget: popUpWidget ?? this.popUpWidget);
  }
}
