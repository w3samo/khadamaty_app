import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/customer_tenders_provider.dart';

class AuctionDetailScreen extends StatelessWidget {
  final int tenderId;
  const AuctionDetailScreen({super.key, required this.tenderId});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerTendersProvider>(context);
    final tender = provider.getTenderById(tenderId);

    if (tender == null) {
      return const Scaffold(
        body: Center(child: Text('المناقصة غير موجودة')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(tender.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الفئة: ${tender.category}'),
            Text('الحالة: ${tender.status}'),
            const SizedBox(height: 12),
            Text('الوصف:\n${tender.description}'),
            const SizedBox(height: 12),
            Text('عدد العروض: ${tender.bidCount}'),
            const SizedBox(height: 12),
            Text('الميزانية: ${tender.budget}'),
            const SizedBox(height: 12),
            Text('الجهة: ${tender.company}'),
          ],
        ),
      ),
    );
  }
}

