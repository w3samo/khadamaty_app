// lib/features/customer/providers/customer_tenders_provider.dart
import 'package:flutter/material.dart';
import '../data/tender_model.dart';
import '../data/customer_service.dart'; // خدمة استدعاء API

class CustomerTendersProvider with ChangeNotifier {
  List<TenderModel> _tenders = [];
  bool _loading = false;

  List<TenderModel> get tenders => _tenders;
  bool get loading => _loading;

  final CustomerService _service = CustomerService();

  Future<void> fetchTenders() async {
    _loading = true;
    notifyListeners();

    try {
      final data = await _service.getCustomerTenders();
      _tenders = data.map((json) => TenderModel.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching tenders: $e');
    }

    _loading = false;
    notifyListeners();
  }

  TenderModel? getTenderById(int id) {
    try {
      return _tenders.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }
}
