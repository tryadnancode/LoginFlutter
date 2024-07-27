// import 'package:flutter/material.dart';
//
// class ViewAllScreen extends StatelessWidget {
//
//   const ViewAllScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        body: SafeArea(
//          child: Padding(
//            padding: const EdgeInsets.all(12),
//            child: Container(
//               width: double.infinity,
//               height: 200,
//               decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
//                   color: Colors.orange
//               ),
//              child: const Column(
//                 children: [
//
//                 ],
//              ),
//             ),
//          ),
//        )
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/screens/all_notes/view_all_controller.dart';
import 'package:login/widgets/note_card.dart';
import 'package:login/routes/app_routes.dart';

class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ViewAllController viewAllController = Get.put(ViewAllController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Notes'),
          backgroundColor: Colors.black,
        ),
        body: Obx(() {
          if (viewAllController.isLoading.value && viewAllController.currentPage.value == 1) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewAllController.isError.value) {
            return Center(child: Text('Error: ${viewAllController.errorMessage.value}'));
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
              itemCount: viewAllController.allTasks.length + 1,
              itemBuilder: (context, index) {
                if (index == viewAllController.allTasks.length) {
                  return viewAllController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox();
                }

                final task = viewAllController.allTasks[index];
                return InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.details, arguments: task);
                  },
                  child: NoteCard(task: task),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}