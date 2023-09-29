import 'tree_node.dart';

class UiNode {
  final TreeNode? start;
  final TreeNode? finish;

  const UiNode({this.start, this.finish});

  UiNode copyWith({TreeNode? start, TreeNode? finish}) {
    return UiNode(start: start ?? this.start, finish: finish ?? this.finish);
  }
}
