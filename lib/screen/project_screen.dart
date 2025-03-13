import 'package:flutter/material.dart';
import 'package:produck_workshop/component/project_form_card.dart';
import 'package:produck_workshop/db.dart';
import 'package:produck_workshop/schema/project.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({
    super.key,
    required this.project
  });

  final Project project;

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  late Project _project;

  @override
  void initState() {
    super.initState();
    _project = widget.project;

    createWatcher();
  }

  void createWatcher() {
    final db = DatabaseService.db;
    final projectChanged = db.projects.watchObject(widget.project.id);
    projectChanged.listen((project) {
      if (project != null) {
        setState(() {
          _project = project;
        });
      }
    });
  }

  Future<void> saveProject(String label, String vehicle, String date) async {
    final db = DatabaseService.db;
    await db.writeTxn(() async {
      final project = (await db.projects.get(_project.id))!;

      project.label = label;
      project.vehicle = vehicle;
      project.date = DateTime.now();

      await db.projects.put(project);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(25),
        child: ProjectFormCard(
          label: _project.label,
          vehicle: _project.vehicle,
          date: _project.date.toString(),
          onSave: saveProject,
        ),
      ),
    );
  }
}