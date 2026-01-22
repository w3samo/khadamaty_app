import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;

  late Dio _dio;

  AuthService._internal() {
    _dio = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:8000/api'))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final prefs = await SharedPreferences.getInstance();
            final token = prefs.getString('access_token');
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            handler.next(options);
          },
        ),
      );
  }

  Future<String?> register(String name, String email, String password, String role) async {
    try {
      final response = await _dio.post('/register', data: {
        'name': name,
        'email': email,
        'password': password,
        'role': role,
      });
      return response.data['message'];
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 422) {
        if (e.response!.data is Map && e.response!.data['errors'] != null) {
          final errors = e.response!.data['errors'] as Map;
          return errors.values.map((v) => v.join(', ')).join('\n');
        }
        return 'بيانات التسجيل غير صحيحة';
      }
      return 'خطأ غير متوقع، حاول مرة أخرى';
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post('/login', data: {
        'email': email,
        'password': password,
      });
      final token = response.data['access_token'];
      if (token != null) await saveToken(token);
      return response.data;
    } on DioException catch (e) {
      throw e;
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<Response> getMe() async {
    return _dio.get('/me');
  }

  Future<Response> getCustomerTenders() async {
    return _dio.get('/customer/tenders');
  }

  Future<void> logout() async {
    await saveToken('');
  }
}
