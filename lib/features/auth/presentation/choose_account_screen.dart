import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChooseAccountScreen extends StatelessWidget {
  const ChooseAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اختر نوع الحساب')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => context.go('/customer/home'),
            child: const Text('طالب خدمة'),
          ),
          ElevatedButton(
            onPressed: () => context.go('/provider/home'),
            child: const Text('مزود خدمة'),
          ),
        ],
      ),
    );
  }
}
