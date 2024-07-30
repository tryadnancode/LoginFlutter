import 'package:get/get.dart';
import 'package:login/api/auth_repo_task.dart';
import 'package:login/api/ui_state.dart';
import 'package:login/screen/dashboard/data/response_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/app_routes.dart';

// class NoteController extends GetxController {
//   Rx<UiState<List<ResponseData>>> allTasks =   Rx<UiState<List<ResponseData>>>(const None());
//  // Rx<UiState<List<ResponseData>>> allTasks =   const None<List<ResponseData>>().obs;
//   RxList<ResponseData> completedTasks = <ResponseData>[].obs;
//
//
//  // var completedTasks = <ResponseData>[].obs;
//   var pendingTasks = <ResponseData>[].obs;
//   var filteredTasks = <ResponseData>[].obs;
//   var searchQuery = ''.obs;
//  // var isLoading = true.obs;
//   var loginResponse = ResponseData(title: '', description: '').obs;
//
//   static NoteController get to => Get.find();
//
//   @override
//   void onInit() {
//     fetchTasks();
//     super.onInit();
//   }
//
//   void logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//     Get.offAllNamed(AppRoutes.login);
//   }
//
//   void fetchTasks() async {
//     AuthRepoTask.fetchTask((state) {
//       allTasks.value=state;
//       debugPrint("===============> $state");
//     });
//   }
//
//   void handleState(UiState<List<ResponseData>> state) {
//     if (state is Success) {
//      // isLoading(false);
//       List<ResponseData> tasks = (state as Success).data;
//
//       filteredTasks.assignAll(tasks); // Initially show all tasks
//       completedTasks.assignAll(
//           tasks.where((task) => task.isCompleted ?? false).toList());
//       pendingTasks.assignAll(
//           tasks.where((task) => task.pinned ?? false).toList());
//     } else if (state is Error) {
//     //  isLoading(false);
//       var error = (state as Error).msg;
//       Get.snackbar('Error', error);
//     } else if (state is Loading) {
//      // isLoading(true);
//     }
//   }
//
//   void createTask(String title, String description) async {
//     try {
//       await AuthRepoTask.createTask(title, description);
//       fetchTasks();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to create task');
//     }
//   }
//
//   void deleteTask(String id) async {
//    /* try {
//       await AuthRepoTask.deleteNotes(id);
//       allTasks.removeWhere((task) => task.id == id);
//       completedTasks.removeWhere((task) => task.id == id);
//       pendingTasks.removeWhere((task) => task.id == id);
//       filterTasks();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to delete task');
//     }*/
//   }
//
//   void updateSearchQuery(String query) {
//     searchQuery.value = query;
//     filterTasks();
//   }
//
//   void filterTasks() {
//   /*  if (searchQuery.isEmpty) {
//       filteredTasks.assignAll(allTasks);
//     } else {
//       filteredTasks.assignAll(
//           allTasks.where((task) =>
//           (task.title?.contains(searchQuery.value) ?? false) ||
//               (task.description?.contains(searchQuery.value) ?? false)).toList());
//     }*/
//   }
// }

class NoteController extends GetxController {
  Rx<UiState<List<ResponseData>>> allTasks =
      Rx<UiState<List<ResponseData>>>(const None());
  Rx<UiState<List<ResponseData>>> completedTasks =
      Rx<UiState<List<ResponseData>>>(const None());
  Rx<UiState<List<ResponseData>>> pendingTasks =
      Rx<UiState<List<ResponseData>>>(const None());
  RxList<ResponseData> filteredTasks = <ResponseData>[].obs;
  var searchQuery = ''.obs;
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
      allTasks.value = state;
      handleState(state); // Call handleState here
    });
  }

  void handleState(UiState<List<ResponseData>> state) {
    if (state is Success) {
      List<ResponseData> tasks = (state as Success).data;
      filteredTasks.assignAll(tasks); // Initially show all tasks
      completedTasks.value =
          Success(tasks.where((task) => task.isCompleted ?? false).toList());
      pendingTasks.value =
          Success(tasks.where((task) => task.pinned ?? false).toList());
    } else if (state is Error) {
      var error = (state as Error).msg;
      Get.snackbar('Error', error);
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

  // void deleteTask(String id) async {
  //   // Implement delete logic
  // }
  Future<void> deleteTask(String id) async {
    try {
      await AuthRepoTask.deleteNotes(id);
      fetchTasks();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete task');
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterTasks();
  }

  void filterTasks() {
    // Implement filter logic
  }
}

// class NoteController extends GetxController {
//   Rx<UiState<List<ResponseData>>> allTasks = Rx<UiState<List<ResponseData>>>(const None());
//   Rx<UiState<List<ResponseData>>> completedTasks = Rx<UiState<List<ResponseData>>>(const None());
//   Rx<UiState<List<ResponseData>>> pendingTasks = Rx<UiState<List<ResponseData>>>(const None());
//   RxList<ResponseData> filteredTasks = <ResponseData>[].obs;
//   var searchQuery = ''.obs;
//
//   static NoteController get to => Get.find();
//
//   @override
//   void onInit() {
//   fetchTasks();
//   super.onInit();
//   }
//
//   void logout() async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.clear();
//   Get.offAllNamed(AppRoutes.login);
//   }
//
//   Future<void> fetchTasks() async {
//   final prefs = await SharedPreferences.getInstance();
//   final userId = prefs.getString('username') ?? '';
//
//   AuthRepoTask.fetchTask(userId, (state) {
//   allTasks.value = state;
//   handleState(state);
//   });
//   }
//
//   void handleState(UiState<List<ResponseData>> state) {
//   if (state is Success) {
//   List<ResponseData> tasks = (state as Success).data;
//   filteredTasks.assignAll(tasks);
//   completedTasks.value = Success(
//   tasks.where((task) => task.isCompleted ?? false).toList());
//   pendingTasks.value =
//   Success(tasks.where((task) => task.pinned ?? false).toList());
//   } else if (state is Error) {
//   var error = (state as Error).msg;
//   Get.snackbar('Error', error);
//   }
//   }
//
//   Future<void> createTask(String title, String description) async {
//   final prefs = await SharedPreferences.getInstance();
//   final userId = prefs.getString('username') ?? '';
//
//   try {
//   await AuthRepoTask.createTask(title, description, userId);
//   fetchTasks();
//   } catch (e) {
//   Get.snackbar('Error', 'Failed to create task');
//   }
//   }
//
//   Future<void> deleteTask(String id) async {
//   try {
//   await AuthRepoTask.deleteTask(id);
//   fetchTasks();
//   } catch (e) {
//   Get.snackbar('Error', 'Failed to delete task');
//   }
//   }
//
//   void updateSearchQuery(String query) {
//   searchQuery.value = query;
//   filterTasks();
//   }
//
//   void filterTasks() {
//   if (searchQuery.isEmpty) {
//   filteredTasks.assignAll(allTasks.value is Success
//   ? (allTasks.value as Success).data
//       : []);
//   } else {
//   filteredTasks.assignAll(
//   allTasks.value is Success
//   ? (allTasks.value as Success)
//       .data
//       .where((task) =>
//   task.title.contains(searchQuery.value) ||
//   task.description.contains(searchQuery.value))
//       .toList()
//       : [],
//   );
//   }
//   }
// }
