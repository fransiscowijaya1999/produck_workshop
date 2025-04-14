import 'package:flutter/material.dart';
import 'package:produck_workshop/http/client.dart';
import 'package:produck_workshop/prefs.dart';
import 'package:produck_workshop/screen/api_setting_screen.dart';
import 'package:produck_workshop/screen/full_loading_screen.dart';
import 'package:produck_workshop/screen/login_screen.dart';
import 'package:produck_workshop/screen/pos_selection_screen.dart';
import 'package:produck_workshop/screen/worklist_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, String>> getStartupPrefs() async {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  final String apiUrl = await prefs.getString(prefsApi['API_URL']!) ?? '';
  final String apiToken = await prefs.getString(prefsApi['API_TOKEN']!) ?? '';
  final int? posId = await prefs.getInt(prefsApi['POS_ID']!);

  configureDio(apiUrl);
  authorizeDio(apiToken);

  return {
    'API_URL': apiUrl,
    'API_TOKEN': apiToken,
    'POS_ID': posId != null ? posId.toString() : ''
  };
}

Widget startScreenGenerator() {
  return FutureBuilder<Map<String, String>>(
    future: getStartupPrefs(),
    builder: (BuildContext context, AsyncSnapshot<Map<String, String>> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
          return const FullLoadingScreen();
        case ConnectionState.active:
        case ConnectionState.done:
          if (snapshot.hasError) {
            return StartScreen(message: 'Error: ${snapshot.error}');
          } else {
            if (snapshot.data!['API_URL']!.isEmpty) {
              return const ApiSettingScreen();
            } else if (snapshot.data!['API_TOKEN']!.isEmpty) {
              return const LoginScreen();
            } else if (snapshot.data!['POS_ID']!.isEmpty) {
              return const PosSelectionScreen(
                posId: null,
              );
            } else {
              return const WorklistLayout();
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