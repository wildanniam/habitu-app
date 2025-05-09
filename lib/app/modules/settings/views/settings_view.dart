import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengaturan',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // Dark Mode
                ListTile(
                  leading: Image.asset(
                    'assets/icons/moon.png',
                    width: 24,
                    height: 24,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  title: Text(
                    'Mode Gelap',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    ),
                  ),
                  trailing: Obx(() => Switch(
                        value: controller.isDarkMode.value,
                        onChanged: controller.toggleDarkMode,
                        activeColor: Colors.green[400],
                      )),
                ),
                const Divider(),

                // Reset Data
                ListTile(
                  leading: Image.asset(
                    'assets/icons/trash.png',
                    width: 24,
                    height: 24,
                    color: Colors.red[400],
                  ),
                  title: Text(
                    'Reset Data',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.red[400],
                    ),
                  ),
                  onTap: controller.resetHabits,
                ),
                const Divider(),

                // Versi App
                ListTile(
                  leading: Image.asset(
                    'assets/icons/info.png',
                    width: 24,
                    height: 24,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  title: Text(
                    'Versi Aplikasi',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    ),
                  ),
                  trailing: Obx(() => Text(
                        controller.appVersion.value,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      )),
                ),
              ],
            ),
          ),

          // Footer
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Made with ❤️ by Wildan',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
