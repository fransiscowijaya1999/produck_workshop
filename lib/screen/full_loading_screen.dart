import 'package:flutter/material.dart';

class FullLoadingScreen extends StatelessWidget {
  const FullLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator()
      ),
    );
  }
}