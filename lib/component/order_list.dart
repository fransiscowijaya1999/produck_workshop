import 'package:flutter/material.dart';
import 'package:produck_workshop/component/order_item.dart';
import 'package:produck_workshop/schema/order.dart';

class OrderList extends StatelessWidget {
  const OrderList({
    super.key,
    this.orders = const [],
  });

  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemCount: orders.length,
      itemBuilder: (_, index) {
        return OrderItem(
          order: orders[index]
        );
      },
      onReorder: (int oldIndex, int newIndex) {

      }
    );
  }
}