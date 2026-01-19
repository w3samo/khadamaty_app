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
}
