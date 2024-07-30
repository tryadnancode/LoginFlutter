import 'package:get/get.dart';
import 'package:login/screens/dashBoard/view/note_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoteController>(() => NoteController());
  }
}