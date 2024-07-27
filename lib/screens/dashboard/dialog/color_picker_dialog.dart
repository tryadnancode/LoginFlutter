import 'package:flutter/material.dart';

class ColorPickerDialog extends StatelessWidget {
  final Color selectedColor;
  final ValueChanged<Color> onColorSelected;

   ColorPickerDialog({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });
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
  @override
  Widget build(BuildContext context) {
        return Stack(
          children: [
            Positioned(
              right: 10,
              top: 10,
              child: Material(
               type: MaterialType.transparency,
                child: Container(
                 width: 250,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),   color: Colors.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
}