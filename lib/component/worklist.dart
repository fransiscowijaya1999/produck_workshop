import 'package:flutter/material.dart';
import 'package:produck_workshop/schema/project.dart';
import 'package:produck_workshop/util/project.dart';

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
    this.onCreate,
    this.onPin
  });

  final List<Project> worklist;
  final int? selectedIndex;
  final ValueSetter<int>? onSelected;
  final VoidCallback? onCreate;
  final ValueSetter<int>? onPin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: ListView.builder(
        itemCount: onCreate != null ? worklist.length + 1 : worklist.length,
        itemBuilder: (_, index) {
          if (index == worklist.length && onCreate != null) {
            return ListTile(
              title: Icon(Icons.add),
              onTap: onCreate
            );
          }
          return WorklistTile(
            project: worklist[index],
            onSelected: onSelected != null ? () => onSelected!(index) : null,
            isSelected: selectedIndex == index,
            onPin: onPin != null ? () => onPin!(worklist[index].id) : null
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
    this.isSelected = false,
    this.onPin
  });

  final VoidCallback? onSelected;
  final Project project;
  final bool isSelected;
  final VoidCallback? onPin;

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
                TextSpan(text: project.label.isEmpty ? 'Unlabelled' : project.label, style: TextStyle(fontSize: 20)),
                TextSpan(text: '\n'),
                if (project.vehicle.isNotEmpty) ...[
                  TextSpan(text: project.vehicle, style: TextStyle(fontSize: 10, color: Colors.grey)),
                  TextSpan(text: '\n')
                ],
                TextSpan(text: 'Rp${removeDecimalZeroFormat(getOrdersTotalPrice(project.orders))}', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54))
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
      trailing: onPin != null ? TextButton.icon(
        onPressed: onPin,
        label: project.isPinned ? Icon(Icons.star) : Icon(Icons.star_border),
      ) : null,
    );
  }
}