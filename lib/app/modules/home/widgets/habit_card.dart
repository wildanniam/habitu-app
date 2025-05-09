import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import '../../../data/models/habit_model.dart';

class HabitCard extends StatelessWidget {
  final HabitModel habit;
  final VoidCallback onToggle;

  const HabitCard({
    super.key,
    required this.habit,
    required this.onToggle,
  });

  String _getCategoryEmoji(HabitCategory category) {
    switch (category) {
      case HabitCategory.health:
        return '🏥';
      case HabitCategory.productivity:
        return '📝';
      case HabitCategory.learning:
        return '📚';
      case HabitCategory.fitness:
        return '💪';
      case HabitCategory.mindfulness:
        return '🧘';
      case HabitCategory.other:
        return '✨';
    }
  }

  String _getCategoryName(HabitCategory category) {
    switch (category) {
      case HabitCategory.health:
        return 'Kesehatan';
      case HabitCategory.productivity:
        return 'Produktivitas';
      case HabitCategory.learning:
        return 'Pembelajaran';
      case HabitCategory.fitness:
        return 'Kebugaran';
      case HabitCategory.mindfulness:
        return 'Kesadaran';
      case HabitCategory.other:
        return 'Lainnya';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border(
            left: BorderSide(
              color: habit.tagColor.withAlpha(128),
              width: 4,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habit.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          _getCategoryEmoji(habit.category),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _getCategoryName(habit.category),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text('🔥'),
                        const SizedBox(width: 4),
                        Text(
                          '${habit.streakCount} hari',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onToggle,
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: habit.isCompletedToday
                      ? Lottie.asset(
                          'assets/animations/check.json',
                          repeat: false,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 24,
                            );
                          },
                        )
                      : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 2,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
