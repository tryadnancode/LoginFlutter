import 'package:flutter/material.dart';

class NotesOverView extends StatelessWidget {
  const NotesOverView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('lib/assets/images/img_1.png')),
              ),
              VerticalDivider(width: 1.0),
              Expanded(
                  child: Center(
                child: Text(
                  "My Notes",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              )),
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
                    onPressed: () {}, icon: const Icon(Icons.search_rounded)),
                const Text("Search your notes.....")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
