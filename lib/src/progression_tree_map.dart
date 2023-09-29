import 'package:flutter/material.dart';
import 'circular_boundaries.dart';
import 'connecting_line.dart';
import 'classes/tree_node.dart';
import 'extensions/nums.dart';
import 'extensions/colors.dart';
import 'package:collection/collection.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math.dart' as vector;
import 'classes/nodes_placement.dart';
import 'boundary_clipper.dart';

class ProgressionTreeMap extends StatefulWidget {
  const ProgressionTreeMap(
      {super.key,
      required this.treeNodes,
      this.spacingFactor = 1.0,
      this.maxDepthToShow = 0,
      this.circleBoundaryColor = Colors.grey,
      this.circleBoundaryShade = true,
      this.circleBoundaryPaintingStyle = PaintingStyle.stroke,
      this.nodePlacement = NodesPlacement.border,
      this.nodeSeparationAngleFac = 1.0,
      this.globalNodeSize,
      this.centerNodeSize,
      this.linesStrokeColor = Colors.white,
      this.linesStrokeWidth = 1,
      this.linesStartFromOrigin,
      this.clipBehaviour = Clip.antiAlias,
      this.nodeDecoration =
          const BoxDecoration(color: Colors.white, shape: BoxShape.circle)});

  @override
  State<ProgressionTreeMap> createState() => _ProgressionTreeMapState();

  final Map<TreeNode?, List<TreeNode>> treeNodes;
  final double spacingFactor;
  final int maxDepthToShow;
  final Color circleBoundaryColor;
  final bool circleBoundaryShade;
  final PaintingStyle circleBoundaryPaintingStyle;
  final NodesPlacement nodePlacement;
  final double nodeSeparationAngleFac;
  final double? globalNodeSize;
  final double? centerNodeSize;
  final bool? linesStartFromOrigin;
  final Color linesStrokeColor;
  final double linesStrokeWidth;
  final BoxDecoration? nodeDecoration;
  final Clip clipBehaviour;
}

class _ProgressionTreeMapState extends State<ProgressionTreeMap> {
  final List<Map<NodeContainer, TreeNode>> _uiNodesRaw = [];
  List<Map<TreeNode, List<TreeNode>>> _uiNodesPrep = [];

  double _nodePositionFactor = 0;
  double _defaultNodeSize = 0;
  double _centerNodeSize = 0;
  bool _linesStartFromOrigin = true;

  TreeNode? _centerTreeNode;

  @override
  Widget build(BuildContext context) {
    final int treeNodeDepth = _treeNodeDepth(widget.treeNodes.values.first);
    final int nodeDepth = widget.maxDepthToShow > treeNodeDepth
        ? treeNodeDepth
        : (widget.maxDepthToShow < 1 ? treeNodeDepth : widget.maxDepthToShow);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      final double spacing =
          (viewportConstraints.maxWidth / nodeDepth) * widget.spacingFactor;

      _centerNodeSize = widget.centerNodeSize == null
          ? (spacing / 2)
          : widget.centerNodeSize!;
      _defaultNodeSize = widget.globalNodeSize == null
          ? _centerNodeSize / 2
          : widget.globalNodeSize!;

      _getNodePlacementFactor(spacing);

      _prepareUiNodes(
          widget.treeNodes.values.first, viewportConstraints, spacing);
      _centerTreeNode = widget.treeNodes.keys.first;

      _linesStartFromOrigin = widget.linesStartFromOrigin == null
          ? (_centerTreeNode == null ? false : true)
          : widget.linesStartFromOrigin!;

      return Center(
        child: SizedBox(
          width: viewportConstraints.maxWidth,
          height: viewportConstraints.maxHeight,
          child: ClipPath(
            clipper: BoundaryClipper(),
            clipBehavior: widget.clipBehaviour,
            child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  ...List.generate(nodeDepth, (index) {
                    final looper = nodeDepth - index;
                    return CustomPaint(
                      painter: CircularBoundaries(
                          radius: (looper * spacing) / 2,
                          strokeWidth: 5,
                          paintingStyle: widget.circleBoundaryPaintingStyle,
                          color: widget.circleBoundaryColor.tintOrShade(
                              widget.circleBoundaryShade
                                  ? ((100 * (looper / nodeDepth))
                                      .clampRange(min: 30, max: 0))
                                  : 0,
                              darken: false)),
                    );
                  }),
                  CustomPaint(
                    painter: ConnectingLine(
                        uiNodesPrep: _uiNodesPrep,
                        color: widget.linesStrokeColor,
                        strokeWidth: widget.linesStrokeWidth,
                        startFromCenter: _linesStartFromOrigin),
                    size: viewportConstraints.biggest,
                  ),
                  if (_centerTreeNode != null)
                    Container(
                      alignment: Alignment.center,
                      width: _centerNodeSize,
                      height: _centerNodeSize,
                      decoration:
                          _centerTreeNode!.decoration ?? widget.nodeDecoration,
                      child: _centerTreeNode!.child,
                    ),
                  ..._displayUiNodesWidgets(),
                ]),
          ),
        ),
      );
    });
  }

  int _treeNodeDepth(List<TreeNode> nodes) {
    Map<int, int> pathDepth = {};
    int getDepth(List<TreeNode> nodes) {
      nodes.forEachIndexed((index, node) {
        pathDepth[index] =
            1 + (pathDepth.containsKey(index) ? pathDepth[index]! : 0);
        if (node.nodes.isNotEmpty) {
          getDepth(node.nodes);
        }
      });
      return pathDepth.length;
    }

    return getDepth(nodes);
  }

  int _nodeDepth = 0;

  void _prepareUiNodes(List<TreeNode> treeNodes,
      BoxConstraints viewportConstraints, double spacing) {
    _uiNodesRaw.clear();
    _uiNodesPrep.clear();

    for (TreeNode tNode in treeNodes) {
      // Reset the depth of the index node
      _nodeDepth = 1;
      tNode = tNode.copyWith(
          depth: _nodeDepth, size: tNode.size ?? _defaultNodeSize);
      _nodeTraverse(tNode);
    }

    double baseAngle = 360 /
        _uiNodesRaw
            .where((uiR) =>
                uiR.keys.first.treeNode.depth == 1 &&
                uiR.keys.first.nodePosition == NodePosition.start)
            .length;
    int increment = 1;
    _uiNodesRaw.forEachIndexed((index, nodeMap) {
      // Filter only the end nodes
      List<Map<NodeContainer, TreeNode>> mUiNodesRaw = _uiNodesRaw
          .where((uiNode) =>
              uiNode.keys.first.nodePosition == NodePosition.end &&
              uiNode.keys.first.treeNode == nodeMap.keys.first.treeNode)
          .toList();

      if (nodeMap.keys.first.nodePosition == NodePosition.start) {
        TreeNode keyNode = nodeMap.keys.first.treeNode;
        if (keyNode.depth == 1) {
          keyNode = keyNode.copyWith(
              angle: baseAngle * increment,
              offset: Offset(
                ((viewportConstraints.maxWidth / 2 - (keyNode.size! / 2)) +
                    ((keyNode.depth * spacing / 2) - _nodePositionFactor) *
                        math.sin(vector.radians(baseAngle * increment))),
                ((viewportConstraints.maxHeight / 2 - (keyNode.size! / 2)) +
                    ((keyNode.depth * spacing / 2) - _nodePositionFactor) *
                        math.cos(vector.radians(baseAngle * increment))),
              ));
          increment++;
        }
        List<TreeNode> valueNodes =
            mUiNodesRaw.map((e) => e.values.first).toList();

        _uiNodesPrep.add({keyNode: valueNodes});
      }
    });
    //Loop depth
    int maxDepth = _uiNodesPrep.map((uiN) => uiN.keys.first.depth).max;
    List<Map<TreeNode, List<TreeNode>>> total = [];
    for (int depthCount = 1; depthCount <= maxDepth; depthCount++) {
      List<Map<TreeNode, List<TreeNode>>> mUiNodesPrepDepth = _uiNodesPrep
          .where((uiR) => uiR.keys.first.depth == depthCount)
          .mapIndexed((index3, mUnDepth) {
        TreeNode keyNode = mUnDepth.keys.first;
        List<TreeNode> valueNodes = mUnDepth.values.first;
        if (depthCount != 1) {
          // Other depth depends on the previous bias.
          Map<TreeNode, List<TreeNode>>? mp = total
              .firstWhereOrNull((uiP) => uiP.values.first.contains(keyNode));
          mp ??= _uiNodesPrep
              .where((uiP) => uiP.values.first.contains(keyNode))
              .first;

          mp.values.first.map((e) => e).forEachIndexed((ind, vNode) {
            double vnAngle = (mp!.keys.first.angle -
                (15 * widget.nodeSeparationAngleFac) * ind);
            if (vNode == keyNode) {
              keyNode = vNode.copyWith(
                  angle: vnAngle,
                  offset: Offset(
                    ((viewportConstraints.maxWidth / 2 - (vNode.size! / 2)) +
                        (((vNode.depth) * spacing / 2) - _nodePositionFactor) *
                            math.sin(vector.radians(vnAngle))),
                    ((viewportConstraints.maxHeight / 2 - (vNode.size! / 2)) +
                        (((vNode.depth) * spacing / 2) - _nodePositionFactor) *
                            math.cos(vector.radians(vnAngle))),
                  ));
            }
          });
        }

        mUnDepth = {keyNode: valueNodes};
        return mUnDepth;
      }).toList();
      total.addAll(mUiNodesPrepDepth);
    }
    _uiNodesPrep = total;

    _uiNodesPrep = _uiNodesPrep.mapIndexed((index, uiNode) {
      TreeNode keyNode = uiNode.keys.first;
      List<TreeNode> valueNodes =
          uiNode.values.first.map((e) => e).mapIndexed((ind, vNode) {
        double vnAngle =
            (keyNode.angle - (15 * widget.nodeSeparationAngleFac) * ind);
        return vNode.copyWith(
            angle: vnAngle,
            offset: Offset(
              ((viewportConstraints.maxWidth / 2 - (vNode.size! / 2)) +
                  (((vNode.depth) * spacing / 2) - _nodePositionFactor) *
                      math.sin(vector.radians(vnAngle))),
              ((viewportConstraints.maxHeight / 2 - (vNode.size! / 2)) +
                  (((vNode.depth) * spacing / 2) - _nodePositionFactor) *
                      math.cos(vector.radians(vnAngle))),
            ));
      }).toList();

      return {keyNode: valueNodes};
    }).toList();
  }

  void _nodeTraverse(TreeNode tNode) {
    _uiNodesRaw.add({NodeContainer(tNode, NodePosition.start): tNode});
    tNode.nodes.forEachIndexed((index, tNode2) {
      _nodeDepth = tNode.depth + 1;
      tNode2 = tNode2.copyWith(
          depth: _nodeDepth, size: tNode2.size ?? _defaultNodeSize);

      _uiNodesRaw.add({NodeContainer(tNode, NodePosition.end): tNode2});
      if (tNode2.nodes.isNotEmpty) {
        _nodeTraverse(tNode2);
      }
    });
  }

  List<Widget> _displayUiNodesWidgets() {
    List<Widget> w = [];
    for (Map<TreeNode, List<TreeNode>> uiN in _uiNodesPrep) {
      if (uiN.keys.first.partnerWidget != null) {
        Offset offset = uiN.keys.first.partnerWidgetOffset ??
            Offset(uiN.keys.first.size ?? 0, uiN.keys.first.size ?? 0);
        w.add(Positioned(
            top: uiN.keys.first.offset.dy - offset.dy,
            left: uiN.keys.first.offset.dx + offset.dx,
            child: uiN.keys.first.partnerWidget!));
      }

      w.add(Positioned(
        top: uiN.keys.first.offset.dy,
        left: uiN.keys.first.offset.dx,
        child: Container(
            alignment: Alignment.center,
            width: uiN.keys.first.size,
            height: uiN.keys.first.size,
            decoration: uiN.keys.first.decoration ?? widget.nodeDecoration,
            child: uiN.keys.first.child),
      ));

      for (TreeNode tNode in uiN.values.first) {
        if (tNode.partnerWidget != null) {
          Offset offset = tNode.partnerWidgetOffset ??
              Offset((tNode.size ?? 0), (tNode.size ?? 0));
          w.add(Positioned(
              top: offset.dy - offset.dy,
              left: offset.dx + offset.dx,
              child: tNode.partnerWidget!));
        }
        w.add(Positioned(
          top: tNode.offset.dy,
          left: tNode.offset.dx,
          child: Container(
              alignment: Alignment.center,
              width: tNode.size,
              height: tNode.size,
              decoration: tNode.decoration ?? widget.nodeDecoration,
              child: tNode.child),
        ));
      }
    }
    return w;
  }

  void _getNodePlacementFactor(double spacing) {
    switch (widget.nodePlacement) {
      case NodesPlacement.centerIn:
        _nodePositionFactor = (spacing / 2) / 2;
      case NodesPlacement.centerOut:
        _nodePositionFactor = -(spacing / 2) / 2;
      default:
        _nodePositionFactor = 0;
    }
  }
}

class NodeContainer {
  TreeNode treeNode;
  NodePosition nodePosition;

  NodeContainer(this.treeNode, this.nodePosition);
}

enum NodePosition { start, end }
