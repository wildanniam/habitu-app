import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../../data/services/habit_service.dart';
import '../../../data/models/habit_model.dart';

class StatisticsController extends GetxController {
  final HabitService _habitService = Get.find<HabitService>();

  final totalHabits = 0.obs;
  final completedToday = 0.obs;
  final longestStreak = 0.obs;
  final completionRate = 0.0.obs;
  final selectedPeriod = 'Minggu'.obs;
  final periodOptions = ['Minggu', 'Bulan', 'Tahun'].obs;

  // Data untuk grafik
  final barGroups = <BarChartGroupData>[].obs;

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

    // Hitung tingkat penyelesaian hari ini
    if (totalHabits.value > 0) {
      final completedHabits = habits.where((h) => h.isCompletedToday).length;
      completionRate.value = (completedHabits / totalHabits.value) * 100;
    }

    _generateBarChartData();
  }

  void _generateBarChartData() {
    final now = DateTime.now();
    final habits = _habitService.habits;
    int daysToShow = 7;

    switch (selectedPeriod.value) {
      case 'Minggu':
        daysToShow = 7;
        break;
      case 'Bulan':
        daysToShow = 30;
        break;
      case 'Tahun':
        daysToShow = 365;
        break;
    }

    final List<BarChartGroupData> groups = [];
    final List<Color> pastelColors = [
      const Color(0xFFFFB3BA), // Pastel Pink
      const Color(0xFFFFDFBA), // Pastel Orange
      const Color(0x0fffffba), // Pastel Yellow
      const Color(0xFFBAFFC9), // Pastel Green
      const Color(0xFFBAE1FF), // Pastel Blue
    ];

    for (int i = 0; i < daysToShow; i++) {
      final date = now.subtract(Duration(days: daysToShow - 1 - i));
      final completions = _getCompletionsForDate(habits, date);

      // Hitung persentase penyelesaian untuk hari tersebut
      final completionPercentage =
          totalHabits.value > 0 ? (completions / totalHabits.value) * 100 : 0.0;

      // Gunakan warna yang berbeda untuk hari ini
      final isToday = DateFormat('yyyy-MM-dd').format(date) ==
          DateFormat('yyyy-MM-dd').format(now);

      groups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: completionPercentage,
              color: isToday
                  ? Get.theme.colorScheme.primary
                  : pastelColors[i % pastelColors.length],
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

  int _getCompletionsForDate(List<HabitModel> habits, DateTime date) {
    final dateStr = DateFormat('yyyy-MM-dd').format(date);
    return habits.fold(0, (sum, habit) {
      final isCompleted = habit.completedDates
          .any((d) => DateFormat('yyyy-MM-dd').format(d) == dateStr);
      return sum + (isCompleted ? 1 : 0);
    });
  }

  void changePeriod(String period) {
    selectedPeriod.value = period;
    _generateBarChartData();
  }

  String getFormattedPercentage(double value) {
    return '${value.toStringAsFixed(1)}%';
  }

  String getFormattedDate(int index) {
    final now = DateTime.now();
    final date = now.subtract(Duration(days: barGroups.length - 1 - index));
    return DateFormat('dd/MM').format(date);
  }
}
