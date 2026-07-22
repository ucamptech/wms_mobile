import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wms_mobile/models/user_session.dart';

class AuthProvider extends ChangeNotifier {
  UserSession? session;
  bool ready = false;
  bool loading = false;
  String? error;
  String savedUsername = '';

  bool get isLoggedIn => session != null;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    savedUsername = prefs.getString('saved_username') ?? '';

    final raw = prefs.getString('user_session');
    if (raw != null) {
      try {
        session = UserSession.fromJson(jsonDecode(raw) as Map<String, dynamic>);
      } catch (_) {
        await prefs.remove('user_session');
      }
    }

    ready = true;
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    loading = true;
    error = null;
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 400));

    if (username.trim().isEmpty || password.isEmpty) {
      error = 'Enter username and password';
      loading = false;
      notifyListeners();
      return false;
    }

    session = UserSession(
      username: username.trim(),
      name: username.trim(),
      role: 'Operator',
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_session', jsonEncode(session!.toJson()));
    await prefs.setString('saved_username', username.trim());
    savedUsername = username.trim();

    loading = false;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    session = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_session');
  }
}
