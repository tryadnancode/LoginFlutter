import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/screens/dashboard/dialog/color_picker_dialog.dart';
import 'package:login/screens/detail/dialog/UpdateNoteDialog.dart';
import 'package:login/screens/detail/view/detail_controller.dart';

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
                // Open color picker dialog or other actions
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return AlertDialog(
                          actionsAlignment: MainAxisAlignment.start,
                          title: const Text('Note Color Picker'),
                          content: ColorPickerDialogContent(
                            onColorSelected: (Color color) {
                              setState(() {
                                // Update the background color when a color is selected
                                _selectedColor = color;
                              });
                            },
                          ),
                          backgroundColor: _selectedColor,
                          // Use the selected color
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Share'),
                              onPressed: () {
                                // Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
              child: const Icon(Icons.color_lens),
            ),
          ),
        ],
      ),
      body: Obx(() {
        // Get color from controller and ensure it's not null
        final colorHex = controller.listData.value.color ?? '#FFFFFF'; // Default to white
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
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
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
                        color: Colors.deepOrange,
                      ),
                    )),
                    const Divider(color: Colors.black, thickness: 2),
                    const SizedBox(height: 20),
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
                      child: Text(
                        '${controller.listData.value.updatedAt}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    )),
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
                  _updateNoteDialog(context, controller);
                },
                label: const Text(
                  "Update Notes",
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

  Future<void> _updateNoteDialog(BuildContext context, DetailController controller) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return UpdateNoteDialog(
          initialTitle: controller.listData.value.title ?? '',
          initialDescription: controller.listData.value.description ?? '',
          onUpdate: (title, description) {
            controller.updateNote(title, description);
          },
        );
      },
    );
  }
}

Color _selectedColor = Colors.green;