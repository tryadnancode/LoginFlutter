import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/screens/dashBoard/view/note_controller.dart';
import 'package:login/screens/dashboard/Data/response_data.dart';

class NoteCard extends StatelessWidget {
  final ResponseData task;

  const NoteCard({super.key, required this.task});



  @override
  Widget build(BuildContext context) {
    final NoteController noteController = Get.find();
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
              Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                task.title.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      noteController.deleteTask(task.id.toString());
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
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Text(
                "yesterday",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              SizedBox(width: 8),
              Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                '12 pm',
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
