import 'package:flutter/material.dart';
import 'package:produck_workshop/schema/order.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Checkbox(value: false, onChanged: null),
          Expanded(
            flex: 1,
            child: TextField(
              controller: descriptionController..text = widget.order.description,
              decoration: InputDecoration(
                hintText: 'Product'
              ),
              enabled: false
            ),
          ),
          Expanded(
            flex: 1,
            child: TextField(
              controller: descriptionController..text = widget.order.description,
              decoration: InputDecoration(
                hintText: 'Description'
              ),
              enabled: false
            ),
          )
        ],
      ),
    );
  }
}