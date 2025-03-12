import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:produck_workshop/schema/project.dart';

Future<Isar> db() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [ProjectSchema],
    directory: dir.path
  );

  return isar;
}