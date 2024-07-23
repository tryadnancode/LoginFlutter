import 'package:get/get.dart';
import 'package:login/screens/login/data/response_data.dart';

class DetailController extends GetxController {
  static DetailController get to => Get.find();
  final ResponseData listData = Get.arguments;
}
