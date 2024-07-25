import 'package:get/get.dart';
import 'package:login/api/auth_repo_task.dart';
import 'package:login/screens/dashboard/Data/response_data.dart';

class DetailController extends GetxController {
  static DetailController get to => Get.find();

  // Initialize listData as Rx<ResponseData>
  final Rx<ResponseData> listData = (Get.arguments as ResponseData).obs;

  Future<void> updateNote(String title, String description) async {
    if (listData.value.id == null) {
      Get.snackbar('Error', 'Note ID is not available');
      return;
    }

    try {
      await AuthRepoTask.updateNotes(
        listData.value.id!,
        {'title': title, 'description': description},
      );

      // Update local data after successful update
      listData.value = listData.value.copyWith(
        title: title,
        description: description,
        updatedAt: DateTime.now().toIso8601String(), // Update timestamp
      );

      Get.snackbar('Success', 'Note updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update note');
    }
  }
}
