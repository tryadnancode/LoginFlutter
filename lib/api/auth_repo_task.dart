import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/module/auth/data/response_data.dart';



class AuthRepoTask {
  static const String url =
      'https://6690d550c0a7969efd9db690.mockapi.io/api/v1/tasks';

  static Future<List<ResponseData>> fetchTask() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((task) => ResponseData.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }
}
