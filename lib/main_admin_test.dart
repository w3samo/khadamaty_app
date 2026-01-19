import 'package:flutter/material.dart';
import 'screens/admin_login_screen.dart'; // تأكد أن المسار صحيح

void main() {
  runApp(const AdminTestApp());
}

class AdminTestApp extends StatelessWidget {
  const AdminTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Login Test',
      theme: ThemeData(
        primaryColor: const Color(0xFF2CABE3), // أزرق سماوي
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.lightBlueAccent,
        ),
      ),
      home: const AdminLoginScreen(), // الصفحة التي تريد اختبارها
    );
  }
}
