import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:produck_workshop/component/menu_bottom.dart';
import 'package:produck_workshop/component/worklist.dart';
import 'package:produck_workshop/db.dart';
import 'package:produck_workshop/screen/project_screen.dart';

import '../schema/project.dart';

class WorklistLayout extends StatefulWidget {
  const WorklistLayout({super.key});

  @override
  State<WorklistLayout> createState() => _WorklistLayoutState();
}

class _WorklistLayoutState extends State<WorklistLayout> {
  List<Project> _projects = [];

  int? _selectedIndex;
  int? _createdId;

  @override
  void initState() {
    super.initState();
    createWatcher();
  }

  void createWatcher() {
    final db = DatabaseService.db;

    Query<Project> projectsQuery = db.projects.where()
      .filter()
      .isUploadedEqualTo(false)
      .build();

    Stream<List<Project>> queryChanged = projectsQuery.watch(fireImmediately: true);
    queryChanged.listen((projects) {
      setState(() {
        _projects = projects;
        if (_createdId != null) {
          final projectFiltered = _projects.where((p) => p.id == _createdId).toList();
          final newIndex = _projects.indexOf(projectFiltered[0]);

          _selectedIndex = newIndex;
          _createdId = null;
        }
      });

    });
  }

  void onSelected(int index) {
    setState(() {
      _selectedIndex = index; 
    });
  }

  Future<void> onCreate() async {
    final db = DatabaseService.db;
    final newProject = Project()
      ..date = DateTime.now();

    await db.writeTxn(() async {
      await db.projects.put(newProject);
    });

    setState(() {
      _createdId = newProject.id;
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
                    worklist: _projects,
                    onSelected: onSelected,
                    selectedIndex: _selectedIndex,
                    onCreate: onCreate,
                  )
                ),
                const Divider(),
                const MenuBottom()
              ],
            )
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Column(
                children: [
                  Expanded(
                    child: GeneratorWork(
                      index: _selectedIndex,
                      worklistDestinations: _projects,
                    ),
                  )
                ],
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
  final List<Project> worklistDestinations;

  @override
  Widget build(BuildContext context) {
    if (index == null) {
      return Center(child: Text('Welcome to ProDuck Workshop'),);
    }
    return ProjectScreen(project: worklistDestinations[index!]);
  }
}