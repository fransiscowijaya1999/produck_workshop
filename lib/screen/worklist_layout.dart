import 'dart:async';

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
  late Future<List<Project>> projectsFuture;
  late StreamSubscription<List<Project>> _projectsStream;

  int? _selectedIndex;
  int? _currentProjectId;

  @override
  void initState() {
    super.initState();

    createWatcher();
  }

  @override
  void dispose() {
    _projectsStream.cancel();
    super.dispose();
  }

  void createWatcher() {
    final db = DatabaseService.db;

    Query<Project> projectsQuery = db.projects.where()
      .filter()
      .isUploadedEqualTo(false)
      .build();
    
    setState(() {
      projectsFuture = projectsQuery.findAll();
    });

    Stream<List<Project>> queryChanged = projectsQuery.watch();
    _projectsStream = queryChanged.listen((projects) {
      setState(() {
        projectsFuture = projectsQuery.findAll();
      });
    });
  }

  void onSelected(int index, int projectId) {
    setState(() {
      _selectedIndex = index;
      _currentProjectId = projectId;
    });
  }

  Future<void> onCreate() async {
    final db = DatabaseService.db;
    final newProject = Project()
      ..date = DateTime.now();

    await db.writeTxn(() async {
      await db.projects.put(newProject);
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
                  child: FutureBuilder<List<Project>>(
                    future: projectsFuture,
                    builder: (BuildContext context, AsyncSnapshot<List<Project>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else {
                            if (snapshot.data != null) {
                              final projects = snapshot.data!;

                              return Worklist(
                                worklist: projects,
                                onSelected: (index) => onSelected(index, projects[index].id),
                                selectedIndex: _selectedIndex,
                                onCreate: onCreate,
                              );
                            } else {
                              return Center(child: Text('Projects is null'));
                            }
                          }
                      }
                    }
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
                      projectId: _currentProjectId,
                      onDeleted: () {
                        setState(() {
                          _selectedIndex = null;
                          _currentProjectId = null;
                        });
                      },
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
    required this.projectId,
    this.onDeleted
  });

  final int? projectId;
  final VoidCallback? onDeleted;

  @override
  Widget build(BuildContext context) {
    if (projectId == null) {
      return Center(child: Text('Select or create a Project.'),);
    } else {
      return ProjectScreen(
        projectId: projectId!,
        onDeleted: onDeleted,
      );
    }
  }
}