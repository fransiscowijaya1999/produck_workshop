import 'package:flutter/material.dart';
import 'package:produck_workshop/db.dart';
import 'package:produck_workshop/screen/start_screen.dart';

void main() async {
  await _setup();
  runApp(const MyApp());
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.setup();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProDuck Workshop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: startScreenGenerator(),
    );
  }
}
