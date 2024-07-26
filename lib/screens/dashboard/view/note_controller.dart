import 'package:get/get.dart';
import 'package:login/api/auth_repo_task.dart';
import 'package:login/api/ui_state.dart';
import 'package:login/screens/dashboard/Data/response_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_routes.dart';

class NoteController extends GetxController {
  var allTasks = <ResponseData>[].obs;
  var completedTasks = <ResponseData>[].obs;
  var pendingTasks = <ResponseData>[].obs;
  var filteredTasks = <ResponseData>[].obs;
  var searchQuery = ''.obs;
  var isLoading = true.obs;
  var loginResponse = ResponseData(title: '', description: '').obs;

  static NoteController get to => Get.find();

  @override
  void onInit() {
    fetchTasks();
    super.onInit();
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed(AppRoutes.login);
  }

  void fetchTasks() async {
    AuthRepoTask.fetchTask((state) {
      handleState(state);
    });
  }

  void handleState(UiState<List<ResponseData>> state) {
    if (state is Success) {
      isLoading(false);
      List<ResponseData> tasks = (state as Success).data;
      allTasks.assignAll(tasks);
      filteredTasks.assignAll(tasks); // Initially show all tasks
      completedTasks.assignAll(
          tasks.where((task) => task.isCompleted ?? false).toList());
      pendingTasks.assignAll(
          tasks.where((task) => task.pinned ?? false).toList());
    } else if (state is Error) {
      isLoading(false);
      var error = (state as Error).msg;
      Get.snackbar('Error', error);
    } else if (state is Loading) {
      isLoading(true);
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

  void deleteTask(String id) async {
    try {
      await AuthRepoTask.deleteNotes(id);
      allTasks.removeWhere((task) => task.id == id);
      completedTasks.removeWhere((task) => task.id == id);
      pendingTasks.removeWhere((task) => task.id == id);
      filterTasks();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete task');
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterTasks();
  }

  void filterTasks() {
    if (searchQuery.isEmpty) {
      filteredTasks.assignAll(allTasks);
    } else {
      filteredTasks.assignAll(
          allTasks.where((task) =>
          (task.title?.contains(searchQuery.value) ?? false) ||
              (task.description?.contains(searchQuery.value) ?? false)).toList());
    }
  }
}
