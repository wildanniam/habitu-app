import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/controllers/theme_controller.dart';
import '../../../data/services/habit_service.dart';

class SettingsController extends GetxController {
  final HabitService _habitService = Get.find<HabitService>();
  final ThemeController _themeController = Get.find<ThemeController>();

  final isDarkMode = false.obs;
  final appVersion = '1.0.0'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  void _loadSettings() {
    isDarkMode.value = _themeController.theme == ThemeMode.dark;
  }

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    _themeController.changeTheme(value ? ThemeMode.dark : ThemeMode.light);
  }

  void resetHabits() {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Reset Data',
          style: Get.textTheme.titleLarge,
        ),
        content: Text(
          'Apakah Anda yakin ingin menghapus semua data habit?',
          style: Get.textTheme.bodyLarge,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Batal',
              style: Get.textTheme.bodyLarge?.copyWith(
                color: Get.theme.colorScheme.primary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _habitService.resetHabits();
              Get.back();
              Get.snackbar(
                'Sukses',
                'Data habit berhasil direset',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Get.theme.colorScheme.secondary.withAlpha(26),
                colorText: Get.theme.colorScheme.secondary,
              );
            },
            child: Text(
              'Reset',
              style: Get.textTheme.bodyLarge?.copyWith(
                color: Get.theme.colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
