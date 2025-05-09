import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/habit_model.dart';
import 'dart:convert';

class HabitService extends GetxService {
  final _habitsKey = 'habits';
  final _habits = <HabitModel>[].obs;
  late SharedPreferences _prefs;

  List<HabitModel> get habits => _habits;

  @override
  Future<void> onInit() async {
    super.onInit();
    _prefs = await SharedPreferences.getInstance();
    _loadHabits();
  }

  void _loadHabits() {
    try {
      final String? storedData = _prefs.getString(_habitsKey);
      if (storedData != null) {
        final List<dynamic> decodedData = jsonDecode(storedData);
        _habits.value = decodedData
            .map((habitData) =>
                HabitModel.fromJson(Map<String, dynamic>.from(habitData)))
            .toList();
      }
    } catch (e) {
      _habits.value = [];
    }
  }

  Future<void> _saveHabits() async {
    try {
      final List<Map<String, dynamic>> habitsData =
          _habits.map((habit) => habit.toJson()).toList();
      final String encodedData = jsonEncode(habitsData);
      await _prefs.setString(_habitsKey, encodedData);
    } catch (e) {
      print('Error saving habits: $e');
    }
  }

  Future<void> addHabit(HabitModel habit) async {
    _habits.add(habit);
    await _saveHabits();
  }

  Future<void> updateHabit(HabitModel habit) async {
    final index = _habits.indexWhere((h) => h.id == habit.id);
    if (index != -1) {
      _habits[index] = habit;
      await _saveHabits();
      await resetDailyCompletion(); // Update streak setelah mengupdate habit
    }
  }

  Future<void> deleteHabit(String id) async {
    _habits.removeWhere((habit) => habit.id == id);
    await _saveHabits();
  }

  Future<void> toggleHabitCompletion(String id) async {
    final index = _habits.indexWhere((h) => h.id == id);
    if (index != -1) {
      final habit = _habits[index];
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      if (!habit.isCompletedToday) {
        // Menandai habit sebagai selesai
        final updatedHabit = habit.copyWith(
          isCompletedToday: true,
          lastCompletedAt: now,
          completedDates: [...habit.completedDates, now],
        );
        _habits[index] = updatedHabit;
      } else {
        // Membatalkan penyelesaian habit
        final updatedHabit = habit.copyWith(
          isCompletedToday: false,
          lastCompletedAt: null,
          completedDates: habit.completedDates.where((date) {
            final habitDate = DateTime(date.year, date.month, date.day);
            return !habitDate.isAtSameMomentAs(today);
          }).toList(),
        );
        _habits[index] = updatedHabit;
      }
      await _saveHabits();
    }
  }

  Future<void> resetDailyCompletion() async {
    for (var i = 0; i < _habits.length; i++) {
      final habit = _habits[i];
      final streakCount = _calculateStreak(habit.completedDates);
      _habits[i] = habit.copyWith(
        isCompletedToday: false,
        lastCompletedAt: null,
        completedDates: [],
        streakCount: streakCount,
      );
    }
    await _saveHabits();
  }

  int _calculateStreak(List<DateTime> completedDates) {
    if (completedDates.isEmpty) return 0;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final sortedDates = completedDates
        .map((date) => DateTime(date.year, date.month, date.day))
        .toList()
      ..sort((a, b) => b.compareTo(a));

    int streak = 0;
    DateTime? currentDate = today;

    for (final date in sortedDates) {
      if (currentDate == null) break;

      if (date.isAtSameMomentAs(currentDate)) {
        streak++;
        currentDate = currentDate.subtract(const Duration(days: 1));
      } else if (date.isBefore(currentDate)) {
        break;
      }
    }

    return streak;
  }

  Future<void> resetHabits() async {
    _habits.clear();
    await _saveHabits();
  }
}
