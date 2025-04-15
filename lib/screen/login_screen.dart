import 'package:flutter/material.dart';
import 'package:produck_workshop/http/client.dart';
import 'package:produck_workshop/prefs.dart';
import 'package:produck_workshop/screen/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login(BuildContext context) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    final String? apiUrl = await prefs.getString(prefsApi['API_URL']!);

    final username = usernameController.text;
    final password = passwordController.text;

    try {
      final res = await http.post(
        Uri.parse('$apiUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password
        })
      );

      final decoded = jsonDecode(res.body) as Map<String, dynamic>;
      if (decoded['isError'] != null) {
        throw decoded;
      }
      
      final token = decoded['result'];

      await prefs.setString(prefsApi['API_TOKEN']!, token);
      authorizeDio(token);

      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => startScreenGenerator(),
          ),
          ModalRoute.withName('/')
        );
      }
    } catch (error) {
      final snackBar = SnackBar(content: Text('Error: $error'));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ProDuck Workshop'),
              SizedBox(height: 16,),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username'
                ),
              ),
              SizedBox(height: 8,),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password'
                ),
              ),
              SizedBox(height: 16,),
              ElevatedButton(onPressed: () => login(context), child: Text('Login'))
            ],
          ),
        ),
      ),
    );
  }
}