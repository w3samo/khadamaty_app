import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminApiService {
  static const String baseUrl = 'http://localhost/monaqasat-api/public/api';

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/admin/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    return jsonDecode(response.body);
  }
}
