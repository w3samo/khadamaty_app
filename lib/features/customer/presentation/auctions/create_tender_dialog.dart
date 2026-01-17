import 'package:flutter/material.dart';

class CreateTenderDialog extends StatefulWidget {
  const CreateTenderDialog({super.key});

  @override
  State<CreateTenderDialog> createState() => _CreateTenderDialogState();
}

class _CreateTenderDialogState extends State<CreateTenderDialog> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String category = 'المقاولات';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('نشر مناقصة جديدة'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'عنوان المناقصة'),
              onSaved: (val) => title = val ?? '',
              validator: (val) => val == null || val.isEmpty ? 'مطلوب' : null,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: category,
              items: <String>[
                'المقاولات',
                'الإغاثة الغذائية',
                'الصحة',
                'WASH',
                'الخدمات اللوجستية',
                'الطاقة',
                'الاستشارات',
                'التكنولوجيا والقرطاسية',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => category = val!),
              decoration: const InputDecoration(labelText: 'الفئة'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              // هنا لاحقًا يتم إضافة المنقصة لـ Provider
              Navigator.pop(context);
            }
          },
          child: const Text('نشر'),
        ),
      ],
    );
  }
}
