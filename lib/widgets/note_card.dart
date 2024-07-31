import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/screen/dashboard/data/response_data.dart';
import 'package:login/screen/dashboard/view/note_controller.dart';
import 'package:login/utils/extensions.dart';

class NoteCard extends StatelessWidget {
  final ResponseData task;
  final Function(ResponseData)? onDeleted;
  const NoteCard({super.key, required this.task,   this.onDeleted});
  @override
  Widget build(BuildContext context) {
    final NoteController noteController = Get.find();

    void confirmDelete() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Delete'),
            content: const Text('Are you sure you want to delete this task?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  noteController.deleteTask(task.id.toString());
                  Navigator.of(context).pop(); // Close the dialog
                  if (onDeleted != null) {
                    onDeleted!(task);
                  }
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }

    return Container(
      width: double.infinity,
      // height: 100,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          // color: Colors.white70,
          color: task.getColor(),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  task.title.toString(),
                  style:   TextStyle(color: Theme.of(context).colorScheme.inverseSurface,fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      confirmDelete();
                    },
                    icon: const Icon(Icons.delete)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            task.description.toString(),
            style:   TextStyle(color: Theme.of(context).colorScheme.inverseSurface, fontSize: 14),
          ),
          const SizedBox(height: 8),
            Text(
              task.updatedAt?.toDateTime()?.toDateString()??'',
              style: const TextStyle(  fontSize: 12),
            ),
        ],
      ),
    );
  }
}
