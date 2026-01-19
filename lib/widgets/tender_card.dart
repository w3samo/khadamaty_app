import 'package:flutter/material.dart';
import '../models/tender_model.dart';

class TenderCard extends StatelessWidget {
  final Tender tender;
  const TenderCard({super.key, required this.tender});

  Color getStatusColor(String status) {
    switch (status) {
      case 'New':
        return Colors.green;
      case 'Ending Soon':
        return Colors.red;
      case 'Applied':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.lightBlue[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tender.title,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Category: ${tender.category}', style: const TextStyle(color: Colors.black54)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: getStatusColor(tender.status),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tender.status,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(height: 4),
            Text('City: ${tender.city}', style: const TextStyle(color: Colors.black54)),
            Text('Budget: \$${tender.budget}', style: const TextStyle(color: Colors.black54)),
            Text('Deadline: ${tender.deadline.toLocal().toString().split(' ')[0]}',
                style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
