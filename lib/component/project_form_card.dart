import 'package:flutter/material.dart';

typedef SaveCallback = void Function(String label, String vehicle, String date);

class ProjectFormCard extends StatefulWidget {
  const ProjectFormCard({
    super.key,
    this.label = '',
    this.vehicle = '',
    this.date = '',
    this.onSave
  });

  final String label;
  final String vehicle;
  final String date;
  final SaveCallback? onSave;

  @override
  State<ProjectFormCard> createState() => _ProjectFormCardState();
}

class _ProjectFormCardState extends State<ProjectFormCard> {
  final labelController = TextEditingController();
  final vehicleController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    labelController.text = widget.label;
    vehicleController.text = widget.vehicle;
    dateController.text = widget.date;
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
                        controller: labelController,
                        decoration: InputDecoration(
                          labelText: 'Label'
                        ),
                      ),
                      TextField(
                        controller: vehicleController,
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
                        controller: dateController,
                        decoration: InputDecoration(
                          labelText: 'Date'
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: widget.onSave != null ? () { widget.onSave!(labelController.text, vehicleController.text, dateController.text); } : null, child: Text('Save'))
          ],
        ),
      ),
    );
  }
}