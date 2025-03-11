import 'package:flutter/material.dart';
import 'package:produck_workshop/component/menu_bottom.dart';
import 'package:produck_workshop/component/worklist.dart';
import 'package:produck_workshop/model/project.dart';

class WorklistLayout extends StatefulWidget {
  const WorklistLayout({super.key});

  @override
  State<WorklistLayout> createState() => _WorklistLayoutState();
}

class _WorklistLayoutState extends State<WorklistLayout> {
  List<WorklistDestination> worklistDestinations = [
    WorklistDestination(project: Project(label: 'squidward')),
    WorklistDestination(project: Project(label: 'bob', isPinned: true, vehicle: 'honda revo absolute')),
    WorklistDestination(project: Project(label: 'crab', isPinned: false)),
    WorklistDestination(project: Project(label: 'plankton', isPinned: true, vehicle: 'yamaha vixion')),
    WorklistDestination(project: Project(label: 'larry', isPinned: false, vehicle: 'honda cb150 verza')),
    WorklistDestination(project: Project(label: 'garry', isPinned: false)),
  ];

  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    worklistDestinations.sort((a, b) => (a.project.isPinned == b.project.isPinned ? 0 : (a.project.isPinned ? -1 : 1)));
  }

  void onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Worklist(
                    worklist: worklistDestinations,
                    onSelected: onSelected,
                    selectedIndex: _selectedIndex,
                  ),
                ),
                const Divider(),
                const MenuBottom()
              ],
            )
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: GeneratorWork(),
            ),
          )
        ],
      ),
    );
  }
}

class GeneratorWork extends StatelessWidget {
  const GeneratorWork({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Welcome to ProDuck Workshop'),);
  }
}