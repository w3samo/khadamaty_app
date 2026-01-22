// lib/features/customer/presentation/home/customer_home_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../auth/providers/auth_provider.dart';
import '../../providers/customer_tenders_provider.dart';
import '../../data/tender_model.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedTab = 0;
  String userName = '';

  final List<String> _tabs = [
    'الرئيسية',
    'مناقصاتي',
    'المفضلة',
    'التقارير'
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      context.read<CustomerTendersProvider>().fetchTenders();
      await fetchUserName();
    });
  }

  // ===================== جلب اسم المستخدم =====================
  Future<void> fetchUserName() async {
    try {
      final auth = context.read<AuthProvider>();
      setState(() {
        userName = auth.user?.name ?? 'العميل';
      });
    } catch (e) {
      setState(() {
        userName = 'العميل';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CustomerTendersProvider>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: provider.loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            _buildAppBar(context),
            _buildTabs(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStats(provider.tenders),
                    const SizedBox(height: 24),
                    _buildCreateTenderButton(context),
                    const SizedBox(height: 32),
                    _buildLatestTenders(provider.tenders, context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ===================== AppBar =====================
  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.go('/customer-profile'),
            child: const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('مرحباً', style: TextStyle(fontSize: 12)),
                Text(
                  userName.isNotEmpty ? userName : 'حساب العميل',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.go('/notifications'),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: _tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final title = entry.value;

          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = index),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: _selectedTab == index
                          ? Colors.blue
                          : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_selectedTab == index)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      height: 3,
                      width: 30,
                      color: Colors.blue,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStats(List<TenderModel> tenders) {
    final open = tenders.where((t) => t.status == 'open').length;
    final closed = tenders.where((t) => t.status == 'closed').length;
    final pending = tenders.where((t) => t.status == 'awardPending').length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'نظرة سريعة',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.5,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _statCard('مفتوحة', open.toString(), Colors.green),
            _statCard('مغلقة', closed.toString(), Colors.red),
            _statCard('بانتظار الترسية', pending.toString(), Colors.orange),
            _statCard('الإجمالي', tenders.length.toString(), Colors.blue),
          ],
        ),
      ],
    );
  }

  Widget _statCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 26, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildCreateTenderButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.add),
        label: const Text('إنشاء مناقصة جديدة'),
        onPressed: () => context.go('/create-tender'),
      ),
    );
  }

  Widget _buildLatestTenders(List<TenderModel> tenders, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'آخر المناقصات',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (tenders.isEmpty)
          const Center(child: Text('لا يوجد مناقصات')),
        ...tenders.take(5).map(
              (t) => _tenderCard(t, context),
        ),
      ],
    );
  }

  Widget _tenderCard(TenderModel tender, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(tender.title),
        subtitle: Text(tender.description),
        trailing: Text(
          tender.status,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () =>
            context.go('/customer-auction-details/${tender.id}'),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _selectedTab,
      onTap: (index) => setState(() => _selectedTab = index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'مناقصاتي'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'المفضلة'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'التقارير'),
      ],
    );
  }
}
