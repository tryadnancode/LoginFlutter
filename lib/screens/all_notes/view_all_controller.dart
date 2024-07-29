
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:login/screens/dashboard/Data/response_data.dart';
import 'package:login/api/ui_state.dart';

class ViewAllController extends GetxController {
  var allTasks = <ResponseData>[].obs;
  var currentPage = 1.obs;
  var isLoading = false.obs;
  var hasMoreData = true.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchTasks(page: currentPage.value);
    super.onInit();
  }

  Future<void> fetchTasks({required int page}) async {
    if (!hasMoreData.value) return;

    isLoading.value = true;
    isError.value = false;

    final url = 'https://6690d550c0a7969efd9db690.mockapi.io/api/v1/tasks?page=$page&limit=10';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final tasks = data.map((json) => ResponseData.fromJson(json)).toList();
        handleState(Success(tasks), page);
      } else {
        handleState(const Error('Failed to load tasks'), page);
      }
    } catch (e) {
      handleState(Error('An error occurred: $e'), page);
    }
  }

  void handleState(UiState<List<ResponseData>> state, int page) {
    if (state is Success) {
      isLoading.value = false;
      List<ResponseData> tasks = (state as Success<List<ResponseData>>).data;
      if (tasks.length<10) {
        hasMoreData.value = false;
      }
        if (page == 1) {
          allTasks.assignAll(tasks);
        } else {
          allTasks.addAll(tasks);
        }
        currentPage.value = page;

    } else if (state is Error) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = (state as Error).msg;
    } else if (state is Loading) {
      isLoading.value = true;
    }
  }

  void loadMoreTasks() {
    if (!isLoading.value && hasMoreData.value) {
      fetchTasks(page: currentPage.value + 1);
    }
  }
}

// import 'package:get/get.dart';
// import 'package:login/api/auth_repo_task.dart';
// import 'package:login/api/ui_state.dart';
// import 'package:login/screens/dashboard/Data/response_data.dart';
//
// class ViewAllController extends GetxController {
//   var allTasks = <ResponseData>[].obs;
//   var currentPage = 1.obs;
//   var isLoading = false.obs;
//   var hasMoreData = true.obs;
//   var isError = false.obs;
//   var errorMessage = ''.obs;
//
//   @override
//   void onInit() {
//     fetchTasks(page: currentPage.value);
//     super.onInit();
//   }
//
//   Future<void> fetchTasks({required int page}) async {
//     if (!hasMoreData.value) return;
//
//     isLoading.value = true;
//     isError.value = false;
//
//     AuthRepoTask.fetchTask(
//       (state) {
//         handleState(state, page);
//       },
//     );
//   }
//
//   void handleState(UiState<List<ResponseData>> state, int page) {
//     if (state is Success) {
//       isLoading.value = false;
//       List<ResponseData> tasks = (state as Success).data;
//       if (tasks.isEmpty) {
//         hasMoreData.value = false;
//       } else {
//         if (page == 1) {
//           allTasks.assignAll(tasks);
//         } else {
//           allTasks.addAll(tasks);
//         }
//         currentPage.value = page;
//       }
//     } else if (state is Error) {
//       isLoading.value = false;
//       isError.value = true;
//       errorMessage.value = (state as Error).msg;
//     } else if (state is Loading) {
//       isLoading.value = true;
//     }
//   }
//   void loadMoreTasks() {
//     if (!isLoading.value && hasMoreData.value) {
//       fetchTasks(page: currentPage.value + 1);
//     }
//   }
// }
