import 'package:dio/dio.dart';
import 'UserModel.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://127.0.0.1:8000/api',
    headers: {'Accept': 'application/json'},
  ));

  Future<UserModel> login(String email, String password) async {
    final response = await _dio.post('/login', data: {
      'email': email,
      'password': password,
    });
    return UserModel.fromJson(response.data['user'], response.data['access_token']);
  }

  Future<String> register(String name, String email, String password, String role) async {
    final response = await _dio.post('/register', data: {
      'name': name,
      'email': email,
      'password': password,
      'role': role,
    });
    return response.data['message'];
  }
}
