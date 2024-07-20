import 'package:get/get.dart';
import 'package:login/AuthRepoTask.dart';
import 'package:login/ResponseData.dart';

class DetailController extends GetxController {
  static DetailController get to => Get.find();
  final ResponseData listData = Get.arguments;
}
