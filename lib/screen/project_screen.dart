import 'dart:async';

import 'package:flutter/material.dart';
import 'package:produck_workshop/component/project_form_card.dart';
import 'package:produck_workshop/db.dart';
import 'package:produck_workshop/schema/project.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({
    super.key,
    required this.projectId,
    this.onDeleted
  });

  final int projectId;
  final VoidCallback? onDeleted;

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  final db = DatabaseService.db;

  late Future<Project?> projectFuture;
  late StreamSubscription<Project?> projectStream;

  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    projectFuture = db.projects.get(widget.projectId);
    createWatcher(widget.projectId);
  }

  @override
  void dispose() {
    projectStream.cancel();
    super.dispose();
  }

  void createWatcher(int id) {
    projectFuture = db.projects.get(widget.projectId);
    
    final projectChanged = db.projects.watchObject(id);
    projectStream = projectChanged.listen((project) {
      if (project != null) {
        setState(() {
          projectFuture = db.projects.get(project.id);
        });
      }
    });
  }

  Future<void> saveProject(String label, String vehicle, String date) async {
    setState(() {
      isSaving = true;
    });
    final db = DatabaseService.db;
    await db.writeTxn(() async {
      final project = (await db.projects.get(widget.projectId))!;

      project.label = label;
      project.vehicle = vehicle;
      project.date = DateTime.now();

      await db.projects.put(project);
    });
    setState(() {
      isSaving = false;
    });
  }

  Future<void> deleteProject() async {
    final db = DatabaseService.db;
    await db.writeTxn(() async {
      final success = await db.projects.delete(widget.projectId);
      if (success && widget.onDeleted != null) {
        widget.onDeleted!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Project?>(
      future: projectFuture,
      builder: (BuildContext context, AsyncSnapshot<Project?> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              if (snapshot.data != null) {
                final project = snapshot.data!;

                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: ProjectFormCard(
                      label: project.label,
                      vehicle: project.vehicle,
                      date: project.date.toString(),
                      onSave: saveProject,
                      onDelete: deleteProject,
                      isSaving: isSaving
                    ),
                  ),
                );
              } else {
                return const Center(child: Text('No data exist, could it be already deleted?'));
              }
            }
        }
      },
    );
    
  }
}