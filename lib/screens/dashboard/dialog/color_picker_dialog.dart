import 'package:flutter/material.dart';

class ColorPickerDialogContent extends StatefulWidget {
  final Function(Color) onColorSelected;

  const ColorPickerDialogContent({super.key, required this.onColorSelected});

  @override
  _ColorPickerDialogContentState createState() => _ColorPickerDialogContentState();
}

class _ColorPickerDialogContentState extends State<ColorPickerDialogContent> {
  Color _selectedColor = Colors.green; // Default color
  bool _isPasswordEnabled = false;
  bool _isReminderEnabled = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Select Note Color',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          Wrap(
            spacing: 10.0,
            runSpacing: 10,
            children: <Color>[
              Colors.green,
              Colors.red,
              Colors.blue,
              Colors.orange,
              Colors.purple,
              Colors.yellow,
              Colors.pink,
              Colors.grey
            ].map((color) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = color;
                  });
                  widget.onColorSelected(color); // Notify parent of the selected color
                },
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: _selectedColor == color
                        ? Border.all(
                      color: Colors.black,
                      width: 3.0,
                    )
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text('Password'),
              Switch(
                value: _isPasswordEnabled,
                onChanged: (value) {
                  setState(() {
                    _isPasswordEnabled = value;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text('Reminder'),
              Switch(
                value: _isReminderEnabled,
                onChanged: (value) {
                  setState(() {
                    _isReminderEnabled = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}