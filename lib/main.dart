import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/system_screen.dart'; // Import the new screen

void main() {
  runApp(const TheSystemApp());
}

class TheSystemApp extends StatelessWidget {
  const TheSystemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D1117),
        textTheme: GoogleFonts.exo2TextTheme(),
      ),
      home: const SystemScreen(), // Point to the new file
    );
  }
}
