import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:login/NotesDashBoard/NoteController.dart';
import 'package:login/routes/app_routes.dart';
import 'package:login/widgets/NoteCard.dart';

class NotesOverView extends StatelessWidget {
  const NotesOverView({super.key});

  @override
  Widget build(BuildContext context) {
    final NoteController taskController = Get.put(NoteController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff3eae3),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Stack(
                children: [
                    CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/images/img.png')),
                  Align(
                      alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "My Notes",
                        style:
                            TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search_rounded)),
                    const Text("Search your notes.....")
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (taskController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "All Task",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemCount: taskController.allTasks.length,
                            itemBuilder: (context, index) {
                              final task = taskController.allTasks[index];
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(AppRoutes.details,arguments: task);
                                },
                                child: NoteCard(task: task),
                              );
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text("Completed Task",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemCount: taskController.completedTasks.length,
                            itemBuilder: (context, index) {
                              final task = taskController.completedTasks[index];
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(AppRoutes.details,arguments: task);
                                },
                                child: NoteCard(task: task),
                              );
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text("Pinned Task",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemCount: taskController.pendingTasks.length,
                            itemBuilder: (context, index) {
                              final task = taskController.pendingTasks[index];
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(AppRoutes.details,arguments: task);
                                },
                                child: NoteCard(task: task),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
