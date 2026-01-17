class TenderModel {
  final int id;
  final String title;
  final String category;
  final String status;
  final List<String> files;
  final List<Map<String, dynamic>> offers;
  final DateTime closeDate;

  TenderModel({
    required this.id,
    required this.title,
    required this.category,
    required this.status,
    required this.files,
    required this.offers,
    required this.closeDate,
  });
}
