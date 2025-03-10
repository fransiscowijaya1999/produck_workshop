import 'package:flutter/material.dart';
import 'package:produck_workshop/prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiSettingScreen extends StatelessWidget {
  const ApiSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    final Future<String?> apiUrl = prefs.getString(prefsApi['API_URL']!);

    return Scaffold(
      body: Center(
        child: FutureBuilder<String?>(
          future: apiUrl,
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  if (snapshot.data != null) {
                    return ApiSettingForm(
                      apiUrl: snapshot.data!,
                    );
                  } else {
                    return const ApiSettingForm();
                  }
                }
            }
          }
        )
      ),
    );
  }
}

class ApiSettingForm extends StatefulWidget {
  const ApiSettingForm({
    super.key,
    this.apiUrl = ''
  });

  final String apiUrl;

  @override
  State<ApiSettingForm> createState() => _ApiSettingFormState();
}

class _ApiSettingFormState extends State<ApiSettingForm> {
  final apiUrlController = TextEditingController();
  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    apiUrlController.text = widget.apiUrl;
  }

  @override
  void dispose() {
    apiUrlController.dispose();
    super.dispose();
  }

  Future<void> saveSetting() async {
    setState(() {
      isSaving = true;
    });

    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    final apiUrl = apiUrlController.text;

    await prefs.setString('api_url', apiUrl);

    setState(() {
      isSaving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(controller: apiUrlController,),
      ElevatedButton(
        onPressed: isSaving ? null : saveSetting,
        child: isSaving ? const CircularProgressIndicator() : Text('Save')
      )
    ],);
  }
}