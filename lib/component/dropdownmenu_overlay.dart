import 'package:flutter/material.dart';

class DropdownmenuOverlay extends StatelessWidget {
  const DropdownmenuOverlay({
    super.key,
    this.isLoading = false,
    required this.list,
    required this.selectedIndex
  });

  final bool isLoading;
  final List<String> list;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: isLoading ?
        Padding(
          padding: const EdgeInsets.all(15),
          child: Center(child: const CircularProgressIndicator()),
        ) :
        ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ListTile(
              minTileHeight: 0,
              dense: true,
              selected: selectedIndex == index,
              selectedTileColor: Colors.black.withAlpha(15),
              title: Text(list[index])
            );
          },
      ),
    );
  }
}