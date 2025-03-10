import 'package:flutter/material.dart';
import 'package:produck_workshop/prefs.dart';
import 'package:produck_workshop/screen/api_setting_screen.dart';
import 'package:produck_workshop/screen/full_loading_screen.dart';
import 'package:produck_workshop/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget startScreenGenerator() {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  final Future<String?> apiUrl = prefs.getString(prefsApi['API_URL']!);

  return FutureBuilder<String?>(
    future: apiUrl,
    builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
          return const FullLoadingScreen();
        case ConnectionState.active:
        case ConnectionState.done:
          if (snapshot.hasError) {
            return StartScreen(message: 'Error: ${snapshot.error}');
          } else {
            if (snapshot.data != null) {
              return LoginScreen();
            } else {
              return ApiSettingScreen();
            }
          }
      }
    }
  );
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key, this.message = ''});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(message)
      ),
    );
  }
}