import 'package:get/get.dart';
import 'package:login/screen/all_notes/view_all_controller.dart';

class ViewAllBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ViewAllController>(() => ViewAllController());

  }
}