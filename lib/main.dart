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
  // Colored Progression TreeMap
  Map<TreeNode?, List<TreeNode>> get coloredProgressionTreeMapNodes => {
        const TreeNode(): [
          const TreeNode(nodes: [
            TreeNode(),
            TreeNode(
                size: 30,
                child: Text(
                  'A',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                nodes: [
                  TreeNode(
                      nodes: [TreeNode(), TreeNode(), TreeNode(), TreeNode()])
                ]),
            TreeNode(nodes: [TreeNode(), TreeNode()]),
          ]),
          const TreeNode(
              partnerWidgetOffset: Offset(14, 18),
              partnerWidget: Text(
                "GOING UP",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
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
          const TreeNode(nodes: [
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
          const TreeNode(
              partnerWidgetOffset: Offset(-120, -20),
              partnerWidget: Text(
                "COMING DOWN",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0,
                    color: Colors.black),
              ),
              nodes: [TreeNode()]),
        ]
      };
  
  // Progression TreeMap with  widgets(texts/images)
  Map<TreeNode?, List<TreeNode>> get progressionTreeMapWithWidgetsNodes => {
        const TreeNode(): [
          const TreeNode(nodes: [
            TreeNode( child: Text(
              'A',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),),
            TreeNode(
                size: 30,
                child: Text(
                  'B',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                nodes: [
                  TreeNode(
                      nodes: [TreeNode(), TreeNode(), TreeNode(), TreeNode()])
                ]),
            TreeNode(
                child: Text(
                  'C',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                nodes: [TreeNode(), TreeNode()]),
          ]),
          const TreeNode(
              partnerWidgetOffset: Offset(14, 18),
              partnerWidget: Text(
                "GOING UP",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0,
                    color: Colors.black),
              ),
              nodes: [
                TreeNode(
                    child: Icon(Icons.offline_bolt,color: Colors.black, size: 16,),
                    decoration: null,
                    nodes: [
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
          const TreeNode(nodes: [
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
          const TreeNode(
              partnerWidgetOffset: Offset(-120, -20),
              partnerWidget: Text(
                "COMING DOWN",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0,
                    color: Colors.black),
              ),
              nodes: [TreeNode()]),
        ]
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Progression TreeMap Demo"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ..._coloredProgressionTreeMap(coloredProgressionTreeMapNodes),

            ..._outlinedProgressionTreeMap(coloredProgressionTreeMapNodes),
            ..._ProgressionTreeMapWithWidgets(progressionTreeMapWithWidgetsNodes),
          ],
        ),
      ),
    );
  }

  List<Widget> _coloredProgressionTreeMap(nodes) => [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: const Text(
            "Colored Progression Tree Map",
            maxLines: 1,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
                color: Colors.black),
          ),
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
            linesStartFromOrigin: true,
            linesStrokeWidth: 3,
            nodeDecoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.green, Colors.green.shade700],
                )),
          ),
        )
      ];
  List<Widget> _outlinedProgressionTreeMap(nodes) => [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: const Text(
            "Colored Progression Tree Map",
            maxLines: 1,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
                color: Colors.black),
          ),
        ),
        SizedBox(
          width: 400,
          height: 400,
          child: ProgressionTreeMap(
            treeNodes: nodes,
            spacingFactor: 1.0,
            circleBoundaryPaintingStyle: PaintingStyle.stroke,
            circleBoundaryColor: Colors.grey,
            nodePlacement: NodesPlacement.border,
            nodeSeparationAngleFac: 1.2,
            globalNodeSize: 20,
            centerNodeSize: 40,
            linesStartFromOrigin: false,
            linesStrokeWidth: 2,
            linesStrokeColor: Colors.black,
            nodeDecoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.red, Colors.red.shade700],
                )),
          ),
        )
      ];

  List<Widget> _ProgressionTreeMapWithWidgets(nodes) => [
    Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: const Text(
        "Progression Tree Map Text",
        maxLines: 1,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
            color: Colors.black),
      ),
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
        linesStartFromOrigin: true,
        linesStrokeWidth: 3,
        nodeDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white),
      ),
    )
  ];
}
