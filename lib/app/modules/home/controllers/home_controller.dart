import 'package:get/get.dart';

import 'package:intl/date_symbol_data_local.dart';
import '../../../data/models/habit_model.dart';
import '../../../data/services/habit_service.dart';

class HomeController extends GetxController {
  final HabitService _habitService = Get.find<HabitService>();
  final habits = <HabitModel>[].obs;
  final isAllCompleted = false.obs;
  final currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id_ID', null);
    loadHabits();
  }

  void loadHabits() {
    habits.value = _habitService.habits;
    _checkAllCompleted();
  }

  void toggleHabit(String id) {
    _habitService.toggleHabitCompletion(id);
    loadHabits();
  }

  void _checkAllCompleted() {
    if (habits.isEmpty) {
      isAllCompleted.value = false;
      return;
    }
    isAllCompleted.value = habits.every((habit) => habit.isCompletedToday);
  }

  void changePage(int index) {
    currentIndex.value = index;
    switch (index) {
      case 0:
        Get.toNamed('/home');
        break;
      case 1:
        Get.toNamed('/statistics');
        break;
      case 2:
        Get.toNamed('/settings');
        break;
    }
  }
}
