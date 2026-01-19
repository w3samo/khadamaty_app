import 'package:flutter/material.dart';
import '../data/AuthService.dart';
import '../data/UserModel.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _service = AuthService();
  UserModel? _user;

  UserModel? get user => _user;

  Future<bool> login(String email, String password) async {
    try {
      _user = await _service.login(email, password);
      notifyListeners();
      return true;
    } catch (e) {
      print("Login error: $e");
      return false;
    }
  }

  Future<String?> register(String name, String email, String password, String role) async {
    try {
      final msg = await _service.register(name, email, password, role);
      return msg;
    } catch (e) {
      print("Register error: $e");
      return null;
    }
  }
}
