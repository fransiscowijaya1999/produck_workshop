import 'package:flutter/material.dart';

class ProjectFormCard extends StatefulWidget {
  const ProjectFormCard({
    super.key
  });

  @override
  State<ProjectFormCard> createState() => _ProjectFormCardState();
}

class _ProjectFormCardState extends State<ProjectFormCard> {
  final labelController = TextEditingController();
  final vehicleController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void dispose() {
    labelController.dispose();
    vehicleController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Create Project')
          ],
        ),
      ),
    );
  }
}