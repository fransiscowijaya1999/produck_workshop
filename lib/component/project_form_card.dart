import 'package:flutter/material.dart';
import 'package:produck_workshop/util/project.dart';

typedef SaveCallback = void Function(String label, String vehicle, String date);

class ProjectFormCard extends StatefulWidget {
  const ProjectFormCard({
    super.key,
    this.label = '',
    this.vehicle = '',
    this.date = '',
    this.totalPrice = 0,
    this.paid = 0,
    this.paymentCount = 0,
    this.onSave,
    this.onDelete,
    this.onPayment,
    this.isSaving = false,
    this.isUploaded = false,
  });

  final String label;
  final String vehicle;
  final String date;
  final double totalPrice;
  final double paid;
  final int paymentCount;
  final SaveCallback? onSave;
  final VoidCallback? onDelete;
  final VoidCallback? onPayment;
  final bool isSaving;
  final bool isUploaded;

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: 'Paid: '),
                      TextSpan(text: 'Rp${removeDecimalZeroFormat(widget.paid)}', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' / Rp${removeDecimalZeroFormat(widget.totalPrice)} '),
                      TextSpan(text: '(-Rp${removeDecimalZeroFormat(widget.totalPrice - widget.paid)})', style: TextStyle(color: Colors.red))
                    ]
                  )
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(text: 'Payment Count: '),
                          TextSpan(text: '${widget.paymentCount}', style: TextStyle(fontWeight: FontWeight.bold)),
                        ]
                      )
                    ),
                    TextButton(onPressed: null, child: Icon(Icons.history))
                  ],
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
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: widget.onSave != null && !widget.isSaving ? () { widget.onSave!(labelController.text, vehicleController.text, dateController.text); } : null,
                      child: widget.isSaving ? const SizedBox(height: 5, child: CircularProgressIndicator()) : const Text('Save')
                    ),
                    SizedBox(width: 10,),
                    ElevatedButton(
                      onPressed: widget.paid >= widget.totalPrice ? null : widget.onPayment,
                      child: Text('Payment')
                    ),
                    if (widget.isUploaded)
                      ...[
                        SizedBox(width: 10,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text('Uploaded', style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                        )
                      ]
                  ],
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