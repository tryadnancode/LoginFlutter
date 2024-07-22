
import 'package:flutter/material.dart';
import 'package:login/module/auth/data/response_data.dart';

class NoteCard extends StatelessWidget {
  final ResponseData task;

  const NoteCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            task.title.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            task.description.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Text(
                "yesterday",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(width: 8),
              Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                '12 pm',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}