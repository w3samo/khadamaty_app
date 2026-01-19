import 'package:flutter/material.dart';
import '../models/tender_model.dart';

class TenderCard extends StatelessWidget {
  final Tender tender;

  const TenderCard({Key? key, required this.tender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    if (tender.status == 'New') {
      statusColor = Colors.green;
    } else if (tender.status == 'Ending Soon') {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.grey;
    }

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tender.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.lightBlue[400]),
                const SizedBox(width: 4),
                Text(tender.city),
                const SizedBox(width: 12),
                Icon(Icons.category, size: 16, color: Colors.lightBlue[400]),
                const SizedBox(width: 4),
                Text(tender.category),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Budget: \$${tender.budget.toStringAsFixed(2)}'),
                Text(
                  'Deadline: ${tender.deadline.day}/${tender.deadline.month}/${tender.deadline.year}',
                  style: TextStyle(color: statusColor),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                tender.status,
                style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
