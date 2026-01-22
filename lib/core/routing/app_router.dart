import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/choose_account_screen.dart';
import '../../features/customer/presentation/home/customer_home_screen.dart';
import '../../features/provider/presentation/home/provider_home_screen.dart';
import '../../features/shared/splash_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    // شاشة البداية / Splash
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),

    // تسجيل الدخول
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),

    // التسجيل مع تمرير الدور
    GoRoute(
      path: '/register/:role',
      builder: (context, state) {
        // استخراج role بشكل صحيح
        final role = state.pathParameters['role'] ?? 'CUSTOMER';
        return RegisterScreen(role: role);
      },
    ),

    // اختيار نوع الحساب
    GoRoute(
      path: '/choose-account',
      builder: (context, state) => const ChooseAccountScreen(),
    ),

    // الشاشة الرئيسية للعميل
    GoRoute(
      path: '/customer/home',
      builder: (context, state) => const CustomerHomeScreen(),
    ),

    // الشاشة الرئيسية للمزود
    GoRoute(
      path: '/provider/home',
      builder: (context, state) => const ProviderHomeScreen(),
    ),
  ],
);
