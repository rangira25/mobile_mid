import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  String _sortOrder = 'title';
  SharedPreferences? _prefs;

  bool get isDarkMode => _isDarkMode;
  String get sortOrder => _sortOrder;

  ThemeProvider() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _isDarkMode = _prefs?.getBool('darkMode') ?? false;
    _sortOrder = _prefs?.getString('sortOrder') ?? 'title';
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _prefs?.setBool('darkMode', _isDarkMode);
    notifyListeners();
  }

  void setSortOrder(String order) {
    _sortOrder = order;
    _prefs?.setString('sortOrder', _sortOrder);
    notifyListeners();
  }
}
