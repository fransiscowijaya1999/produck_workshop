import 'package:flutter/material.dart';
import 'package:produck_workshop/component/menu_bottom.dart';
import 'package:produck_workshop/component/worklist.dart';
import 'package:produck_workshop/screen/project_create_screen.dart';

class WorklistLayout extends StatefulWidget {
  const WorklistLayout({super.key});

  @override
  State<WorklistLayout> createState() => _WorklistLayoutState();
}

class _WorklistLayoutState extends State<WorklistLayout> {
  List<WorklistDestination> worklistDestinations = [];

  int? _selectedIndex;
  bool _isCreation = false;

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
                    onCreate: () {
                      setState(() {
                        _isCreation = true;
                        _selectedIndex = worklistDestinations.length + 1;
                      });
                    },
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
              child: _isCreation ? const ProjectCreateScreen() : GeneratorWork(
                index: _selectedIndex,
                worklistDestinations: worklistDestinations,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class GeneratorWork extends StatelessWidget {
  const GeneratorWork({
    super.key,
    required this.index,
    required this.worklistDestinations
  });

  final int? index;
  final List<WorklistDestination> worklistDestinations;

  @override
  Widget build(BuildContext context) {
    if (index == null) {
      return Center(child: Text('Welcome to ProDuck Workshop'),);
    }
    return Center(child: Text('$index'),);
  }
}