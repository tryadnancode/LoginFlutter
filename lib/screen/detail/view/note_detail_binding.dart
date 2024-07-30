import 'package:get/get.dart';
import 'package:login/screens/detail/view/detail_controller.dart';


class NoteDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(() => DetailController());
  }
}