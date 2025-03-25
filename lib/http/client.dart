import 'package:dio/dio.dart';

final dio = Dio();

void configureDio(
  String baseUrl
) {
  dio.options.baseUrl = baseUrl;
}

void authorizeDio(String token) {
  dio.options.headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
}