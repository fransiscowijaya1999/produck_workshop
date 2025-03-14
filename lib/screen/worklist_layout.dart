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
  final db = DatabaseService.db;

  late Future<List<Project>> projectsFuture;
  late StreamSubscription<List<Project>> _projectsStream;

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
    Query<Project> projectsQuery = db.projects.where()
      .filter()
      .isUploadedEqualTo(false)
      .sortByIsPinnedDesc()
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
      _currentProjectId = projectId;
    });
  }

  Future<void> onPin(int id) async {
    await db.writeTxn(() async {
      final existingProject = await db.projects.get(id);

      if (existingProject != null) {
        existingProject.isPinned = !existingProject.isPinned;

        await db.projects.put(existingProject);
      }
    });
  }

  Future<void> onCreate() async {
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
                              final filteredProject = projects.where((p) => p.id == _currentProjectId).toList();
                              final currentSelectedProject = filteredProject.isNotEmpty ? filteredProject[0] : null;
                              final projectIndex = currentSelectedProject != null ? projects.indexOf(currentSelectedProject) : null;

                              return Worklist(
                                worklist: projects,
                                onSelected: (index) => onSelected(index, projects[index].id),
                                selectedIndex: projectIndex,
                                onCreate: onCreate,
                                onPin: onPin,
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