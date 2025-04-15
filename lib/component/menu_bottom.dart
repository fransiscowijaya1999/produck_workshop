import 'package:flutter/material.dart';
import 'package:produck_workshop/prefs.dart';
import 'package:produck_workshop/screen/api_setting_screen.dart';
import 'package:produck_workshop/screen/project_history_screen.dart';
import 'package:produck_workshop/screen/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuBottom extends StatelessWidget {
  const MenuBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProjectHistoryScreen(),
                ),
              );
            },
            child: Icon(Icons.history),
          ),
          SizedBox(width: 10),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ApiSettingScreen(),
                ),
              );
            },
            child: Icon(Icons.settings),
          ),
          SizedBox(width: 10),
          TextButton(
            onPressed: () async {
              final SharedPreferencesAsync prefs = SharedPreferencesAsync();
              await prefs.setString(prefsApi['API_TOKEN']!, '');
              await prefs.setString(prefsApi['API_URL']!, '');
              await prefs.remove(prefsApi['POS_ID']!);

              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) => startScreenGenerator(),
                  ),
                  ModalRoute.withName('/')
                );
              }
            },
            child: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
