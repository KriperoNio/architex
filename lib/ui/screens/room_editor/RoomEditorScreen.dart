import 'package:flutter/material.dart';
import '_RoomEditor.dart';

class ScreenRoomEditor extends StatefulWidget {
  const ScreenRoomEditor({super.key});

  @override
  State<ScreenRoomEditor> createState() => _ScreenRoomEditorState();
}

class _ScreenRoomEditorState extends State<ScreenRoomEditor> {
  int selectedModelIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          color: const Color(0x00000000),
          height: 900,
          child: ARScreen(selectedModelIndex: selectedModelIndex),
        ),
        DraggableSheet.roomEditor(
          onModelSelected: (index) {
            setState(() => selectedModelIndex = index);
          },
        ),
      ],
    );
  }
}
