import 'package:get/get.dart';

class HomeController extends GetxController {
  final currentIndex = 0.obs;

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
