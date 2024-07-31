
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/screen/all_notes/view_all_controller.dart';
import 'package:login/routes/app_routes.dart';
import 'package:login/widgets/view_all_card.dart';

class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ViewAllController viewAllController = Get.put(ViewAllController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Notes'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Icon(Icons.search_rounded),
                ),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      viewAllController.updateSearchQuery(value);
                    },
                    onSubmitted: (value) async {
                      await viewAllController.executeSearch();
                    },
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      hintText: "Search your notes...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                if (viewAllController.isLoading.value && viewAllController.currentPage.value == 1) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (viewAllController.isError.value) {
                  return Center(child: Text('Error: ${viewAllController.errorMessage.value}'));
                }

                if (viewAllController.isSearching.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final tasksToShow = viewAllController.searchQuery.isEmpty
                    ? viewAllController.allTasks
                    : viewAllController.filteredTasks;

                if (tasksToShow.isEmpty) {
                  return const Center(child: Text('No tasks found.'));
                }

                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (!viewAllController.isLoading.value &&
                        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                      viewAllController.loadMoreTasks();
                      return true;
                    }
                    return false;
                  },
                  child: ListView.builder(
                    itemCount: tasksToShow.length + (viewAllController.isLoading.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == tasksToShow.length) {
                        return viewAllController.isLoading.value
                            ? const Center(child: CircularProgressIndicator())
                            : const SizedBox();
                      }
                      final task = tasksToShow[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.details, arguments: task);
                        },
                        child: ViewAllCard(task: task),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}


