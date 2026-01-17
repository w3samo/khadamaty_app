import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/customer_tenders_provider.dart';
import 'auction_detail_screen.dart';

class AuctionListScreen extends StatelessWidget {
  const AuctionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerTendersProvider>(context);
    final tenders = provider.tenders;

    return Scaffold(
      appBar: AppBar(title: const Text('المناقصات')),
      body: ListView.builder(
        itemCount: tenders.length,
        itemBuilder: (context, index) {
          final tender = tenders[index];
          return Card(
            child: ListTile(
              title: Text(tender.title),
              subtitle: Text('الفئة: ${tender.category} | حالة: ${tender.status}'),
              trailing: Text('يغلق: ${tender.closeDate.day}/${tender.closeDate.month}'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AuctionDetailScreen(tenderId: tender.id),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
