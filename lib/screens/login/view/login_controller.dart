import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/routes/app_routes.dart';
import 'package:login/screens/dashBoard/Data/auth_service.dart';
import 'package:login/screens/login/data/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var loginResponse = LoginResponse(token: '', email: '').obs;


  static LoginController get to => Get.find();

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
        authService.userLogin(usernameController.text, passwordController.text,
          (data, error) {
        isLoading.value = false;
        if (error == null) {
          saveLoginData(data!!);
        } else {
          _showErrorDialog(error!!);
        }
      });
    } else {
      if (kDebugMode) {
        print("Validation failed");
      }
    }
  }

  void saveLoginData(LoginResponse response) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', response.token ?? '');
    await prefs.setString('username', response.email ?? '');
    Get.offAndToNamed(AppRoutes.overView);

  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final username = prefs.getString('username');
    if (token != null && username != null) {
      loginResponse.value = LoginResponse(token: token, email: username);
      Get.offAllNamed(AppRoutes.overView);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }



  void _showErrorDialog(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

// @override
// void onClose() {
//   usernameController.dispose();
//   passwordController.dispose();
//   super.onClose();
// }
}
