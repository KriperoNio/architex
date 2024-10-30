import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/widgets/ar_view.dart';

import 'package:vector_math/vector_math_64.dart';
import 'package:flutter/material.dart';

// Подж
class ARScreen extends StatefulWidget {
  final int selectedModelIndex;

  const ARScreen({super.key, required this.selectedModelIndex});

  @override
  State<ARScreen> createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;
  List<ARNode> nodes = [];
  List<ARPlaneAnchor> anchors = [];

  @override
  void dispose() {
    super.dispose();
    arSessionManager?.dispose();
  }

  // Испрваленный метод для удаления всех объектов и якорей
  Future<void> onRemoveEverything() async {
    final anchorsCopy = List<ARPlaneAnchor>.from(anchors);
    for (var anchor in anchorsCopy) {
      await arAnchorManager?.removeAnchor(anchor);
    }
    anchors.clear();
    nodes.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ARView(
          onARViewCreated: onARViewCreated,
          planeDetectionConfig: PlaneDetectionConfig.horizontal,
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: onRemoveEverything,
                child: const Text(
                  "Remove Everything",
                  style: TextStyle(color: Color(0xff902020)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onARViewCreated(
    ARSessionManager arSessionManager,
    ARObjectManager arObjectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager,
  ) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager?.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
          showWorldOrigin: true,
        );
    this.arObjectManager?.onInitialize();

    this.arSessionManager?.onPlaneOrPointTap = onPlaneOrPointTapped;
    //this.arObjectManager?.onNodeTap = onNodeTapped;
  }

  // Добавляем модель на якорь не очищая предыдущие модели
  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    if (hitTestResults.isNotEmpty) {
      var singleHitTestResult = hitTestResults.firstWhere(
        (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane,
        orElse: () => hitTestResults.first,
      );

      // Создаем новый якорь и добавляем модель на него
      var newAnchor =
          ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
      bool? didAddAnchor = await arAnchorManager?.addAnchor(newAnchor);

      if (didAddAnchor ?? false) {
        anchors.add(newAnchor);
        await _addModelToAnchor(newAnchor, widget.selectedModelIndex);
      } else {
        arSessionManager?.onError("Adding Anchor failed");
      }
    }
  }

  // Метод добавения модели к заданному якорю
  Future<void> _addModelToAnchor(ARPlaneAnchor anchor, int modelIndex) async {
    var newNode = ARNode(
      type: NodeType.localGLTF2,
      uri: "assets/models/model_$modelIndex/model.gltf",
      scale: Vector3(6, 6, 6),
      position: Vector3(0.0, 0.0, 0.0),
      rotation: Vector4(1.0, 0.0, 0.0, 0.0),
    );

    bool? didAddNodeToAnchor =
        await arObjectManager?.addNode(newNode, planeAnchor: anchor);
    if (didAddNodeToAnchor ?? false) {
      nodes.add(newNode);
    } else {
      arSessionManager?.onError("Adding Node to Anchor failed");
    }
  }
}
