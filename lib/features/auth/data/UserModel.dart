// lib/features/auth/data/UserModel.dart
class UserModel {
  final int id;
  final String name;
  final String email;
  final String role;
  final String status;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
  });

  // fromJson الآن يستقبل json + token (حسب تصميم AuthResponse)
  factory UserModel.fromJson(Map<String, dynamic> json, String token) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      status: json['status'] ?? 'active',
    );
  }
}
