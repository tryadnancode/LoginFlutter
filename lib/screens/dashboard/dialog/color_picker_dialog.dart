import 'package:flutter/material.dart';

class ColorPickerDialog extends StatelessWidget {
  final Color selectedColor;
  final ValueChanged<Color> onColorSelected;

  const ColorPickerDialog({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.teal,
      Colors.cyan,
      const Color(0xFFFFCDD2),
      const Color(0xFFAD1457),
      const Color(0xFFCE93D8),
    ];

    return Builder(
      builder: (context) {
        return Stack(
          children: [
            Positioned(

              left: 25,
              child: Dialog(
                backgroundColor: Colors.white,
                //insetPadding: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SizedBox(
                 width: 150,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: IconButton(
                      //     icon: const Icon(Icons.close),
                      //     onPressed: () => Navigator.of(context).pop(),
                      //   ),
                      // ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Note Color', style: TextStyle(fontSize: 18,color: Colors.black)),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Wrap(
                              // spacing: 4.0,
                              // runSpacing: 4.0,
                              children: colors.map((color) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop(color);
                                    onColorSelected(color);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: color,
                                      radius: 16,
                                      // child: selectedColor == color
                                      //     ? const Icon(Icons.check, color: Colors.white)
                                      //     : null,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 5),
                            SwitchListTile(
                              title: const Text('Password',style: TextStyle(color: Colors.black),),
                              value: false,
                              onChanged: (bool value) {
                                // Handle switch change if needed
                              },
                              contentPadding: const EdgeInsets.symmetric(horizontal: 36),
                            ),
                            SwitchListTile(
                              title: const Text('Reminder',style: TextStyle(color: Colors.black),),
                              value: false,
                              onChanged: (bool value) {
                                // Handle switch change if needed
                              },
                              contentPadding: const EdgeInsets.symmetric(horizontal: 36),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Share',style: TextStyle(color: Colors.black),),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel',style: TextStyle(color: Colors.black),),
                          ),
                          // ElevatedButton(
                          //   onPressed: () => Navigator.of(context).pop(selectedColor),
                          //   child: const Text('Save'),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}
