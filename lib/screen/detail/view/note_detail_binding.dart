import 'package:get/get.dart';
import 'package:login/screen/detail/view/detail_controller.dart';


class NoteDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(() => DetailController());
  }
}