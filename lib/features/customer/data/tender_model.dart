// lib/features/customer/data/tender_model.dart
class TenderModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final String status; // 'open', 'closed', 'awardPending'
  final int bidCount;
  final DateTime deadline;
  final double budget;
  final String company;

  TenderModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.bidCount,
    required this.deadline,
    required this.budget,
    required this.company,
  });

  factory TenderModel.fromJson(Map<String, dynamic> json) {
    return TenderModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      status: json['status'],
      bidCount: json['bid_count'] ?? 0,
      deadline: DateTime.parse(json['deadline']),
      budget: (json['budget'] as num).toDouble(),
      company: json['company_name'] ?? '',
    );
  }
}
