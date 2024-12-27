import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData.dark().copyWith(
  primaryColor: const Color(0xFFE98316),
  scaffoldBackgroundColor: const Color(0xFF161819),
  textTheme: GoogleFonts.ubuntuTextTheme().apply(
    bodyColor: const Color(0xFF8A8B8B),
    displayColor: const Color(0xFF8A8B8B),
  ),
);

final lightTheme = ThemeData.light().copyWith(
  primaryColor: const Color(0xFFE98316),
  scaffoldBackgroundColor: Colors.white,
  textTheme: GoogleFonts.ubuntuTextTheme().apply(
    bodyColor: Colors.black,
    displayColor: Colors.black,
  ),
);
