import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController(); // لتأكيد كلمة المرور

  // حقول الشركة
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _registrationNumberController = TextEditingController(); // رقم التسجيل
  final TextEditingController _taxNumberController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _bankAccountNumberController = TextEditingController();
  final TextEditingController _authorizedPersonNameController = TextEditingController();
  final TextEditingController _authorizedPersonTitleController = TextEditingController();
  // لوجو ومستندات: ستحتاج لمكتبات file_picker هنا

  String _userType = 'individual'; // القيمة الافتراضية

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _companyNameController.dispose();
    _registrationNumberController.dispose();
    _taxNumberController.dispose();
    _bankNameController.dispose();
    _bankAccountNumberController.dispose();
    _authorizedPersonNameController.dispose();
    _authorizedPersonTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إنشاء حساب جديد")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: 'app_logo',
                child: Image.asset(
                  'assets/company_logo.png', // استبدل بمسار شعار شركتك
                  height: 100,
                  width: 100,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "اكتشف فرصاً جديدة معنا",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),

              // نوع الحساب
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("نوع الحساب", style: Theme.of(context).textTheme.titleMedium),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _userType,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).hintColor),
                          labelText: "اختر نوع حسابك",
                        ),
                        items: [
                          DropdownMenuItem(
                            child: Text("فرد (Individual)"),
                            value: 'individual',
                          ),
                          DropdownMenuItem(
                            child: Text("شركة (Company)"),
                            value: 'company',
                          ),
                        ],
                        onChanged: (value) {
                          setState(() => _userType = value!);
                        },
                        validator: (value) => value == null ? 'يرجى اختيار نوع الحساب' : null,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // معلومات المستخدم الأساسية (Users Table)
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("معلومات المستخدم", style: Theme.of(context).textTheme.titleMedium),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "الاسم الكامل",
                          hintText: "أدخل اسمك الكامل",
                          prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).hintColor),
                        ),
                        validator: (value) => value!.isEmpty ? 'الاسم مطلوب' : null,
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "البريد الإلكتروني",
                          hintText: "أدخل بريدك الإلكتروني",
                          prefixIcon: Icon(Icons.email_outlined, color: Theme.of(context).hintColor),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'البريد الإلكتروني مطلوب';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'أدخل بريداً إلكترونياً صحيحاً';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: "رقم الهاتف",
                          hintText: "أدخل رقم هاتفك",
                          prefixIcon: Icon(Icons.phone_outlined, color: Theme.of(context).hintColor),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) => value!.isEmpty ? 'رقم الهاتف مطلوب' : null,
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: "كلمة المرور",
                          hintText: "أدخل كلمة مرور قوية",
                          prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).hintColor),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'كلمة المرور مطلوبة';
                          }
                          if (value.length < 6) {
                            return 'كلمة المرور قصيرة جداً (الحد الأدنى 6 أحرف)';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: "تأكيد كلمة المرور",
                          hintText: "أعد إدخال كلمة المرور",
                          prefixIcon: Icon(Icons.lock_reset_outlined, color: Theme.of(context).hintColor),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'تأكيد كلمة المرور مطلوب';
                          }
                          if (value != _passwordController.text) {
                            return 'كلمة المرور غير متطابقة';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // معلومات الشركة (Company Profiles Table)
              Visibility(
                visible: _userType == 'company',
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("معلومات الشركة", style: Theme.of(context).textTheme.titleMedium),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _companyNameController,
                          decoration: InputDecoration(
                            labelText: "اسم الشركة",
                            hintText: "أدخل اسم الشركة الرسمي",
                            prefixIcon: Icon(Icons.business_outlined, color: Theme.of(context).hintColor),
                          ),
                          validator: (value) => _userType == 'company' && value!.isEmpty ? 'اسم الشركة مطلوب' : null,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _registrationNumberController,
                          decoration: InputDecoration(
                            labelText: "رقم التسجيل التجاري",
                            hintText: "أدخل رقم التسجيل التجاري",
                            prefixIcon: Icon(Icons.list_alt, color: Theme.of(context).hintColor),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) => _userType == 'company' && value!.isEmpty ? 'رقم التسجيل مطلوب' : null,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _taxNumberController,
                          decoration: InputDecoration(
                            labelText: "الرقم الضريبي",
                            hintText: "أدخل الرقم الضريبي للشركة",
                            prefixIcon: Icon(Icons.receipt_long_outlined, color: Theme.of(context).hintColor),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) => _userType == 'company' && value!.isEmpty ? 'الرقم الضريبي مطلوب' : null,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _bankNameController,
                          decoration: InputDecoration(
                            labelText: "اسم البنك",
                            hintText: "اسم البنك الذي تتعامل معه الشركة",
                            prefix