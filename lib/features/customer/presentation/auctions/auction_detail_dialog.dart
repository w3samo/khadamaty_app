import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/customer_tenders_provider.dart';

class AuctionDetailDialog extends StatelessWidget {
  final int tenderId;
  const AuctionDetailDialog({super.key, required this.tenderId});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerTendersProvider>(context);
    final tender = provider.getTenderById(tenderId)!;

    return AlertDialog(
      title: Text(tender.title),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('إغلاق')),
      ],
    );
  }
}
