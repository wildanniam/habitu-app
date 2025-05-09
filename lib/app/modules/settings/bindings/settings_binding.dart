import 'package:get/get.dart';
import '../controllers/settings_controller.dart';
import '../../../data/services/habit_service.dart';
import '../../../core/controllers/theme_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HabitService>(() => HabitService());
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
