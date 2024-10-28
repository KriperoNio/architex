import 'package:flutter/material.dart';

class AppTheme {
  // Метод для получения светлой темы
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      colorScheme: ColorScheme.light(
        primary: Colors.white,
        secondary: Colors.black,
        background: Colors.black,
        surface: Colors.white,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onBackground: Colors.black,
        onSurface: Colors.black,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }

  // Метод для получения темной темы
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.deepPurple,
      scaffoldBackgroundColor: Colors.grey[900],
      colorScheme: ColorScheme.dark(
        primary: Colors.deepPurple,
        secondary: Colors.purpleAccent,
        background: Colors.grey[850]!,
        surface: Colors.grey[800]!,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onBackground: Colors.white,
        onSurface: Colors.white70,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: Colors.white70, fontSize: 16),
      ),
    );
  }

  // Метод для создания кастомной темы с параметрами
  static ThemeData custom({
    required Color main,
    Color? accent,
    Color? background,
    Color? surface,
    Color? onMain,
    Color? onAccent,
    Color? onBackground,
    Color? onSurface,
  }) {
    return ThemeData(
      primaryColor: main,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: main,
        secondary: accent ?? Colors.teal,
        background: background ?? Colors.white,
        surface: surface ?? Colors.grey[200]!,
        onPrimary: onMain ?? Colors.white,
        onSecondary: onAccent ?? Colors.black,
        onBackground: onBackground ?? Colors.black,
        onSurface: onSurface ?? Colors.black54,
        error: Colors.redAccent,
        onError: Colors.white,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
            color: onMain ?? Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: onSurface ?? Colors.black87, fontSize: 16),
      ),
    );
  }
}
