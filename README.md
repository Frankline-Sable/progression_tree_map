## Progression TreeMap

Progression TreeMap is an open source Flutter package, that is used to display a tree list, to the ui, you can use it to interpret any complex tree or progression map to the ui of your app and customize it to your liking.


## Example Usages:



## Add Dependency

Install and import the package. Then just customize its parameters.

```yaml
dependencies:
  flutter:
    sdk: flutter
  progression_tree_map: ^0.5.0
```

## How to use


Create a list of nodes, as well as its sublist as below:
```dart
  Map<TreeNode?, List<TreeNode>> nodes =
{TreeNode():[
  TreeNode(nodes: [
    TreeNode(),
    TreeNode(nodes: [
      TreeNode(nodes: [
        TreeNode(nodes: [
          TreeNode(), TreeNode()])
      ])])])]
};
```

<img src="https://raw.githubusercontent.com/Frankline-Sable/progression_tree_map/e6e65d3ec7efd7171c5ca107941150219ea62eca/screenshots/example_tree.png" alt="Colored Nodes & Outlines" width="300"/>


---
## Screenshots & Implementations

### Example 1 - Colored Nodes & Outlines

<img src="https://raw.githubusercontent.com/Frankline-Sable/progression_tree_map/main/screenshots/tNodeColoredNodesAndOutlines.png" alt="Colored Nodes & Outlines" width="300"/>

```dart
ProgressionTreeMap(
treeNodes: nodes,
circleBoundaryColor: Colors.grey.shade300,
circleBoundaryShade: false,
nodeSeparationAngleFac: 1.3,
globalNodeSize: 20,
centerNodeSize: 40,
circleBoundaryStrokeWidth: 1.5,
linesStrokeWidth: 2,
linesStrokeColor: Colors.blueAccent,
nodeDecoration: const BoxDecoration(
shape: BoxShape.circle, color: Colors.blueAccent))
```
<br>

### Example 2 - Colored Nodes & Icons

<img src="https://raw.githubusercontent.com/Frankline-Sable/progression_tree_map/main/screenshots/tNodeColoredNodesAndIcons.png" alt="Colored Nodes & Outlines" width="300"/>

```dart
ProgressionTreeMap(
treeNodes: nodes,
circleBoundaryPaintingStyle: PaintingStyle.fill,
circleBoundaryColor: Colors.deepPurpleAccent,
nodePlacement: NodesPlacement.border,
nodeSeparationAngleFac: 3,
globalNodeSize: 30,
centerNodeSize: 60,
linesStartFromOrigin: true,
linesStrokeWidth: 2,
linesStrokeColor: Colors.cyanAccent,
nodeDecoration: const BoxDecoration(
shape: BoxShape.circle, color: Colors.cyanAccent))
```
<br>

### Example 3 - Glowing Nodes & Background Text

<img src="https://raw.githubusercontent.com/Frankline-Sable/progression_tree_map/main/screenshots/tNodeGlowingNodesBackgroundTexts.png" alt="Glowing Nodes & Background Text" width="300"/>

```dart
ProgressionTreeMap(
treeNodes: nodes,
circleBoundaryPaintingStyle: PaintingStyle.fill,
circleBoundaryColor: Colors.red,
nodePlacement: NodesPlacement.centerOut,
nodeSeparationAngleFac: 1.2,
globalNodeSize: 20,
centerNodeSize: 40,
linesStrokeWidth: 3,
nodeDecoration: const BoxDecoration(
shape: BoxShape.circle, gradient:
RadialGradient(
colors: [Colors.white, Colors.white30])))
```
<br>

### Example 4 - Collection & Ui Items

<img src="https://raw.githubusercontent.com/Frankline-Sable/progression_tree_map/main/screenshots/collectionAndUiItems.png" alt="Collection  & Ui Items" width="300"/>

```dart
ProgressionTreeMap(
treeNodes: nodes,
circleBoundaryPaintingStyle: PaintingStyle.fill,
circleBoundaryColor: Colors.deepOrangeAccent,
nodePlacement: NodesPlacement.centerIn,
nodeSeparationAngleFac: 1.3,
centerNodeSize: 60,
linesStartFromOrigin: false,
linesStrokeWidth: 3,
linesStrokeColor: Colors.white10)),
```

## More info

A TreeNode can have several properties, you can customize each individually as below:

```dart
TreeNode(
child: Icon(
Icons.restaurant_menu,
color: Colors.black,
size: 32,
),
decoration:
BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
size: 30)
```

Must be added to ProgressionTreeMap as a map of **`Map<TreeNode?, List<TreeNode>>`**

```dart
Map<TreeNode?, List<TreeNode>>  nodes =
{
  const TreeNode(): [
    const TreeNode(nodes: [
      TreeNode(
        child: Icon(Icons.lunch_dining_rounded),
      ),
      TreeNode(
        child: Icon(Icons.ramen_dining),
      )
    ])]
}
```

Adding to the tree as follows:
```dart
ProgressionTreeMap(
treeNodes: nodes
),
```

Very customizable, feel free to customize however you like! 😎
