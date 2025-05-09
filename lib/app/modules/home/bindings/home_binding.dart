import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../data/services/habit_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HabitService>(() => HabitService());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
