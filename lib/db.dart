import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:produck_workshop/schema/project.dart';

class DatabaseService {
  static late final Isar db;

  static Future<void> setup() async {
    final dir = await getApplicationDocumentsDirectory();
    db = await Isar.open(
      [ProjectSchema],
      directory: dir.path
    );
  }
}