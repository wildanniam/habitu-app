import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/habit_model.dart';

class HabitService extends GetxService {
  final _storage = GetStorage();
  final _habitsKey = 'habits';
  final _habits = <HabitModel>[].obs;

  List<HabitModel> get habits => _habits;

  @override
  void onInit() {
    super.onInit();
    _loadHabits();
  }

  void _loadHabits() {
    final List<dynamic>? storedHabits = _storage.read(_habitsKey);
    if (storedHabits != null) {
      _habits.value =
          storedHabits.map((habit) => HabitModel.fromJson(habit)).toList();
    }
  }

  void _saveHabits() {
    _storage.write(_habitsKey, _habits.map((habit) => habit.toJson()).toList());
  }

  void addHabit(HabitModel habit) {
    _habits.add(habit);
    _saveHabits();
  }

  void updateHabit(HabitModel habit) {
    final index = _habits.indexWhere((h) => h.id == habit.id);
    if (index != -1) {
      _habits[index] = habit;
      _saveHabits();
    }
  }

  void deleteHabit(String id) {
    _habits.removeWhere((habit) => habit.id == id);
    _saveHabits();
  }

  void toggleHabitCompletion(String id) {
    final index = _habits.indexWhere((h) => h.id == id);
    if (index != -1) {
      final habit = _habits[index];
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      // Jika habit belum di-complete hari ini
      if (!habit.isCompletedToday) {
        final lastCompleted = habit.lastCompletedAt;
        final yesterday = DateTime(today.year, today.month, today.day - 1);

        // Cek apakah terakhir complete kemarin
        if (lastCompleted != null &&
            DateTime(
              lastCompleted.year,
              lastCompleted.month,
              lastCompleted.day,
            ).isAtSameMomentAs(yesterday)) {
          // Increment streak
          _habits[index] = habit.copyWith(
            isCompletedToday: true,
            streakCount: habit.streakCount + 1,
            lastCompletedAt: now,
          );
        } else {
          // Reset streak jika tidak berurutan
          _habits[index] = habit.copyWith(
            isCompletedToday: true,
            streakCount: 1,
            lastCompletedAt: now,
          );
        }
      } else {
        // Uncheck habit
        _habits[index] = habit.copyWith(
          isCompletedToday: false,
          lastCompletedAt: null,
        );
      }
      _saveHabits();
    }
  }

  void resetDailyCompletion() {
    final now = DateTime.now();
    for (var i = 0; i < _habits.length; i++) {
      final habit = _habits[i];
      if (habit.isCompletedToday) {
        final lastCompleted = habit.lastCompletedAt;
        if (lastCompleted != null) {
          final lastCompletedDay = DateTime(
            lastCompleted.year,
            lastCompleted.month,
            lastCompleted.day,
          );
          final today = DateTime(now.year, now.month, now.day);

          // Jika terakhir complete bukan hari ini, reset status
          if (!lastCompletedDay.isAtSameMomentAs(today)) {
            _habits[i] = habit.copyWith(isCompletedToday: false);
          }
        }
      }
    }
    _saveHabits();
  }
}
