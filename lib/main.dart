import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:habitu/app/core/controllers/theme_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/light_theme.dart';
import 'app/theme/dark_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  final themeController = Get.put(ThemeController());

  runApp(
    GetMaterialApp(
      title: 'Habitu',
      theme: LightTheme.theme,
      darkTheme: DarkTheme.theme,
      themeMode: themeController.theme,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    ),
  );
}
