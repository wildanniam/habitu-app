import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

enum HabitCategory {
  health,
  productivity,
  learning,
  fitness,
  mindfulness,
  other,
}

class HabitModel {
  final String id;
  final String name;
  final HabitCategory category;
  final Color tagColor;
  final int streakCount;
  final bool isCompletedToday;
  final DateTime createdAt;
  final DateTime? lastCompletedAt;
  final List<DateTime> completedDates;

  HabitModel({
    String? id,
    required this.name,
    required this.category,
    required this.tagColor,
    this.streakCount = 0,
    this.isCompletedToday = false,
    DateTime? createdAt,
    this.lastCompletedAt,
    List<DateTime>? completedDates,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        completedDates = completedDates ?? [];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category.index,
      'tagColor': tagColor.toARGB32(),
      'streakCount': streakCount,
      'isCompletedToday': isCompletedToday,
      'createdAt': createdAt.toIso8601String(),
      'lastCompletedAt': lastCompletedAt?.toIso8601String(),
      'completedDates':
          completedDates.map((date) => date.toIso8601String()).toList(),
    };
  }

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
      id: json['id'],
      name: json['name'],
      category: HabitCategory.values[json['category']],
      tagColor: Color(json['tagColor']),
      streakCount: json['streakCount'],
      isCompletedToday: json['isCompletedToday'],
      createdAt: DateTime.parse(json['createdAt']),
      lastCompletedAt: json['lastCompletedAt'] != null
          ? DateTime.parse(json['lastCompletedAt'])
          : null,
      completedDates: (json['completedDates'] as List<dynamic>?)
              ?.map((date) => DateTime.parse(date))
              .toList() ??
          [],
    );
  }

  HabitModel copyWith({
    String? name,
    HabitCategory? category,
    Color? tagColor,
    int? streakCount,
    bool? isCompletedToday,
    DateTime? lastCompletedAt,
    List<DateTime>? completedDates,
  }) {
    return HabitModel(
      id: id,
      name: name ?? this.name,
      category: category ?? this.category,
      tagColor: tagColor ?? this.tagColor,
      streakCount: streakCount ?? this.streakCount,
      isCompletedToday: isCompletedToday ?? this.isCompletedToday,
      createdAt: createdAt,
      lastCompletedAt: lastCompletedAt ?? this.lastCompletedAt,
      completedDates: completedDates ?? this.completedDates,
    );
  }
}
