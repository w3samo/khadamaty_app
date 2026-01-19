import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final auth = Provider.of<AuthProvider>(context, listen: false);
    final success = await auth.login(_emailController.text, _passwordController.text);

    setState(() => _isLoading = false);

    if (success) {
      final role = auth.user!.role;
      if (role == 'ORGANIZATION') context.go('/customer/home');
      else if (role == 'PROVIDER') context.go('/provider/home');
      else if (role == 'SUPER_ADMIN') context.go('/admin/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login failed')));
    }
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isWideScreen = size.width > 900; // زدنا الحد شوي للشاشات المتوسطة

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF2CABE3).withOpacity(0.04),
                  theme.scaffoldBackgroundColor,
                ],
              ),
            ),
            child: isWideScreen
                ? Row(
              children: [
                // الجانب الأيسر - Illustration (أكثر جاذبية)
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.all(48),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2CABE3).withOpacity(0.07),
                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(32)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.business_center_rounded,
                          size: 160,
                          color: const Color(0xFF2CABE3),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'مناقصات',
                          style: theme.textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2CABE3),
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'اكتشف وتابع أحدث المناقصات والعطاءات بكل سهولة واحترافية',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.85),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        Opacity(
                          opacity: 0.8,
                          child: Text(
                            'انضم إلى آلاف المستخدمين الذين يديرون أعمالهم بذكاء',
                            style: theme.textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // الجانب الأيمن - Form card
                Expanded(
                  flex: 4,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: _buildLoginCard(context),
                    ),
                  ),
                ),
              ],
            )
                : _buildLoginCard(context), // موبايل: card مركزي
          ),
        ),
      ),
    );
  }

  Widget _buildLoginCard(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 28,
        vertical: MediaQuery.of(context).size.height > 800 ? 40 : 20,
      ),
      child: Card(
        elevation: 4,
        shadowColor: const Color(0xFF2CABE3).withOpacity(0.15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'مرحباً بعودتك',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2CABE3),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'سجّل دخولك للوصول إلى لوحة التحكم',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.75),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                // Email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    prefixIcon: const Icon(Icons.alternate_email_rounded),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    filled: true,
                    fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'مطلوب';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                      return 'بريد إلكتروني غير صالح';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'كلمة المرور',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    filled: true,
                    fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'مطلوب';
                    if (v.length < 6) return '6 أحرف على الأقل';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('خاصية استعادة كلمة المرور قيد التطوير')),
                      );
                    },
                    style: TextButton.styleFrom(foregroundColor: const Color(0xFF2CABE3)),
                    child: const Text('نسيت كلمة المرور؟'),
                  ),
                ),
                const SizedBox(height: 32),

                // زر الدخول
                FilledButton.icon(
                  onPressed: _isLoading ? null : _login,
                  icon: _isLoading
                      ? const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                  )
                      : const Icon(Icons.arrow_forward_rounded),
                  label: Text(
                    _isLoading ? 'جاري التحميل...' : 'تسجيل الدخول',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF2CABE3),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(height: 32),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ليس لديك حساب؟ ',
                      style: theme.textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => context.go('/register'),
                      style: TextButton.styleFrom(foregroundColor: const Color(0xFF2CABE3)),
                      child: const Text('إنشاء حساب جديد'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}