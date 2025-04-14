import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:produck_workshop/util/project.dart';

class PaymentDialog extends StatefulWidget {
  const PaymentDialog({
    super.key,
    required this.remainingPayment,
    this.onSubmit
  });

  final double remainingPayment;
  final Future Function(DateTime, double)? onSubmit;

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  final dateController = TextEditingController();
  final amountController = TextEditingController();

  late double remaining;

  @override
  void initState() {
    super.initState();
    remaining = widget.remainingPayment - (double.tryParse(amountController.text) ?? 0);
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    amountController.addListener(() => setState(() {
      remaining = widget.remainingPayment - (double.tryParse(amountController.text) ?? 0);
    }));
  }

  @override
  void dispose() {
    dateController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Payment'),
      content: SizedBox(
        width: 300,
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                hintText: 'Date'
              ),
            ),
            TextField(
              autofocus: true,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
              keyboardType: TextInputType.number,
              controller: amountController,
              decoration: InputDecoration(
                hintText: 'Amount'
              ),
            ),
            SizedBox(height: 10,),
            Text('Remaining: Rp${removeDecimalZeroFormat(remaining)}')
          ],
        )
      ),
      actions: [
        TextButton(
          onPressed: widget.onSubmit != null ? () async {
            final amount = double.parse(amountController.text);
            final paid = amount > widget.remainingPayment ? widget.remainingPayment : amount;

            await widget.onSubmit!(DateFormat('yyyy-MM-dd').parse(dateController.text), amount);
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          } : null,
          child: const Icon(Icons.check)
        )
      ],
    );
  }
}