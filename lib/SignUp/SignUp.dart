import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:login/routes/AppRoutes.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(
                top: 30,
                left: 30,
              ),
              child: const Text(
                "Create \nYour Account",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )),
          SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.asset("lib/assets/images/img_1.png")),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, bottom: 10, top: 10),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              hintText: "Enter first name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              filled: true,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              hintText: "Enter last name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              filled: true,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10)
                          ],
                          decoration: InputDecoration(
                              hintText: "Phone number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              filled: true,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6)
                          ],
                          decoration: InputDecoration(
                              hintText: "Enter six digit code",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              filled: true,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              suffixIcon: Container(
                                margin: const EdgeInsets.only(
                                  right: 20,
                                ),
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text("Resend"),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20)),
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "SignUp",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            onPressed: () {
                              //Get.toNamed(AppRoutes.login);
                              Get.back();
                            },
                            child: const Text(
                              "SignIn",
                              style: TextStyle(color: Colors.black),
                            ))
                      ],
                    ),
                  )))
        ],
      ),
    );
  }
}
