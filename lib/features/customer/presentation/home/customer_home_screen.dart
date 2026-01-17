import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/customer_tenders_provider.dart';
import '../auctions/auction_detail_dialog.dart';
import '../profile/customer_profile_screen.dart';
import '../auctions/create_tender_dialog.dart';
import '../../data/tender_model.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  String selectedCategory = 'All';
  String selectedStatus = 'All';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerTendersProvider>(context);
    List<TenderModel> tenders = provider.tenders;

    // Apply filters
    if (selectedCategory != 'All') {
      tenders = tenders.where((t) => t.category == selectedCategory).toList();
    }
    if (selectedStatus != 'All') {
      tenders = tenders.where((t) => t.status == selectedStatus).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة التحكم'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CustomerProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Filters Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Category Filter
                DropdownButton<String>(
                  value: selectedCategory,
                  items: <String>[
                    'All',
                    'المقاولات',
                    'الإغاثة الغذائية',
                    'الصحة',
                    'WASH',
                    'الخدمات اللوجستية',
                    'الطاقة',
                    'الاستشارات',
                    'التكنولوجيا والقرطاسية',
                  ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedCategory = val!;
                    });
                  },
                ),
                // Status Filter
                DropdownButton<String>(
                  value: selectedStatus,
                  items: <String>['All', 'pending', 'closed'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedStatus = val!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Tenders List
            Expanded(
              child: tenders.isEmpty
                  ? const Center(child: Text('لا توجد مناقصات'))
                  : ListView.builder(
                itemCount: tenders.length,
                itemBuilder: (context, index) {
                  final tender = tenders[index];
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(tender.title),
                      subtitle: Text('الفئة: ${tender.category} | الحالة: ${tender.status}'),
                      trailing: Text('يغلق: ${tender.closeDate.day}/${tender.closeDate.month}'),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AuctionDetailDialog(tenderId: tender.id),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const CreateTenderDialog(),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
