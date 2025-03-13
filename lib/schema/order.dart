import 'package:isar/isar.dart';

part 'order.g.dart';

@embedded
class Order {
  bool isGroup = false;
  String description = '';
  int? productId;
  int qty = 0;
  float price = 0;
  float cost = 0;
  bool isBroker = false;
  List<Order>? orders;
}