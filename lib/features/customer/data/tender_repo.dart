import 'tender_model.dart';

class TenderRepo {
  static final List<TenderModel> mockTenders = [
    TenderModel(
      id: 1,
      title: 'توريد أجهزة مكتبية',
      category: 'التكنولوجيا والقرطاسية',
      status: 'pending',
      files: ['spec.pdf', 'instructions.pdf'],
      offers: [
        {'provider': 'شركة X', 'price': 5000, 'status': 'submitted'},
        {'provider': 'شركة Y', 'price': 4800, 'status': 'accepted'},
      ],
      closeDate: DateTime.now().add(const Duration(days: 5)),
    ),
    TenderModel(
      id: 2,
      title: 'تنظيف مبنى',
      category: 'الخدمات اللوجستية',
      status: 'closed',
      files: ['plan.pdf'],
      offers: [
        {'provider': 'شركة Z', 'price': 2000, 'status': 'submitted'},
      ],
      closeDate: DateTime.now().add(const Duration(days: 2)),
    ),
  ];
}
