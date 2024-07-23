import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/routes/app_routes.dart';
import 'package:login/screens/dashBoard/Data/auth_service.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      final data = await authService.login(
        usernameController.text,
        passwordController.text,
      );

      isLoading.value = false;

      if (data['message'] == null) {
        Get.toNamed(AppRoutes.overView);
      } else {
        _showErrorDialog(data['message']);
      }
    } else {
      if (kDebugMode) {
        print("Validation failed");
      }
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
}
