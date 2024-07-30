import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/screen/detail/view/detail_controller.dart';
import 'package:login/utils/extensions.dart';

class NotesDetails extends StatelessWidget {
  const NotesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailController controller = Get.put(DetailController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Details",
          style: TextStyle(fontSize: 24),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () {
                controller.showColorPickerDialog(context, _selectedColor);
              },
              child: const Icon(Icons.color_lens),
            ),
          ),
        ],
      ),
      body: Obx(() {
        // Get color from controller and ensure it's not null
        final colorHex =
            controller.listData.value.color ?? '#FFFFFF'; // Default to white
        final color = Color(int.parse(colorHex.replaceFirst('#', '0xFF')));

        return Column(
          children: [
            Expanded(
              child: Container(
                // Apply color to the container
                padding: const EdgeInsets.only(top: 16),
                width: double.infinity,
                margin: const EdgeInsets.only(
                    top: 16, bottom: 100, left: 16, right: 16),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(width: 2, color: Colors.black),
                ),
                child: Column(
                  children: [
                    Obx(() => Text(
                      '${controller.listData.value.title}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )),
                    const Divider(color: Colors.black, thickness: 2),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${controller.listData.value.description}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            )),
                            const SizedBox(height: 20),
                            Obx(() => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  controller.listData.value.updatedAt
                                      .toDateTime()
                                      ?.toDateString() ??
                                      '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Expanded(
              child: FloatingActionButton.extended(
                onPressed: () {
                  controller.showUpdateNoteDialog(context);
                },
                label: const Text(
                  "Edit Notes",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.black,
              ),
            ),
            const SizedBox(width: 16.0),
            FloatingActionButton(
              onPressed: () {
                // Action for photo button
              },
              backgroundColor: Colors.black,
              child: const Icon(Icons.photo, color: Colors.white),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Color _selectedColor = Colors.green;