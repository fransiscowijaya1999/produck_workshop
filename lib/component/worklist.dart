import 'package:flutter/material.dart';
import 'package:produck_workshop/model/project.dart';

class WorklistDestination {
  WorklistDestination({
    required this.project,
  });

  final Project project;
}

class Worklist extends StatelessWidget {
  const Worklist({
    super.key,
    this.worklist = const [],
    this.selectedIndex,
    this.onSelected,
    this.onCreate
  });

  final List<WorklistDestination> worklist;
  final int? selectedIndex;
  final ValueSetter<int>? onSelected;
  final VoidCallback? onCreate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: ListView.builder(
        itemCount: worklist.length + 1,
        itemBuilder: (_, index) {
          if (index == worklist.length) {
            return ListTile(
              title: Icon(Icons.add),
              onTap: onCreate,
              selected: selectedIndex == worklist.length + 1,
              selectedTileColor: Colors.black.withAlpha(15),
            );
          }
          return WorklistTile(
            project: worklist[index].project,
            onSelected: onSelected != null ? () => onSelected!(index) : null,
            isSelected: selectedIndex == index,
          );
        }
      ),
    );
  }
}

class WorklistTile extends StatelessWidget {
  const WorklistTile({
    super.key,
    required this.project,
    this.onSelected,
    this.isSelected = false
  });

  final VoidCallback? onSelected;
  final Project project;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          alignment: Alignment.topLeft
        ),
        onPressed: onSelected,
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10, left: 5, right: 5),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(text: project.label, style: TextStyle(fontSize: 20)),
                TextSpan(text: '\n'),
                if (project.vehicle.isNotEmpty) ...[
                  TextSpan(text: project.vehicle, style: TextStyle(fontSize: 10, color: Colors.grey)),
                  TextSpan(text: '\n')
                ],
                TextSpan(text: 'Rp10,000', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54))
              ]
            )
          ),
        ),
      ),
      contentPadding: EdgeInsets.all(0),
      minVerticalPadding: 0,
      horizontalTitleGap: 5,
      selected: isSelected,
      selectedTileColor: Colors.black.withAlpha(15),
      trailing: TextButton.icon(
        onPressed: () {},
        label: project.isPinned ? Icon(Icons.star) : Icon(Icons.star_border),
      ),
    );
  }
}