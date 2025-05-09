import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../controllers/add_habit_controller.dart';
import '../../../data/models/habit_model.dart';

class AddHabitView extends GetView<AddHabitController> {
  const AddHabitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Habit',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nama Habit
              Text(
                'Nama Habit',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Stack(
                children: [
                  TextField(
                    controller: controller.nameController,
                    style: GoogleFonts.poppins(),
                    decoration: InputDecoration(
                      hintText: 'Contoh: Minum Air 8 Gelas',
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.grey[400],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    top: 12,
                    child: Obx(() => controller.isTyping.value
                        ? Lottie.asset(
                            'assets/animations/writing.json',
                            width: 40,
                            height: 40,
                          )
                        : const SizedBox()),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Kategori
              Text(
                'Kategori',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => DropdownButtonFormField<HabitCategory>(
                    value: controller.selectedCategory.value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    items: HabitCategory.values.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(_getCategoryEmoji(category)),
                            const SizedBox(width: 8),
                            Text(
                              _getCategoryName(category),
                              style: GoogleFonts.poppins(),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.setCategory(value);
                      }
                    },
                  )),
              const SizedBox(height: 24),

              // Warna Tag
              Text(
                'Warna Tag',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(() => Row(
                      children: controller.availableColors.map((color) {
                        return GestureDetector(
                          onTap: () => controller.setColor(color),
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: controller.selectedColor.value == color
                                    ? Colors.black
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    )),
              ),
              const SizedBox(height: 24),

              // Reminder
              Obx(() => CheckboxListTile(
                    value: controller.wantReminder.value,
                    onChanged: (_) => controller.toggleReminder(),
                    title: Text(
                      'Ingin Reminder?',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  )),
              const SizedBox(height: 32),

              // Tombol Simpan
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.saveHabit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[100],
                    foregroundColor: Colors.green[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Simpan Habit',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

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
}
