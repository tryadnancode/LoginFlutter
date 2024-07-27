import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/api/ui_state.dart';
import 'package:login/screens/dashboard/Data/response_data.dart';

class AuthRepoTask {
  static const String url =
      'https://6690d550c0a7969efd9db690.mockapi.io/api/v1/tasks';

  static void fetchTask(Function(UiState<List<ResponseData>>) callback) async {
    callback.call(const Loading());
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      callback.call(Success(jsonResponse.map((task) => ResponseData.fromJson(task)).toList()));
    } else {
      callback.call(const Error('Failed to load tasks'));
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
  static Future<void> deleteNotes(String id) async {
    final response = await http.delete(Uri.parse('$url/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete Notes');
    }
  }
  static Future<void> updateNotes(String id, Map<String, dynamic> data) async {
    final updateUrl = '$url/$id';
    final response = await http.put(
      Uri.parse(updateUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update note');
    }
  }

}