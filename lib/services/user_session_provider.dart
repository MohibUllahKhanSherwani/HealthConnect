import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSessionProvider extends ChangeNotifier {
  String? _userId;
  String? _role;

  String? get userId => _userId;
  String? get role => _role;

  Future<void> loadUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');
    _role = prefs.getString('role');
    notifyListeners();
  }

  Future<void> setUserSession(String userId, String role) async {
    final prefs = await SharedPreferences.getInstance();
    _userId = userId;
    _role = role;
    await prefs.setString('userId', userId);
    await prefs.setString('role', role);
    notifyListeners();
  }

  Future<void> clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = null;
    _role = null;
    await prefs.remove('userId');
    await prefs.remove('role');
    notifyListeners();
  }
}
