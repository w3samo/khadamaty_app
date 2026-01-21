import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApiService {
  static const String baseUrl = 'https://your-api.com/api';

  /// تسجيل مستخدم (Company / Provider)
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String type, // company | provider
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'type': type,
      }),
    );

    return jsonDecode(response.body);
  }

  /// تسجيل دخول مستخدم
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    return jsonDecode(response.body);
  }
}
