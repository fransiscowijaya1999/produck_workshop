import 'package:flutter/material.dart';
import 'package:produck_workshop/screen/api_setting_screen.dart';

class MenuBottom extends StatelessWidget {
  const MenuBottom({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {},
            child: Icon(Icons.history),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ApiSettingScreen())
              );
            },
            child: Icon(Icons.settings)
          )
        ],
      ),
    );
  }
}