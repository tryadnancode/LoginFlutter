
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/login/LoginController.dart';
import 'package:login/routes/AppRoutes.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login as Student"),
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            key: _loginController.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.all(50),
                  child: Image.asset("lib/assets/images/img.png"),
                ),
                TextFormField(
                  controller: _loginController.usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Username',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: _loginController.validateUsername,
                ),
                const SizedBox(height: 16),
                Obx(
                      () => TextFormField(
                    controller: _loginController.passwordController,
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _loginController.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          _loginController.isPasswordVisible.value =
                          !_loginController.isPasswordVisible.value;
                        },
                      ),
                    ),
                    obscureText: !_loginController.isPasswordVisible.value,
                    validator: _loginController.validatePassword,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      if (kDebugMode) {
                        print("Pressed!!");
                      }
                    },
                    child: const Text("Forgot Password"),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                      () => Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amberAccent,
                    ),
                    child: TextButton(
                      onPressed: _loginController.isLoading.value
                          ? null
                          : _loginController.login,
                      child: _loginController.isLoading.value
                          ? const CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.black),
                      )
                          : const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text("Don't have an account?"),
                    ),
                    Align(
                      child: TextButton(
                        onPressed: () {
                         Get.toNamed(AppRoutes.signup);
                        },
                        child: const Text("Register here"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
