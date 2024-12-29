import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData.dark().copyWith(
    primaryColor: const Color(0xFFE98316),
    scaffoldBackgroundColor: const Color(0xFF161819),
    dividerColor: const Color(0xFF0D0D0D),
    textTheme: GoogleFonts.ubuntuTextTheme().apply(
      bodyColor: const Color(0xFF8A8B8B),
      displayColor: const Color(0xFF8A8B8B),
    ),
    canvasColor: const Color(0xFF2B2D2E),
    cardColor: const Color(0xFF1F2123),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFE98316),
      secondary: Color(0xFF206EFF),
      onPrimary: Colors.white,
      surface: Color(0xFF1F2123),
      onSurface: Color(0xFF8A8B8B),
    ));

final lightTheme = ThemeData.light().copyWith(
  primaryColor: const Color(0xFFE98316),
  scaffoldBackgroundColor: Colors.white,
  textTheme: GoogleFonts.ubuntuTextTheme().apply(
    bodyColor: Colors.black,
    displayColor: Colors.black,
  ),
);
