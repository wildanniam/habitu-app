import 'package:get/get.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/add_habit/add_habit_binding.dart';
import '../modules/add_habit/add_habit_view.dart';
import '../modules/statistics/statistics_binding.dart';
import '../modules/statistics/statistics_view.dart';
import '../modules/settings/settings_binding.dart';
import '../modules/settings/settings_view.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.addHabit,
      page: () => const AddHabitView(),
      binding: AddHabitBinding(),
    ),
    GetPage(
      name: Routes.statistics,
      page: () => const StatisticsView(),
      binding: StatisticsBinding(),
    ),
    GetPage(
      name: Routes.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
  ];
}
