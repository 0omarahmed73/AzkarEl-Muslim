import 'package:flutter/material.dart';
import 'themes.dart'; // Import your themes

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme;
  bool _isDarkMode;

  ThemeNotifier(this._currentTheme, this._isDarkMode);

  ThemeData get currentTheme => _currentTheme;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    if (_isDarkMode) {
      _currentTheme = lightTheme;
      _isDarkMode = false;
    } else {
      _currentTheme = darkTheme;
      _isDarkMode = true;
    }
    notifyListeners();
  }
}