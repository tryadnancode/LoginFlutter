import 'package:get/get.dart';
import 'package:login/auth/signup/view/signUp_controller.dart';

class SignupBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(() => SignupController());
  }

}