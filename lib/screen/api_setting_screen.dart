import 'package:flutter/material.dart';
import 'package:produck_workshop/http/client.dart';
import 'package:produck_workshop/prefs.dart';
import 'package:produck_workshop/screen/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiSettingScreen extends StatelessWidget {
  const ApiSettingScreen({super.key, this.isStart = false});

  final bool isStart;

  @override
  Widget build(BuildContext context) {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    final Future<String?> apiUrl = prefs.getString(prefsApi['API_URL']!);

    return Scaffold(
      appBar: AppBar(
        title: Text('API Setting'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
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
                        isStart: isStart,
                      );
                    } else {
                      return const ApiSettingForm(isStart: false,);
                    }
                  }
              }
            }
          ),
        )
      ),
    );
  }
}

class ApiSettingForm extends StatefulWidget {
  const ApiSettingForm({
    super.key,
    this.apiUrl = '',
    required this.isStart
  });

  final String apiUrl;
  final bool isStart;

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
    configureDio(apiUrl);

    setState(() {
      isSaving = false;
    });

    if (widget.isStart) {
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => startScreenGenerator(),
          ),
          ModalRoute.withName('/')
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TextField(
        controller: apiUrlController,
        decoration: InputDecoration(
          labelText: 'API Endpoint'
        ),
      ),
      SizedBox(height: 10,),
      ElevatedButton(
        onPressed: isSaving ? null : saveSetting,
        child: isSaving ? const CircularProgressIndicator() : Text('Save')
      )
    ],);
  }
}