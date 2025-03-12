import 'package:flutter/material.dart';
import 'package:produck_workshop/component/project_form_card.dart';

class ProjectCreateScreen extends StatefulWidget {
  const ProjectCreateScreen({
    super.key
  });

  @override
  State<ProjectCreateScreen> createState() => _ProjectCreateScreenState();
}

class _ProjectCreateScreenState extends State<ProjectCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: ProjectFormCard(),
    );
  }
}