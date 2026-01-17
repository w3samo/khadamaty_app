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
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/choose-account',
      builder: (context, state) => const ChooseAccountScreen(),
    ),
    GoRoute(
      path: '/customer/home',
      builder: (context, state) => const CustomerHomeScreen(),
    ),
    GoRoute(
      path: '/provider/home',
      builder: (context, state) => const ProviderHomeScreen(),
    ),
  ],
);
