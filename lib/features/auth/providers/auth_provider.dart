import 'package:flutter/material.dart';
import '../data/AuthService.dart';
import '../data/UserModel.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? user;
  String? token; // <--- خزن التوكن هنا

  Future<bool> login(String email, String password) async {
    try {
      final response = await _authService.login(email, password);
      token = response['access_token']; // <-- خزن التوكن هنا
      final userData = response['user'];
      user = UserModel.fromJson(userData);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
  // ================= Register =================
  Future<String?> register(String name, String email, String password, String role) async {
    try {
      final msg = await _authService.register(name, email, password, role);
      return msg; // رسالة النجاح أو الخطأ من السيرفر
    } catch (e) {
      return 'خطأ أثناء التسجيل';
    }
  }
}

