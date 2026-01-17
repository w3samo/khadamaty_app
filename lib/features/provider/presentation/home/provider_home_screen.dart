import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProviderHomeScreen extends StatelessWidget {
  const ProviderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مناقصات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // لاحقًا: Push Notification
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              context.go('/provider-profile'); // الملف الشخصي
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Verified Status
            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: const [
                    Icon(Icons.verified, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      'معتمد',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Stats Cards
            Row(
              children: const [
                _StatCard(title: 'العروض المقدمة', value: '4'),
                SizedBox(width: 8),
                _StatCard(title: 'العروض المقبولة', value: '2'),
                SizedBox(width: 8),
                _StatCard(title: 'الرصيد المحجوز', value: '1500\$'),
              ],
            ),
            const SizedBox(height: 20),

            // Latest Tenders
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'آخر المناقصات',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    context.go('/provider-offers'); // قائمة كل العروض
                  },
                  child: const Text('عرض الكل'),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // مثال عناصر المناقصات
            const _TenderCard(
              title: 'توريد أجهزة مكتبية',
              category: 'التكنولوجيا والقرطاسية',
            ),
            const _TenderCard(
              title: 'تنظيف مبنى',
              category: 'الخدمات اللوجستية',
            ),
          ],
        ),
      ),
    );
  }
}

// Stat Card Widget
class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.blue[50],
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(value,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}

// Tender Card Widget
class _TenderCard extends StatelessWidget {
  final String title;
  final String category;

  const _TenderCard({required this.title, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(title),
        subtitle: Text(category),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          context.go('/provider-offer-details'); // تفاصيل العرض
        },
      ),
    );
  }
}
