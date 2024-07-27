import 'package:get/get.dart';
import 'package:login/api/auth_repo_task.dart';
import 'package:login/api/ui_state.dart';
import 'package:login/screens/dashboard/Data/response_data.dart';

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

    AuthRepoTask.fetchTask((state) {
      handleState(state, page);
    },
        //page: page
    ); // Pass page parameter
  }

  void handleState(UiState<List<ResponseData>> state, int page) {
    if (state is Success) {
      isLoading.value = false;
      List<ResponseData> tasks = (state as Success).data;
      if (tasks.isEmpty) {
        hasMoreData.value = false;
      } else {
        if (page == 1) {
          allTasks.assignAll(tasks);
        } else {
          allTasks.addAll(tasks);
        }
        currentPage.value = page;
      }
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
