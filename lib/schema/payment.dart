import 'package:isar/isar.dart';

part 'payment.g.dart';

@embedded
class Payment {
  late DateTime date;
  late float amount;
}