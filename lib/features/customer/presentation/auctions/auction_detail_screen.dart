import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/customer_tenders_provider.dart';

class AuctionDetailScreen extends StatelessWidget {
  final int tenderId;
  const AuctionDetailScreen({super.key, required this.tenderId});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerTendersProvider>(context);
    final tender = provider.getTenderById(tenderId)!;

    return Scaffold(
      appBar: AppBar(title: Text(tender.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الفئة: ${tender.category}'),
            Text('الحالة: ${tender.status}'),
            const SizedBox(height: 10),
            const Text('الملفات:'),
            ...tender.files.map((f) => Text(f)).toList(),
            const SizedBox(height: 20),
            const Text('العروض:'),
            ...tender.offers.map((offer) {
              return ListTile(
                title: Text(offer['provider']),
                subtitle: Text('السعر: ${offer['price']} | الحالة: ${offer['status']}'),
                trailing: offer['status'] == 'submitted'
                    ? ElevatedButton(
                  onPressed: () {
                    provider.selectWinningOffer(tender.id, offer['provider']);
                  },
                  child: const Text('اختيار'),
                )
                    : null,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
