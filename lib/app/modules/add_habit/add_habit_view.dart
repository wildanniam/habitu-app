import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_habit_controller.dart';

class AddHabitView extends GetView<AddHabitController> {
  const AddHabitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Habit')),
      body: const Center(child: Text('Add Habit Page')),
    );
  }
}
