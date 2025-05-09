import 'package:get/get.dart';
import '../controllers/add_habit_controller.dart';
import '../../../data/services/habit_service.dart';

class AddHabitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HabitService>(() => HabitService());
    Get.lazyPut<AddHabitController>(() => AddHabitController());
  }
}
