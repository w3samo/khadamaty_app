
import 'package:dio/src/response.dart';

import 'AuthService.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  Future<String?> register(String name, String email, String password, String role) {
    return _authService.register(name, email, password, role);
  }

  Future<Map<String, dynamic>> login(String email, String password) {
    return _authService.login(email, password);
  }

  Future<void> logout() async {
    await _authService.saveToken('');
  }

  Future<Response> getMe() {
    return _authService.getMe();
  }

  Future<List<dynamic>> getCustomerTenders() async {
    final response = await _authService.getCustomerTenders();
    return response.data as List<dynamic>;
  }
}
