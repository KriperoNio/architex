import 'package:flutter/material.dart';

class DraggableSheet extends StatelessWidget {
  final double minChildSize;
  final double initialChildSize;
  final double maxChildSize;
  final Color topContainerColor;
  final Color handleColor;
  final int gridItemCount;

  const DraggableSheet.roomEditor({
    super.key,
    this.minChildSize = 0.02,
    this.initialChildSize = 0.02,
    this.maxChildSize = 0.5,
    this.topContainerColor = Colors.transparent,
    this.handleColor = const Color.fromRGBO(255, 255, 255, 0.9),
    this.gridItemCount = 30,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DraggableScrollableSheet(
      minChildSize: minChildSize,
      initialChildSize: initialChildSize,
      maxChildSize: maxChildSize,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Colors.transparent,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Container(
                  color: topContainerColor,
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.008),
                  child: Center(
                    child: Container(
                      width: size.width * 0.2,
                      height: size.height * 0.005,
                      decoration: BoxDecoration(
                        color: handleColor,
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
                  itemCount: gridItemCount,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 1),
                      color: Colors.blueGrey[100 * (index % 9)],
                      child: Center(
                        child: Text(
                          'Item ${index + 1}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
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
