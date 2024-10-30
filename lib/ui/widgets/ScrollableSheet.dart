import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/src/controllers/flutter_3d_controller.dart';
import 'package:flutter_3d_controller/src/data/datasources/i_flutter_3d_datasource.dart';
import 'package:flutter_3d_controller/src/data/repositories/flutter_3d_repository.dart';
import 'package:flutter_3d_controller/src/modules/model_viewer/model_viewer.dart';
import 'package:flutter_3d_controller/src/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Ужас. Перенети в логику repo/

class DraggableSheet extends StatefulWidget {
  final double minChildSize;
  final double initialChildSize;
  final double maxChildSize;
  final Color topContainerColor;
  final Color handleColor;
  final int gridItemCount;
  final Function(int)? onModelSelected;

  const DraggableSheet.roomEditor({
    super.key,
    this.minChildSize = 0.02,
    this.initialChildSize = 0.02,
    this.maxChildSize = 0.5,
    this.topContainerColor = Colors.transparent,
    this.handleColor = const Color.fromRGBO(255, 255, 255, 0.9),
    this.gridItemCount = 6,
    this.onModelSelected,
  });

  @override
  State<DraggableSheet> createState() => _DraggableSheetState();
}

class _DraggableSheetState extends State<DraggableSheet> {
  int? selectedModelIndex; // Track selected index

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Flutter3DController? _controller;
    late String _id;
    final Utils _utils = Utils();

    @override
    void initState() {
      _id = _utils.generateId();
      _controller = _controller ?? Flutter3DController();
      if (kIsWeb) {
        _controller?.init(Flutter3DRepository(IFlutter3DDatasource(null)));
      }
      super.initState();
    }

    return DraggableScrollableSheet(
      minChildSize: widget.minChildSize,
      initialChildSize: widget.initialChildSize,
      maxChildSize: widget.maxChildSize,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Colors.transparent,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Container(
                  color: widget.topContainerColor,
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.008),
                  child: Center(
                    child: Container(
                      width: size.width * 0.2,
                      height: size.height * 0.005,
                      decoration: BoxDecoration(
                        color: widget.handleColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  padding: const EdgeInsets.all(8),
                  itemCount: widget.gridItemCount,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedModelIndex == index
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: ModelViewer(
                              src: "assets/models/model_${index + 1}/model.glb",
                              relatedJs: _utils.injectedJS(),
                              ar: false,
                              autoPlay: false,
                              autoRotate: true,
                              debugLogging: false,
                              interactionPrompt: InteractionPrompt.none,
                              onWebViewCreated: kIsWeb
                                  ? null
                                  : (WebViewController value) {
                                      _controller?.init(Flutter3DRepository(
                                          IFlutter3DDatasource(value)));
                                    },
                            ),

                            // Flutter3DViewer(
                            //   src: "assets/models/model_${index + 1}/model.glb",
                            // ),
                          ),
                        ),
                        Positioned.fill(
                          child: Opacity(
                            opacity: 0.1,
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedModelIndex = index;
                                });
                                widget.onModelSelected?.call(index + 1);
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
