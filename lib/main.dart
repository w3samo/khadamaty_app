import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'features/customer/providers/customer_tenders_provider.dart';
import 'core/routing/app_router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomerTendersProvider()),
        // ممكن تضيف باقي Providers هنا لاحقًا
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
      routerConfig: appRouter, // <--- routerConfig وليس home
    );
  }
}
