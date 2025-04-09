import 'package:isar/isar.dart';
import 'package:produck_workshop/schema/order.dart';
import 'package:produck_workshop/schema/payment.dart';

part 'project.g.dart';

@collection
class Project {
  Id id = Isar.autoIncrement;
  String label = '';
  String vehicle = '';
  String memo = '';
  bool isPinned = false;
  bool isUploaded = false;
  late DateTime date;
  List<Order> orders = [];
  List<Payment> payments = [];
}