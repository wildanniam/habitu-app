import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../data/services/habit_service.dart';

class StatisticsController extends GetxController {
  final HabitService _habitService = Get.find<HabitService>();

  final totalHabits = 0.obs;
  final completedToday = 0.obs;
  final longestStreak = 0.obs;
  final barGroups = <BarChartGroupData>[].obs;
  final showTooltip = false.obs;
  final tooltipIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadStatistics();
    ever(_habitService.habits.obs, (_) => _loadStatistics());
  }

  void _loadStatistics() {
    final habits = _habitService.habits;
    totalHabits.value = habits.length;
    completedToday.value = habits.where((h) => h.isCompletedToday).length;
    longestStreak.value =
        habits.fold(0, (max, h) => h.streakCount > max ? h.streakCount : max);
    _generateBarChartData();
  }

  void _generateBarChartData() {
    final List<BarChartGroupData> groups = [];
    final List<Color> pastelColors = [
      const Color(0xFFFFB3BA), // Pastel Pink
      const Color(0xFFFFDFBA), // Pastel Orange
      const Color(0x0fffffba), // Pastel Yellow
      const Color(0xFFBAFFC9), // Pastel Green
      const Color(0xFFBAE1FF), // Pastel Blue
    ];

    // Generate dummy data for the last 7 days
    for (int i = 0; i < 7; i++) {
      groups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: (i + 1) * 2.0, // Dummy data
              color: pastelColors[i % pastelColors.length],
              width: 20,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(6)),
            ),
          ],
        ),
      );
    }

    barGroups.value = groups;
  }

  void showBarTooltip(int index) {
    tooltipIndex.value = index;
    showTooltip.value = true;
  }

  void hideBarTooltip() {
    showTooltip.value = false;
  }
}
