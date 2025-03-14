import 'package:flutter/material.dart';

typedef SaveCallback = void Function(String label, String vehicle, String date);

class ProjectFormCard extends StatefulWidget {
  const ProjectFormCard({
    super.key,
    this.label = '',
    this.vehicle = '',
    this.date = '',
    this.onSave,
    this.onDelete,
    this.isSaving = false,
  });

  final String label;
  final String vehicle;
  final String date;
  final SaveCallback? onSave;
  final VoidCallback? onDelete;
  final bool isSaving;

  @override
  State<ProjectFormCard> createState() => _ProjectFormCardState();
}

class _ProjectFormCardState extends State<ProjectFormCard> {
  late TextEditingController labelController;
  late TextEditingController vehicleController;
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    labelController = TextEditingController();
    vehicleController = TextEditingController();
    dateController = TextEditingController();
  }

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
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      TextField(
                        controller: labelController..text = widget.label,
                        decoration: InputDecoration(
                          labelText: 'Label'
                        ),
                      ),
                      TextField(
                        controller: vehicleController..text = widget.vehicle,
                        decoration: InputDecoration(
                          labelText: 'Vehicle'
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(flex: 1,),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      TextField(
                        controller: dateController..text = widget.date.toString(),
                        decoration: InputDecoration(
                          labelText: 'Date'
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Divider(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: widget.onSave != null && !widget.isSaving ? () { widget.onSave!(labelController.text, vehicleController.text, dateController.text); } : null,
                  child: widget.isSaving ? const SizedBox(height: 5, child: CircularProgressIndicator()) : const Text('Save')
                ),
                ElevatedButton(
                  onPressed: widget.onDelete != null ? () { widget.onDelete!(); } : null,
                  style: ElevatedButton.styleFrom(
                    iconColor: Colors.white,
                    backgroundColor: Colors.red
                  ),
                  child: const Icon(Icons.delete),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}