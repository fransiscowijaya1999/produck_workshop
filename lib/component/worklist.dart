import 'package:flutter/material.dart';

class WorklistDestination {
  WorklistDestination({
    required this.label,
    this.isPinned = false
  });

  final String label;
  final bool isPinned;
}

class Worklist extends StatelessWidget {
  const Worklist({
    super.key,
    this.worklist = const [],
    this.selectedIndex,
    this.onSelected
  });

  final List<WorklistDestination> worklist;
  final int? selectedIndex;
  final ValueSetter<int>? onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child:
        worklist.isEmpty ?
        Center(child: Text('No worklist yet.'),) :
        ListView.builder(
          itemCount: worklist.length,
          itemBuilder: (_, index) {
            return WorklistTile(
              label: worklist[index].label,
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
    this.onSelected,
    this.label = '',
    this.isSelected = false
  });

  final VoidCallback? onSelected;
  final String label;
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
        child: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(text: label, style: TextStyle(fontSize: 20)),
              TextSpan(text: '\n'),
              TextSpan(text: 'Honda KPH', style: TextStyle(fontSize: 10, color: Colors.grey)),
              TextSpan(text: '\n'),
              TextSpan(text: 'Rp10,000', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54))
            ]
          )
        ),
      ),
      contentPadding: EdgeInsets.all(0),
      selected: isSelected,
      selectedTileColor: Colors.black12,
      trailing: TextButton.icon(
        onPressed: () {},
        label: Icon(Icons.star_border),
      ),
    );
  }
}