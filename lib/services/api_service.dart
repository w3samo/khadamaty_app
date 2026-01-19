import 'dart:async';
import '../models/tender_model.dart';

class ApiService {
  // محاكاة جلب البيانات من السيرفر
  static Future<List<Tender>> fetchTenders() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return [
      Tender(
        id: '1',
        title: 'Supply Office Chairs',
        category: 'Technology & Office',
        city: 'Gaza',
        budget: 1200,
        deadline: DateTime.now().add(const Duration(days: 5)),
        status: 'New',
      ),
      Tender(
        id: '2',
        title: 'Solar Panel Installation',
        category: 'Energy',
        city: 'Rafah',
        budget: 5000,
        deadline: DateTime.now().add(const Duration(days: 2)),
        status: 'Ending Soon',
      ),
      Tender(
        id: '3',
        title: 'Food Relief Packages',
        category: 'Food Relief',
        city: 'Khan Younis',
        budget: 3000,
        deadline: DateTime.now().add(const Duration(days: 10)),
        status: 'Applied',
      ),
    ];
  }
}
