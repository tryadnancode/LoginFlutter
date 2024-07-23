import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/screens/dashboard/dialog/color_picker_dialog.dart';
import 'package:login/screens/detail/view/detail_controller.dart';
// Import the color picker dialog

class NotesDetails extends StatelessWidget {
  NotesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DetailController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details",style: TextStyle(fontSize: 24),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: TextButton(
              onPressed: () {
                // Open color picker dialog
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
                              child: const Text('Delete'),
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
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 16),
              width: double.infinity,
              margin: const EdgeInsets.only(
                  top: 16, bottom: 100, left: 16, right: 16),
              decoration: BoxDecoration(
                color: Colors.white70,
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
                  const Divider(color: Colors.black,thickness: 2),
                  const SizedBox(height: 20),
                  // Add some space between the texts
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${DetailController.to.listData.description}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
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
          ),
        ],
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: FloatingActionButton.extended(
                onPressed: () {
                  // Your onPressed function
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
            const SizedBox(width: 16.0), // Spacing between buttons
            FloatingActionButton(
              onPressed: () {
                // Your onPressed function
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

  // Add a state for the selected color
  Color _selectedColor = Colors.green; // Default color
}
