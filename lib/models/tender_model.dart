class Tender {
  final String id;
  final String title;
  final String category;
  final String city;
  final double budget;
  final DateTime deadline;
  final String status; // "New", "Ending Soon", "Applied"

  Tender({
    required this.id,
    required this.title,
    required this.category,
    required this.city,
    required this.budget,
    required this.deadline,
    required this.status,
  });

  factory Tender.fromJson(Map<String, dynamic> json) {
    return Tender(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      city: json['city'],
      budget: json['budget'].toDouble(),
      deadline: DateTime.parse(json['deadline']),
      status: json['status'],
    );
  }
}
