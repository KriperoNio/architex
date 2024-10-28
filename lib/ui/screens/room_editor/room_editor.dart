import 'package:flutter/material.dart';

import '../../widgets/ScrollableSheet.dart';

class ScreenRoomEditor extends StatelessWidget {
  const ScreenRoomEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          color: Colors.white10,
          height: 900,
        ),
        const DraggableSheet.roomEditor()
      ],
    );
  }
}
