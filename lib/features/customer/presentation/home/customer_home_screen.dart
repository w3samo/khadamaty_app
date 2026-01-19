import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = ['الرئيسية', 'مناقصاتي', 'المفضلة', 'التقارير'];

  final List<Tender> _recentTenders = [
    Tender(
      id: '1',
      title: 'توريد أجهزة حاسوب حديثة',
      description: 'توريد 50 جهاز حاسوب محمول للمؤسسة',
      category: 'تكنولوجيا المعلومات',
      status: TenderStatus.open,
      bidCount: 12,
      deadline: DateTime.now().add(const Duration(days: 5)),
      budget: 250000,
      company: 'شركة التقنية المتقدمة',
    ),
    Tender(
      id: '2',
      title: 'تنظيف وصيانة المبنى الإداري',
      description: 'خدمات تنظيف وصيانة شاملة للمبنى',
      category: 'الخدمات العامة',
      status: TenderStatus.closed,
      bidCount: 8,
      deadline: DateTime.now().subtract(const Duration(days: 2)),
      budget: 50000,
      company: 'إدارة المنشآت',
    ),
    Tender(
      id: '3',
      title: 'تطوير نظام إدارة الموارد البشرية',
      description: 'تصميم وتنفيذ نظام HR متكامل',
      category: 'برمجيات',
      status: TenderStatus.awardPending,
      bidCount: 15,
      deadline: DateTime.now().add(const Duration(days: 10)),
      budget: 150000,
      company: 'قسم تكنولوجيا المعلومات',
    ),
    Tender(
      id: '4',
      title: 'تأمين مواد مكتبية لمدة عام',
      description: 'توريد مواد مكتبية متنوعة',
      category: 'مستلزمات مكتبية',
      status: TenderStatus.open,
      bidCount: 5,
      deadline: DateTime.now().add(const Duration(days: 7)),
      budget: 75000,
      company: 'الإدارة المالية',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // App Bar Custom
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                children: [
                  // User Avatar
                  GestureDetector(
                    onTap: () => context.go('/customer-profile'),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.person, color: Colors.blue),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'مرحباً',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'أحمد محمد',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Badge(
                      label: const Text('3'),
                      child: const Icon(Icons.notifications_outlined),
                    ),
                    onPressed: () => context.go('/notifications'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => context.go('/search'),
                  ),
                ],
              ),
            ),

            // Custom Tab Bar
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: _tabs.asMap().entries.map((entry) {
                  final index = entry.key;
                  final title = entry.value;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTab = index;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontWeight: _selectedTab == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: _selectedTab == index
                                  ? Colors.blue
                                  : Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (_selectedTab == index)
                            Container(
                              width: 30,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // إحصائيات سريعة
                      const Text(
                        'نظرة سريعة',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 1.5,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        children: [
                          _buildStatCard(
                            title: 'مناقصات مفتوحة',
                            value: '3',
                            color: Colors.green[50]!,
                            textColor: Colors.green,
                            icon: Icons.lock_open_rounded,
                          ),
                          _buildStatCard(
                            title: 'مناقصات مغلقة',
                            value: '5',
                            color: Colors.blue[50]!,
                            textColor: Colors.blue,
                            icon: Icons.lock,
                          ),
                          _buildStatCard(
                            title: 'بانتظار الترسية',
                            value: '2',
                            color: Colors.orange[50]!,
                            textColor: Colors.orange,
                            icon: Icons.hourglass_bottom,
                          ),
                          _buildStatCard(
                            title: 'إجمالي العروض',
                            value: '40',
                            color: Colors.purple[50]!,
                            textColor: Colors.purple,
                            icon: Icons.assignment_turned_in,
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // زر إنشاء مناقصة
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.add_circle_outline),
                          label: const Text(
                            'إنشاء مناقصة جديدة',
                            style: TextStyle(fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          onPressed: () => context.go('/create-tender'),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // آخر المناقصات
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'آخر المناقصات',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          TextButton.icon(
                            icon: const Icon(Icons.arrow_back_ios_new,
                                size: 14),
                            label: const Text('عرض الكل'),
                            onPressed: () => context.go('/customer-auctions'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // قائمة المناقصات
                      ..._recentTenders.map((tender) => _buildTenderCard(tender)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_filled, 'الرئيسية', true),
              _buildNavItem(Icons.assignment, 'مناقصاتي', false),
              _buildNavItem(Icons.favorite_border, 'المفضلة', false),
              _buildNavItem(Icons.bar_chart, 'التقارير', false),
              _buildNavItem(Icons.more_horiz, 'المزيد', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
    required Color textColor,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: textColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTenderCard(Tender tender) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => context.go('/customer-auction-details/${tender.id}'),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        tender.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(tender.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _getStatusText(tender.status),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(tender.status),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  tender.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.category_outlined,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      tender.category,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.groups_outlined, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      '${tender.bidCount} عرض',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      _formatDate(tender.deadline),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'الميزانية: ',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        children: [
                          TextSpan(
                            text: '${tender.budget} ريال',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      tender.company,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? Colors.blue : Colors.grey,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Colors.blue : Colors.grey,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(TenderStatus status) {
    switch (status) {
      case TenderStatus.open:
        return Colors.green;
      case TenderStatus.closed:
        return Colors.red;
      case TenderStatus.awardPending:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(TenderStatus status) {
    switch (status) {
      case TenderStatus.open:
        return 'مفتوحة';
      case TenderStatus.closed:
        return 'مغلقة';
      case TenderStatus.awardPending:
        return 'بانتظار الترسية';
      default:
        return 'غير معروف';
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);

    if (difference.inDays > 0) {
      return '${difference.inDays} يوم';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ساعة';
    } else {
      return 'منتهية';
    }
  }
}

// نماذج البيانات
enum TenderStatus { open, closed, awardPending }

class Tender {
  final String id;
  final String title;
  final String description;
  final String category;
  final TenderStatus status;
  final int bidCount;
  final DateTime deadline;
  final double budget;
  final String company;

  Tender({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.bidCount,
    required this.deadline,
    required this.budget,
    required this.company,
  });
}