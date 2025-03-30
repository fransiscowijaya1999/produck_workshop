import 'package:produck_workshop/schema/order.dart';

double getOrdersTotalPrice(List<Order>? orders) {
  if (orders == null) return 0;
  
  final double sum = orders.fold(0, (prev, curr) {
    if (curr.isGroup) {
      return prev + getOrdersTotalPrice(curr.orders);
    } else {
      return prev + (curr.price * curr.qty);
    }
  });

  return sum;
}

String removeDecimalZeroFormat(double n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
}