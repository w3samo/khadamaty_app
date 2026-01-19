import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChooseAccountScreen extends StatelessWidget {
  const ChooseAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWideScreen = size.width > 700;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF2CABE3).withOpacity(0.03),
                Theme.of(context).scaffoldBackgroundColor,
              ],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 48),

              // العنوان الرئيسي
              Text(
                'مرحباً بك في مناقصات',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2CABE3),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              Text(
                'اختر نوع الحساب المناسب لك',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.75),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // الخيارات
              Expanded(
                child: isWideScreen
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    _AccountTypeCard(
                      title: 'طالب خدمة',
                      description:
                      'أبحث عن مقدمي خدمات لتنفيذ مشاريعي وعطاءاتي',
                      icon: Icons.search_rounded,
                      route: '/login', // يروح على login
                      color: Color(0xFF2CABE3),
                    ),
                    SizedBox(width: 32),
                    _AccountTypeCard(
                      title: 'مزود خدمة',
                      description:
                      'أقدم خدماتي وأشارك في المناقصات والعطاءات',
                      icon: Icons.handyman_rounded,
                      route: '/login', // يروح على login
                      color: Color(0xFF1A8BC2),
                    ),
                  ],
                )
                    : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: const [
                      _AccountTypeCard(
                        title: 'طالب خدمة',
                        description:
                        'أبحث عن مقدمي خدمات لتنفيذ مشاريعي وعطاءاتي',
                        icon: Icons.search_rounded,
                        route: '/login',
                        color: Color(0xFF2CABE3),
                      ),
                      SizedBox(height: 24),
                      _AccountTypeCard(
                        title: 'مزود خدمة',
                        description:
                        'أقدم خدماتي وأشارك في المناقصات والعطاءات',
                        icon: Icons.handyman_rounded,
                        route: '/login',
                        color: Color(0xFF1A8BC2),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountTypeCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String route;
  final Color color;

  const _AccountTypeCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.route,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(route),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 360,
          constraints: const BoxConstraints(maxWidth: 380),
          child: Card(
            elevation: 3,
            shadowColor: color.withOpacity(0.25),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: color.withOpacity(0.12),
                    child: Icon(icon, size: 48, color: color),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.75),
                    ),
                  ),
                  const SizedBox(height: 28),
                  FilledButton.icon(
                    onPressed: () => context.go(route),
                    icon: const Icon(Icons.arrow_forward_rounded, size: 20),
                    label: Text(
                      'ابدأ الآن',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
