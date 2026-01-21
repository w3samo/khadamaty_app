import 'package:flutter/material.dart';
// import 'register_screen.dart'; // تأكد من إنشاء ملف الريجستر واستيراده هنا

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscureText = true;

  // الحقول المطلوبة بناءً على داتابيز users
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // دالة تجريبية لمحاكاة تسجيل الدخول
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // محاكاة الاتصال بالسيرفر لمدة ثانيتين
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    // تجربة: إذا أدخل المستخدم بيانات معينة نعتبره ناجحاً
    if (_emailController.text == "admin@test.com" && _passwordController.text == "123456") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تسجيل الدخول بنجاح!'), backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('خطأ في البريد أو كلمة المرور'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // شعار افتراضي
                  const Icon(Icons.account_circle, size: 100, color: Colors.blueAccent),
                  const SizedBox(height: 20),
                  const Text(
                    "مرحباً بك",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),

                  // حقل البريد الإلكتروني (بناءً على email في الداتابيز)
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "البريد الإلكتروني",
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'يرجى إدخال البريد الإلكتروني';
                      if (!value.contains('@')) return 'صيغة البريد غير صحيحة';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // حقل كلمة المرور (بناءً على password في الداتابيز)
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: "كلمة المرور",
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscureText = !_obscureText),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'يرجى إدخال كلمة المرور';
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 30),

                  // زر الدخول مع حالة التحميل
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: _isLoading 
                        ? const CircularProgressIndicator(color: Colors.white) 
                        : const Text("دخول", style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // رابط الانتقال لصفحة التسجيل
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("ليس لديك حساب؟"),
                      TextButton(
                        onPressed: () {
                          // هنا ننتقل لصفحة التسجيل
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                        },
                        child: const Text("إنشاء حساب جديد", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
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