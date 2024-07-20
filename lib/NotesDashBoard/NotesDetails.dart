import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/NotesDashBoard/DetailController.dart';

class NotesDetails extends StatelessWidget {
  const NotesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DetailController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        actions: [Padding(
          padding: const EdgeInsets.only(right: 30),
          child: TextButton(onPressed: () {

          }, child: const Text("Edit")),
        )],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 600,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              border: Border.all(width: 2, color: Colors.black),
            ),
            child: Column(
              children: [
                Text(
                  '${DetailController.to.listData.title}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                const SizedBox(height: 20), // Add some space between the texts
                Text(
                  '${DetailController.to.listData.description}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${DetailController.to.listData.updatedAt}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}