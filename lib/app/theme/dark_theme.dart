import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DarkTheme {
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF9B6B9E), // Dark Violet
          secondary: Color(0xFF7FB3D5), // Soft Neon Blue
          surface: Color(0xFF2D2D2D),
          error: Color(0xFFFFB3BA), // Pastel Red
        ),
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF2D2D2D),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        cardTheme: const CardThemeData(
          color: Color(0xFF2D2D2D),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
          ),
          bodyMedium: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const Color(0xFF7FB3D5);
            }
            return Colors.grey;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const Color(0xFF7FB3D5).withAlpha(128);
            }
            return Colors.grey.withAlpha(128);
          }),
        ),
        dividerTheme: const DividerThemeData(
          color: Color(0xFF404040),
          thickness: 1,
        ),
      );
}
