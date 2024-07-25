import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class UpdateNoteDialog extends StatelessWidget {
  final String initialTitle;
  final String initialDescription;
  final void Function(String title, String description) onUpdate;

  const UpdateNoteDialog({
    required this.initialTitle,
    required this.initialDescription,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
    TextEditingController(text: initialTitle);
    final TextEditingController descriptionController =
    TextEditingController(text: initialDescription);

    return AlertDialog(
      title: const Text('Update Note'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            maxLines: 5,
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
        ],
      ),
      actions: [

        TextButton(
          onPressed: () {
            // Navigator.of(context).pop();
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final title = titleController.text;
            final description = descriptionController.text;
            onUpdate(title, description);
            Navigator.of(context).pop();
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
