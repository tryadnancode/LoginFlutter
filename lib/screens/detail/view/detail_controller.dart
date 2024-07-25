
import 'package:get/get.dart';
import 'package:login/api/auth_repo_task.dart';
import 'package:login/screens/dashboard/Data/response_data.dart';
import 'package:flutter/material.dart';
import 'package:login/screens/dashboard/dialog/color_picker_dialog.dart';
import 'package:login/screens/detail/dialog/update_noted_dialog.dart';

class DetailController extends GetxController {
  static DetailController get to => Get.find();

  // Initialize listData as Rx<ResponseData>
  final Rx<ResponseData> listData = (Get.arguments as ResponseData).obs;

  Future<void> updateNote(String title, String description) async {
    if (listData.value.id == null) {
      Get.snackbar('Error', 'Note ID is not available');
      return;
    }

    try {
      await AuthRepoTask.updateNotes(
        listData.value.id!,
        {'title': title, 'description': description},
      );

      // Update local data after successful update
      listData.value = listData.value.copyWith(
        title: title,
        description: description,
        updatedAt: DateTime.now().toIso8601String(), // Update timestamp
      );

      Get.snackbar('Success', 'Note updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update note');
    }
  }

  Future<void> updateColor(Color color) async {
    if (listData.value.id == null) {
      Get.snackbar('Error', 'Note ID is not available');
      return;
    }

    final colorHex = '#${color.value.toRadixString(16).substring(2).toUpperCase()}';

    try {
      await AuthRepoTask.updateNotes(
        listData.value.id!,
        {'color': colorHex},
      );

      // Update local data after successful update
      listData.value = listData.value.copyWith(
        color: colorHex,
        updatedAt: DateTime.now().toIso8601String(), // Update timestamp
      );

      Get.snackbar('Success', 'Color updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update color');
    }
  }

  void showUpdateNoteDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return UpdateNoteDialog(
          initialTitle: listData.value.title ?? '',
          initialDescription: listData.value.description ?? '',
          onUpdate: (title, description) {
            updateNote(title, description);
          },
        );
      },
    );
  }

  void showColorPickerDialog(BuildContext context, Color selectedColor) {
    showDialog<Color>(
      context: context,
      builder: (context) {
        return ColorPickerDialog(
          selectedColor: selectedColor,
          onColorSelected: (color) {
            selectedColor = color;
          },
        );
      },
    ).then((selectedColor) {
      if (selectedColor != null) {
        updateColor(selectedColor);
      }
    });
  }
}

