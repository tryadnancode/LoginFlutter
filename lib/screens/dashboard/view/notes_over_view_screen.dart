import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/routes/app_routes.dart';
import 'package:login/screens/dashBoard/dialog/create_dialog.dart';
import 'package:login/screens/dashBoard/view/note_controller.dart';
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
      return prefs.getString('profileImageUrl') ?? 'assets/images/default_profile.png'; // Default image if not set
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
                            : const AssetImage('assets/images/img.png') as ImageProvider,
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
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.search_rounded),
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              taskController.updateSearchQuery(value);
                            },
                            decoration: const InputDecoration(
                              hintText: "Search your notes.....",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Obx(() {
                      if (taskController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return RefreshIndicator(
                          onRefresh: refreshNotes,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "All Notes",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                  ),
                                  itemCount: taskController.filteredTasks.length,
                                  itemBuilder: (context, index) {
                                    final task = taskController.filteredTasks[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.details, arguments: task);
                                      },
                                      child: NoteCard(task: task),
                                    );
                                  },
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text(
                                    "Completed Notes",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                  ),
                                  itemCount: taskController.completedTasks.length,
                                  itemBuilder: (context, index) {
                                    final task = taskController.completedTasks[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.details, arguments: task);
                                      },
                                      child: NoteCard(task: task),
                                    );
                                  },
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text(
                                    "Pinned Notes",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                  ),
                                  itemCount: taskController.pendingTasks.length,
                                  itemBuilder: (context, index) {
                                    final task = taskController.pendingTasks[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.details, arguments: task);
                                      },
                                      child: NoteCard(task: task),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    }),
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

