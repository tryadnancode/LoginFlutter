import 'package:get/get.dart';
import 'package:login/screens/dashboard/Data/response_data.dart';

class DetailController extends GetxController {
  static DetailController get to => Get.find();
  final ResponseData listData = Get.arguments;
}
