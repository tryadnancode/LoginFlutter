import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login/screens/dashBoard/view/note_controller.dart';
import 'package:login/screens/dashboard/Data/response_data.dart';
import 'package:login/utils/extensions.dart';

class NoteCard extends StatelessWidget {
  final ResponseData task;
  final Function(ResponseData)? onDeleted;
  const NoteCard({super.key, required this.task,   this.onDeleted});
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
                style:   TextStyle(color: Theme.of(context).colorScheme.inverseSurface,fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      noteController.deleteTask(task.id.toString());

                     // onDeleted?.call(task);
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
