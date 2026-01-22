import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:8000/api'));

  CustomerService() {
    // إضافة interceptor لإرسال التوكن تلقائيًا
    _dio.interceptors.add(
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

  Future<Map<String, dynamic>> getMe() async {
    final response = await _dio.get('/me');
    return response.data;
  }

  Future<List<dynamic>> getCustomerTenders() async {
    final response = await _dio.get('/customer/tenders');
    return response.data as List<dynamic>;
  }
}
