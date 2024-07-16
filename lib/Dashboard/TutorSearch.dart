import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:login/routes/AppRoutes.dart';

class TutorSearch extends StatelessWidget {
  const TutorSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-learning"),
        actions: <Widget>[
          IconButton(onPressed: () {
            Get.toNamed(AppRoutes.overView);
          }, icon: const Icon(Icons.filter_list)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_active))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.search_rounded)),
                  const Text("Finding Tutor")
                ],
              ),
            ),
            Container(
              height: 160,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.lightGreen, borderRadius: BorderRadius.circular(20)),
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "What do you want \nto learn today ?",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontStyle: FontStyle.italic),
                  ),
                  Expanded(
                    child: Image.asset(
                      'lib/assets/images/img_2.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Looking Tutor For",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const TextField(
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                      labelText: "Please enter subject",
                      border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(20),
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const TextField(
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                      labelText: "Please select class",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const TextField(
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                      labelText: "Enter university",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const TextField(
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                      labelText: "Please select location",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                        onPressed: () {},
                        child: const Center(child: Text("Find a tutor",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),))),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
