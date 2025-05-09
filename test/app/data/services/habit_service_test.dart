import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:habitu/app/data/models/habit_model.dart';
import 'package:habitu/app/data/services/habit_service.dart';
import 'package:fake_async/fake_async.dart';

void main() {
  late HabitService habitService;
  late SharedPreferences prefs;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  setUp(() async {
    await prefs.clear();
    habitService = HabitService();
    await habitService.onInit();
  });

  group('HabitService Tests', () {
    test('should add new habit', () async {
      final habit = HabitModel(
        name: 'Test Habit',
        category: HabitCategory.health,
        tagColor: Colors.blue,
      );

      await habitService.addHabit(habit);
      final habits = habitService.habits;
      expect(habits.length, 1);
      expect(habits[0].name, 'Test Habit');
    });

    test('should toggle habit completion', () async {
      final habit = HabitModel(
        name: 'Test Habit',
        category: HabitCategory.health,
        tagColor: Colors.blue,
      );

      await habitService.addHabit(habit);
      await habitService.toggleHabitCompletion(habit.id);

      final updatedHabit =
          habitService.habits.firstWhere((h) => h.id == habit.id);
      expect(updatedHabit.completedDates.length, 1);
    });

    test('should calculate streak correctly', () {
      fakeAsync((async) async {
        final habit = HabitModel(
          name: 'Test Habit',
          category: HabitCategory.health,
          tagColor: Colors.blue,
        );

        await habitService.addHabit(habit);

        // Complete habit for 3 consecutive days
        for (int i = 0; i < 3; i++) {
          async.elapse(const Duration(days: 1));
          await habitService.toggleHabitCompletion(habit.id);
        }

        final updatedHabit =
            habitService.habits.firstWhere((h) => h.id == habit.id);
        expect(updatedHabit.streakCount, 3);
      });
    });

    test('should reset habits', () async {
      final habit = HabitModel(
        name: 'Test Habit',
        category: HabitCategory.health,
        tagColor: Colors.blue,
      );

      await habitService.addHabit(habit);
      await habitService.toggleHabitCompletion(habit.id);
      await habitService.resetDailyCompletion();

      final updatedHabit =
          habitService.habits.firstWhere((h) => h.id == habit.id);
      expect(updatedHabit.completedDates.isEmpty, true);
    });
  });
}
