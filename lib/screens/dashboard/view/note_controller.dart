import 'package:get/get.dart';
import 'package:login/api/auth_repo_task.dart';
import 'package:login/screens/login/data/response_data.dart';


class NoteController extends GetxController {
  var allTasks = <ResponseData>[].obs;
  var completedTasks = <ResponseData>[].obs;
  var pendingTasks = <ResponseData>[].obs;
  var isLoading = true.obs;
  var loginResponse = ResponseData(title: '', description: '').obs;
  static NoteController get to => Get.find();

  @override
  void onInit() {
    fetchTasks();
    super.onInit();
  }

  void fetchTasks() async {
    try {
      isLoading(true);
      var tasks = await AuthRepoTask.fetchTask();
      allTasks.assignAll(tasks);
      completedTasks
          .assignAll(tasks.where((task) => task.isCompleted ?? false).toList());
      pendingTasks
          .assignAll(tasks.where((task) => task.pinned ?? false).toList());
    } finally {
      isLoading(false);
    }
  }
  void createTask(String title, String description) async {
    try {
      await AuthRepoTask.createTask(title, description);
      fetchTasks();
    } catch (e) {
      Get.snackbar('Error', 'Failed to create task');
    }
  }
}
