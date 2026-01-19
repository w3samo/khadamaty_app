import 'package:flutter/material.dart';
import 'provider_tenders_screen.dart';

void main() {
  runApp(const TestProviderApp());
}

class TestProviderApp extends StatelessWidget {
  const TestProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue[400], // اللون الأساسي أزرق سماوي
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.lightBlueAccent,
        ),
      ),
      home: const ProviderTendersScreen(), // هنا تعرض صفحة المزود مباشرة
    );
  }
}
