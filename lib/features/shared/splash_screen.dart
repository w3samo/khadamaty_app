import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/theme.dart'; // لو موجود، أو نعتمد على Theme.of(context)

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _bounceAnimation; // لإضافة bounce خفيف

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    _scaleAnimation = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _bounceAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.08), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 0.08, end: -0.04), weight: 30),
      TweenSequenceItem(tween: Tween(begin: -0.04, end: 0.0), weight: 30),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    // تأخير الانتقال (يمكن تقليله أو جعله يعتمد على تحميل async)
    Future.delayed(const Duration(milliseconds: 6000), () {
      if (mounted) {
        context.go('/choose-account');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // ألوان مشابهة لمستقل (أزرق سماوي جذاب)
    const primaryColor = Color(0xFF2CABE3);
    final bgColor = isDark ? const Color(0xFF0A192F) : const Color(0xFFF8FAFC);

    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // اللوجو / الأيقونة مع bounce خفيف
                AnimatedBuilder(
                  animation: _bounceAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _bounceAnimation.value * 20),
                      child: child,
                    );
                  },
                  child: Icon(
                    Icons.gavel_rounded,
                    size: 140,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(height: 32),

                Text(
                  'مناقصات',
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'إدارة المناقصات والعطاءات بذكاء واحترافية',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onBackground.withOpacity(0.75),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 60),

                // Loading indicator أنيق
                SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    strokeWidth: 4,
                    backgroundColor: primaryColor.withOpacity(0.2),
                  ),
                ),

                const SizedBox(height: 40),

                // نص صغير (اختياري - يعطي شعور احترافي)
                Text(
                  'جاري التحميل...',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onBackground.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}