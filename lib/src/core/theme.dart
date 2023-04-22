import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData get darkTheme => ThemeData(
        fontFamily: GoogleFonts.rubik().fontFamily,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.redAccent.shade700,
          brightness: Brightness.dark,
        ),
      );
}
