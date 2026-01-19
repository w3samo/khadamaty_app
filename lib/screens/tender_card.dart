import 'package:flutter/material.dart';
import '../models/tender_model.dart';

class TenderCard extends StatelessWidget {
  final Tender tender;

  const TenderCard({super.key, required this.tender});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tender.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(tender.category),
              Text(tender.city),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Budget: \$${tender.budget.toStringAsFixed(2)}'),
              Text(
                'Deadline: ${tender.deadline.toLocal().toString().split(' ')[0]}',
                style: TextStyle(
                  color: tender.status == 'Ending Soon' ? Colors.red : Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
