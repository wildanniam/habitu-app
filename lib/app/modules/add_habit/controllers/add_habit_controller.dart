import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/habit_model.dart';
import '../../../data/services/habit_service.dart';

class AddHabitController extends GetxController {
  final HabitService _habitService = Get.find<HabitService>();

  final nameController = TextEditingController();
  final selectedCategory = HabitCategory.health.obs;
  final selectedColor = Rx<Color>(Colors.blue);
  final wantReminder = false.obs;
  final isTyping = false.obs;

  final List<Color> availableColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.pink,
  ];

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(_onTextChanged);
  }

  @override
  void onClose() {
    nameController.removeListener(_onTextChanged);
    nameController.dispose();
    super.onClose();
  }

  void _onTextChanged() {
    isTyping.value = nameController.text.isNotEmpty;
  }

  void setCategory(HabitCategory category) {
    selectedCategory.value = category;
  }

  void setColor(Color color) {
    selectedColor.value = color;
  }

  void toggleReminder() {
    wantReminder.value = !wantReminder.value;
  }

  void saveHabit() {
    if (nameController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Nama habit tidak boleh kosong',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
      return;
    }

    final habit = HabitModel(
      name: nameController.text,
      category: selectedCategory.value,
      tagColor: selectedColor.value,
    );

    _habitService.addHabit(habit);

    Get.snackbar(
      'Sukses',
      'Habit berhasil ditambahkan',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green[100],
      colorText: Colors.green[900],
      duration: const Duration(seconds: 2),
    );

    Get.offAllNamed('/home');
  }
}
