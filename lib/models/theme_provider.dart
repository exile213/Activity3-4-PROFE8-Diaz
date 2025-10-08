import 'package:flutter/material.dart';

/// Theme provider for dark/light mode switching
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => _isDarkMode ? _darkTheme : _lightTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }

  // Light theme with drone/aerial survey colors
  static final ThemeData _lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: const Color(0xFF1976D2),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1976D2),
      secondary: Color(0xFF03A9F4),
      surface: Colors.white,
      background: Color(0xFFF5F5F5),
    ),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1976D2),
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    fontFamily: 'Roboto',
  );

  // Dark theme with drone/aerial survey colors
  static final ThemeData _darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: const Color(0xFF90CAF9),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF90CAF9),
      secondary: Color(0xFF81D4FA),
      surface: Color(0xFF1E1E1E),
      background: Color(0xFF121212),
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Color(0xFF90CAF9),
      elevation: 4,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E1E),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF90CAF9),
        foregroundColor: const Color(0xFF121212),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    fontFamily: 'Roboto',
  );
}
