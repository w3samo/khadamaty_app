// lib/features/auth/data/AuthResponse.dart
import 'UserModel.dart';

class AuthResponse {
  final UserModel user;
  final String accessToken;
  final String tokenType;

  AuthResponse({
    required this.user,
    required this.accessToken,
    required this.tokenType,
  });

  /// تعديل هنا: نستقبل json + token
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: UserModel.fromJson(json['user'], json['access_token']),
      accessToken: json['access_token'],
      tokenType: json['token_type'] ?? 'Bearer',
    );
  }
}
