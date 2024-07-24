import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/screens/dashboard/Data/response_data.dart';

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
  static Future<void> createTask(String title, String description) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': title, 'description': description}),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create task');
    }
  }
  Future<http.Response> delete(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }
}
