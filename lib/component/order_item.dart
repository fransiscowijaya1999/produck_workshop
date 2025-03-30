import 'package:flutter/material.dart';
import 'package:produck_workshop/component/order_list.dart';
import 'package:produck_workshop/schema/order.dart';
import 'package:produck_workshop/util/project.dart';

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
    if (order.isGroup) {
      return ExpansionTile(
        controlAffinity: ListTileControlAffinity.leading,
        minTileHeight: 0,
        dense: true,
        childrenPadding: EdgeInsets.all(10),
        backgroundColor: Colors.black12,
        collapsedBackgroundColor: Colors.black12,
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
              flex: 12,
              child: Text(order.description)
            ),
            Expanded(
              flex: 2,
              child: Text('Rp${removeDecimalZeroFormat(getOrdersTotalPrice(order.orders))}'),
            )
          ],
        ),
        children: [
          OrderList(
            orders: order.orders ?? [],
          )
        ],
      );
    }

    return ListTile(
      tileColor: order.isBroker ? Colors.amber : null,
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
            flex: 5,
            child: Text(order.description)
          ),
          Expanded(
            flex: 1,
            child: Text('Rp${removeDecimalZeroFormat(order.cost)}'),
          ),
          Expanded(
            flex: 1,
            child: Text('${order.qty}'),
          ),
          Expanded(
            flex: 1,
            child: Text('Rp${removeDecimalZeroFormat(order.price)}'),
          ),
          Expanded(
            flex: 2,
            child: Text('Rp${removeDecimalZeroFormat(order.qty * order.price)}'),
          )
        ],
      ),
    );
  }
}