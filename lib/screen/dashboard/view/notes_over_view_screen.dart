import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/api/ui_state.dart';
import 'package:login/routes/app_routes.dart';
import 'package:login/screen/dashboard/data/response_data.dart';
import 'package:login/screen/dashboard/dialog/create_dialog.dart';
import 'package:login/screen/dashboard/view/note_controller.dart';
import 'package:login/widgets/note_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesOverview extends StatelessWidget {
  const NotesOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final NoteController taskController = Get.put(NoteController());

    Future<void> refreshNotes() async {
      taskController.fetchTasks();
    }

    Future<String> getProfileImageUrl() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('profileImageUrl') ??
          'assets/images/img.png'; // Default image if not set
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: FutureBuilder<String>(
          future: getProfileImageUrl(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final profileImageUrl = snapshot.data;

            return Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: profileImageUrl != null
                            ? NetworkImage(profileImageUrl)
                            : const AssetImage('assets/images/img.png')
                        as ImageProvider,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "My Notes",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            taskController.logout();
                          },
                          icon: const Icon(Icons.logout),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.viewAll);
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.search),
                                SizedBox(width: 8), // Optional: Add some space between the icon and text
                                Text("Search your notes...."),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )

                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: refreshNotes,
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Obx(() {
                              if (taskController.allTasks.value is Success) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "All Notes",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.toNamed(AppRoutes.viewAll);
                                          },
                                          child: const Text("View All"),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else if (taskController.allTasks.value is Error) {
                                var error =
                                    (taskController.allTasks.value as Error).msg;
                                Get.snackbar('Error', error);
                                return Center(child: Text(error));
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                          ),
                          Obx(() {
                            if (taskController.allTasks.value is Success) {
                              List<ResponseData> tasks =
                                  (taskController.allTasks.value as Success).data;
                             return SliverGrid(
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                    final task = tasks[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.details, arguments: task);
                                      },
                                      child: NoteCard(task: task),
                                    );
                                  },
                                  childCount: tasks.length,
                                ),
                              );
                            } else if (taskController.allTasks.value is Error) {
                              var error =
                                  (taskController.allTasks.value as Error).msg;
                              Get.snackbar('Error', error);
                              return SliverToBoxAdapter(
                                  child: Center(child: Text(error)));
                            } else {
                              return const SliverToBoxAdapter(
                                 // child: Center(child: CircularProgressIndicator())
                              );
                            }
                          }),
                          const SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                "Completed Notes",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Obx(() {
                            if (taskController.completedTasks.value is Success) {
                              List<ResponseData> tasks =
                                  (taskController.completedTasks.value as Success).data;
                              return SliverGrid(
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                    final task = tasks[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.details, arguments: task);
                                      },
                                      child: NoteCard(task: task),
                                    );
                                  },
                                  childCount: tasks.length,
                                ),
                              );
                            } else if (taskController.completedTasks.value is Error) {
                              var error =
                                  (taskController.completedTasks.value as Error).msg;
                              Get.snackbar('Error', error);
                              return SliverToBoxAdapter(
                                  child: Center(child: Text(error)));
                            } else {
                              return const SliverToBoxAdapter(
                                  //child: Center(child: CircularProgressIndicator())
                              );
                            }
                          }),
                          const SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                "Pinned Notes",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Obx(() {
                            if (taskController.pendingTasks.value is Success) {
                              List<ResponseData> tasks =
                                  (taskController.pendingTasks.value as Success).data;
                              return SliverGrid(
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                    final task = tasks[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.details, arguments: task);
                                      },
                                      child: NoteCard(task: task),
                                    );
                                  },
                                  childCount: tasks.length,
                                ),
                              );
                            } else if (taskController.pendingTasks.value is Error) {
                              var error =
                                  (taskController.pendingTasks.value as Error).msg;
                              Get.snackbar('Error', error);
                              return SliverToBoxAdapter(
                                  child: Center(child: Text(error)));
                            }
                            else {
                              return const SliverToBoxAdapter(
                                // child: Center(child: CircularProgressIndicator())
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.dialog(CreateNotesDialog());
          },
          label: const Text(
            "Add new notes",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}



//
// class NotesOverview extends StatelessWidget {
//   const NotesOverview({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final NoteController taskController = Get.put(NoteController());
//
//     Future<void> refreshNotes() async {
//       taskController.fetchTasks();
//     }
//
//     Future<String> getProfileImageUrl() async {
//       final prefs = await SharedPreferences.getInstance();
//       return prefs.getString('profileImageUrl') ??
//           'assets/images/img.png';
//     }
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Theme.of(context).colorScheme.surface,
//         body: FutureBuilder<String>(
//           future: getProfileImageUrl(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             }
//
//             final profileImageUrl = snapshot.data;
//
//             return SingleChildScrollView(
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 child: Column(
//                   children: [
//                     Stack(
//                       children: [
//                         CircleAvatar(
//                           radius: 25,
//                           backgroundImage: profileImageUrl != null
//                               ? NetworkImage(profileImageUrl)
//                               : const AssetImage('assets/images/img.png')
//                           as ImageProvider,
//                         ),
//                         const Align(
//                           alignment: Alignment.center,
//                           child: Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text(
//                               "My Notes",
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.topRight,
//                           child: IconButton(
//                             onPressed: () {
//                               taskController.logout();
//                             },
//                             icon: const Icon(Icons.logout),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       margin: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: Colors.black12,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Row(
//                         children: [
//                           const Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Icon(Icons.search_rounded),
//                           ),
//                           Expanded(
//                             child: TextField(
//                               onChanged: (value) {
//                                 taskController.updateSearchQuery(value);
//                               },
//                               decoration: const InputDecoration(
//                                 hintText: "Search your notes.....",
//                                 border: InputBorder.none,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     RefreshIndicator(
//                       onRefresh: refreshNotes,
//                       child: SingleChildScrollView(
//                         physics: const NeverScrollableScrollPhysics(),
//                         child: Column(
//                           children: [
//                             Obx(() {
//                               if (taskController.allTasks.value is Success) {
//                                 List<ResponseData> tasks =
//                                     (taskController.allTasks.value as Success).data;
//                                 return Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         const Text(
//                                           "All Notes",
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         TextButton(
//                                           onPressed: () {
//                                             Get.toNamed(AppRoutes.viewAll);
//                                           },
//                                           child: const Text("View All"),
//                                         ),
//                                       ],
//                                     ),
//                                     GridView.builder(
//                                       shrinkWrap: true,
//                                       physics: const NeverScrollableScrollPhysics(),
//                                       gridDelegate:
//                                       const SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisCount: 2,
//                                         mainAxisSpacing: 10,
//                                         crossAxisSpacing: 10,
//                                       ),
//                                       itemCount: tasks.length,
//                                       itemBuilder: (context, index) {
//                                         final task = tasks[index];
//                                         return InkWell(
//                                           onTap: () {
//                                             Get.toNamed(AppRoutes.details,
//                                                 arguments: task);
//                                           },
//                                           child: NoteCard(task: task),
//                                         );
//                                       },
//                                     ),
//                                   ],
//                                 );
//                               } else if (taskController.allTasks.value is Error) {
//                                 var error =
//                                     (taskController.allTasks.value as Error).msg;
//                                 Get.snackbar('Error', error);
//                                 return Center(child: Text(error));
//                               } else {
//                                 return const Center(
//                                     child: CircularProgressIndicator());
//                               }
//                             }),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Padding(
//                                   padding: EdgeInsets.only(top: 20),
//                                   child: Text(
//                                     "Completed Notes",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                                 Obx(() {
//                                   if (taskController.completedTasks.isEmpty) {
//                                     return const Center(child: Text('No completed tasks'));
//                                   } else {
//                                     return GridView.builder(
//                                       shrinkWrap: true,
//                                       physics: const NeverScrollableScrollPhysics(),
//                                       gridDelegate:
//                                       const SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisCount: 2,
//                                         mainAxisSpacing: 10,
//                                         crossAxisSpacing: 10,
//                                       ),
//                                       itemCount: taskController.completedTasks.length,
//                                       itemBuilder: (context, index) {
//                                         final task = taskController.completedTasks[index];
//                                         return InkWell(
//                                           onTap: () {
//                                             Get.toNamed(AppRoutes.details,
//                                                 arguments: task);
//                                           },
//                                           child: NoteCard(task: task),
//                                         );
//                                       },
//                                     );
//                                   }
//                                 }),
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 const Padding(
//                                   padding: EdgeInsets.only(top: 20),
//                                   child: Text(
//                                     "Pinned Notes",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                                 GridView.builder(
//                                   shrinkWrap: true,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   gridDelegate:
//                                   const SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 2,
//                                     mainAxisSpacing: 10,
//                                     crossAxisSpacing: 10,
//                                   ),
//                                   itemCount: taskController.pendingTasks.length,
//                                   itemBuilder: (context, index) {
//                                     final task = taskController.pendingTasks[index];
//                                     return InkWell(
//                                       onTap: () {
//                                         Get.toNamed(AppRoutes.details,
//                                             arguments: task);
//                                       },
//                                       child: NoteCard(task: task),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton.extended(
//           onPressed: () {
//             Get.dialog(CreateNotesDialog());
//           },
//           label: const Text(
//             "Add new notes",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           icon: const Icon(
//             Icons.add,
//             color: Colors.white,
//           ),
//           backgroundColor: Colors.black,
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       ),
//     );
//   }
// }
