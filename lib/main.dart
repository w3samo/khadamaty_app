import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'features/auth/providers/auth_provider.dart';
import 'features/customer/providers/customer_tenders_provider.dart';
import 'core/routing/app_router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()), // Auth logic
        ChangeNotifierProvider(create: (_) => CustomerTendersProvider()), // Customer tenders
        // لاحقًا يمكن إضافة باقي Providers مثل ProviderHome أو AdminHome
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'مناقصات',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2CABE3),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2CABE3),
          foregroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      routerConfig: appRouter, // استخدام GoRouter
    );
  }
}
