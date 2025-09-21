import 'package:flutter/material.dart';

class AppTheme {
  static const Color _brand = Color(0xFF7A3E12); // بني
  static const Color _bg = Color(0xFFF7F7F7);

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(seedColor: _brand);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme.copyWith(primary: _brand, secondary: const Color(0xFF9E6B44)),
      scaffoldBackgroundColor: _bg,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.white,
        titleTextStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: Colors.black87),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        bodyMedium: TextStyle(fontSize: 14),
      ),
      chipTheme: const ChipThemeData(
        side: BorderSide(color: Color(0xFFE5E7EB)),
        backgroundColor: Colors.white,
      ),
      iconTheme: const IconThemeData(color: Colors.black87),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      ),
    );
  }
}