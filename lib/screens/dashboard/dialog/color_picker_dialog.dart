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
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.teal,
      Colors.cyan,
    ];

    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          const Text('Note Color', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: colors.map((color) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(color);
                        onColorSelected(color);
                      },
                      child: CircleAvatar(
                        backgroundColor: color,
                        radius: 16,
                        // child: selectedColor == color
                        //     ? const Icon(Icons.check, color: Colors.white)
                        //     : null,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                SwitchListTile(
                  title: const Text('Password'),
                  value: false,
                  onChanged: (bool value) {
                    // Handle switch change if needed
                  },
                ),
                SwitchListTile(
                  title: const Text('Reminder'),
                  value: false,
                  onChanged: (bool value) {
                    // Handle switch change if needed
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Share'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Delete'),
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
    );
  }
}
