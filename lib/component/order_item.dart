import 'package:flutter/material.dart';
import 'package:produck_workshop/schema/order.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.order,
    this.isChecked = false,
    this.onChecked,
  });

  final Order order;
  final bool isChecked;
  final ValueSetter<Order>? onChecked;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      minVerticalPadding: 0,
      horizontalTitleGap: 5,
      dense: true,
      title: Row(
        children: [
          SizedBox(
            width: 50,
            child: Checkbox(
              value: isChecked,
              onChanged: onChecked != null ? (checkStatus) => onChecked!(order) : null
            ),
          ),
          Expanded(
            flex: 3,
            child: Text('Product')
          ),
          Expanded(
            flex: 6,
            child: Text(order.description)
          ),
          Expanded(
            flex: 1,
            child: Text('Rp${order.cost}'),
          ),
          Expanded(
            flex: 1,
            child: Text('${order.qty}'),
          ),
          Expanded(
            flex: 1,
            child: Text('Rp${order.price}'),
          ),
          Expanded(
            flex: 2,
            child: Text('Rp${order.qty * order.price}'),
          )
        ],
      ),
    );
  }
}