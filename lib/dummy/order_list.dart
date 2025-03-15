import 'package:produck_workshop/schema/order.dart';

final List<Order> dummyOrders = [
  Order()
    ..productId = 1
    ..description = 'jumbo brake fluid 50 mL'
    ..price = 10
    ..qty = 1
    ..cost = 6
  ,
  Order()
    ..productId = 2
    ..description = 'brake pad blade'
    ..price = 15
    ..qty = 1
    ..cost = 10
  ,
  Order()
    ..description = 'fasteners'
    ..isGroup = true
    ..orders = [
      Order()
      ..productId = 3
      ..description = 'bolt + nut m6 x 25'
      ..price = 1
      ..qty = 5
      ..cost = 0.5
      ,
      Order()
      ..productId = 4
      ..description = 'bolt + nut m6 x 35'
      ..price = 1
      ..qty = 3
      ..cost = 0.5
    ]
];