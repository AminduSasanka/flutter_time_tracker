import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  primaryColor: const Color(0xFF4A90E2),
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4A90E2)),
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey[300]!),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey[300]!),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF4A90E2)),
    ),
    filled: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    fillColor: Colors.white,
    hintStyle: TextStyle(color: Colors.grey[300]),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF4A90E2),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  ),
  cardTheme: CardThemeData(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.black12, width: 1.0),
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 1,
  ),
);
