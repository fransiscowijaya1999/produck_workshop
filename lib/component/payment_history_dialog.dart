import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:produck_workshop/schema/payment.dart';
import 'package:produck_workshop/util/project.dart';

class PaymentHistoryDialog extends StatelessWidget {
  const PaymentHistoryDialog({
    super.key,
    required this.payments
  });

  final List<Payment> payments;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Payments'),
      content: SizedBox(
        width: 300,
        height: 300,
        child: ListView.builder(
          itemCount: payments.length,
          itemBuilder: (_, index) {
            final payment = payments[index];
        
            return ListTile(
              key: Key('$index'),
              dense: true,
              title: Text('${DateFormat('yyyy-MM-dd').format(payment.date)} - Rp${removeDecimalZeroFormat(payment.amount)}'),
            );
          },
        ),
      ),
      actions: [],
    );
  }
}