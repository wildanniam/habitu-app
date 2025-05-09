import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _storage = GetStorage();
  final _key = 'isDarkMode';

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  bool _loadThemeFromBox() => _storage.read(_key) ?? false;

  void saveTheme(bool isDarkMode) => _storage.write(_key, isDarkMode);

  void changeTheme(ThemeMode themeMode) {
    Get.changeThemeMode(themeMode);
    saveTheme(themeMode == ThemeMode.dark);
  }

  void toggleTheme() {
    changeTheme(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
  }
}
