import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login/auth/data/login_response.dart';


class AuthService {
  final String baseUrl = 'https://dummyjson.com';

  void userLogin(String username, String password,
      Function(LoginResponse?, String?) callback) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      callback.call(LoginResponse.fromJson(jsonDecode(response.body)), null);
    } else {
      callback.call(
          null, jsonDecode(response.body)['message'] ?? 'Login failed');
    }
  }
}
