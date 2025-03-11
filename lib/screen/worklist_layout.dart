import 'package:flutter/material.dart';
import 'package:produck_workshop/component/menu_bottom.dart';
import 'package:produck_workshop/component/worklist.dart';

class WorklistLayout extends StatefulWidget {
  const WorklistLayout({super.key});

  @override
  State<WorklistLayout> createState() => _WorklistLayoutState();
}

class _WorklistLayoutState extends State<WorklistLayout> {
  List<WorklistDestination> worklistDestinations = [
    WorklistDestination(label: 'tammtammtammtammtammtamm tammtamm tammtamm'),
    WorklistDestination(label: 'team'),
    WorklistDestination(label: 'tamm'),
    WorklistDestination(label: 'team'),
    WorklistDestination(label: 'tamm'),
    WorklistDestination(label: 'team'),
    WorklistDestination(label: 'tamm'),
    WorklistDestination(label: 'team'),
    WorklistDestination(label: 'tamm'),
    WorklistDestination(label: 'team'),
    WorklistDestination(label: 'tamm'),
    WorklistDestination(label: 'team'),
    WorklistDestination(label: 'tamm'),
    WorklistDestination(label: 'team'),
    WorklistDestination(label: 'tamm'),
    WorklistDestination(label: 'team'),
    WorklistDestination(label: 'tamm'),
    WorklistDestination(label: 'team'),
    WorklistDestination(label: 'tamm'),
    WorklistDestination(label: 'team'),
    WorklistDestination(label: 'tamm'),
    WorklistDestination(label: 'team'),
    WorklistDestination(label: 'tamm'),
    WorklistDestination(label: 'team'),
    WorklistDestination(label: 'tamm'),
    WorklistDestination(label: 'team'),
  ];

  int? _selectedIndex;

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