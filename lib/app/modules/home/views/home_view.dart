import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';
import '../controllers/home_controller.dart';
import '../widgets/habit_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat Pagi';
    } else if (hour < 15) {
      return 'Selamat Siang';
    } else if (hour < 19) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }

  String _getFormattedDate() {
    try {
      return DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.now());
    } catch (e) {
      // Jika masih belum terinisialisasi, inisialisasi dulu
      initializeDateFormatting('id_ID', null);
      return DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_getGreeting()}, Wildan!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _getFormattedDate(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Obx(() {
                  if (controller.habits.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assets/animations/empty.json',
                            width: 200,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.inbox,
                                size: 64,
                                color: Colors.grey[400],
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Belum ada habit',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Stack(
                    children: [
                      ListView.builder(
                        itemCount: controller.habits.length,
                        itemBuilder: (context, index) {
                          final habit = controller.habits[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: HabitCard(
                              habit: habit,
                              onToggle: () => controller.toggleHabit(habit.id),
                            ),
                          );
                        },
                      ),
                      if (controller.isAllCompleted.value)
                        Center(
                          child: Lottie.asset(
                            'assets/animations/congrats.json',
                            repeat: false,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.celebration,
                                size: 64,
                                color: Colors.amber,
                              );
                            },
                          ),
                        ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Statistik',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Pengaturan',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add-habit'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
