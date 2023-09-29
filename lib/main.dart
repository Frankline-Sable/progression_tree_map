import 'package:flutter/material.dart';

import 'src/classes/nodes_placement.dart';
import 'src/classes/tree_node.dart';
import 'src/progression_tree_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progression TreeMap',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProgressionTreeHome(),
    );
  }
}

class ProgressionTreeHome extends StatefulWidget {
  const ProgressionTreeHome({super.key});

  @override
  State<ProgressionTreeHome> createState() => _ProgressionTreeHomeState();
}

class _ProgressionTreeHomeState extends State<ProgressionTreeHome> {
  @override
  Widget build(BuildContext context) {
    Map<TreeNode?, List<TreeNode>> nodes = {
      TreeNode(): [
        TreeNode(nodes: [
          const TreeNode(),
          TreeNode(
              size: 30,
              child: Container(
                child: const Text(
                  '12',
                  style: TextStyle(color: Colors.black, fontSize: 8),
                ),
              ),
              nodes: [
                const TreeNode(
                    nodes: [TreeNode(), TreeNode(), TreeNode(), TreeNode()])
              ]),
          const TreeNode(nodes: [TreeNode(), TreeNode()]),
        ]),
        TreeNode(
            partnerWidgetOffset: Offset(10, 20),
            partnerWidget: Text(
              "Together",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0,
                  color: Colors.black),
            ),
            nodes: [
              TreeNode(nodes: [
                TreeNode(nodes: [
                  TreeNode(nodes: [
                    TreeNode(nodes: [
                      TreeNode(),
                    ]),
                  ]),
                ]),
                TreeNode(),
              ]),
            ]),
        TreeNode(nodes: [
          TreeNode(),
          TreeNode(nodes: [
            TreeNode(),
            TreeNode(),
            TreeNode(nodes: [
              TreeNode(nodes: [
                TreeNode(),
              ]),
            ]),
          ]),
        ]),
        const TreeNode(nodes: [TreeNode()]),
      ]
    };
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Progression TreeMap Demo"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ..._treeMapWithGradient(nodes),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _treeMapWithGradient(nodes) => [
        Text(
          "Together",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              letterSpacing: 0,
              color: Colors.black),
        ),
        SizedBox(
          width: 400,
          height: 400,
          child: ProgressionTreeMap(
            treeNodes: nodes,
            spacingFactor: 1.0,
            circleBoundaryPaintingStyle: PaintingStyle.fill,
            circleBoundaryColor: Colors.red,
            nodePlacement: NodesPlacement.border,
            nodeSeparationAngleFac: 1.2,
            globalNodeSize: 20,
            centerNodeSize: 40,
            linesStartFromOrigin: false,
            linesStrokeWidth: 3,
            nodeDecoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.green, Colors.green.shade700],
                )),
          ),
        )
      ];
}
