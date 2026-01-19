import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/tender_card.dart';
import '../models/tender_model.dart';

class ProviderTendersScreen extends StatefulWidget {
  const ProviderTendersScreen({super.key});

  @override
  State<ProviderTendersScreen> createState() => _ProviderTendersScreenState();
}

class _ProviderTendersScreenState extends State<ProviderTendersScreen> {
  late Future<List<Tender>> _tendersFuture;
  List<Tender> _allTenders = [];

  // فلترة
  String? selectedCategory;
  String? selectedCity;
  RangeValues budgetRange = const RangeValues(0, 10000);

  @override
  void initState() {
    super.initState();
    _tendersFuture = ApiService.fetchTenders().then((list) {
      _allTenders = list;
      return list;
    });
  }

  List<Tender> get filteredTenders {
    return _allTenders.where((t) {
      final categoryMatch =
          selectedCategory == null || t.category == selectedCategory;
      final cityMatch = selectedCity == null || t.city == selectedCity;
      final budgetMatch = t.budget >= budgetRange.start && t.budget <= budgetRange.end;
      return categoryMatch && cityMatch && budgetMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Service Provider Tenders'),
        backgroundColor: Colors.lightBlue[400],
      ),
      body: FutureBuilder<List<Tender>>(
        future: _tendersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tenders found'));
          } else {
            return Column(
              children: [
                // --- فلترة متقدمة ---
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        // فئة
                        Row(
                          children: [
                            const Icon(Icons.category, color: Colors.lightBlue),
                            const SizedBox(width: 8),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  labelText: 'Category',
                                  border: OutlineInputBorder(),
                                ),
                                value: selectedCategory,
                                items: const [
                                  DropdownMenuItem(value: 'Construction', child: Text('Construction')),
                                  DropdownMenuItem(value: 'Food Relief', child: Text('Food Relief')),
                                  DropdownMenuItem(value: 'Health', child: Text('Health')),
                                  DropdownMenuItem(value: 'WASH', child: Text('WASH')),
                                  DropdownMenuItem(value: 'Logistics', child: Text('Logistics')),
                                  DropdownMenuItem(value: 'Energy', child: Text('Energy')),
                                  DropdownMenuItem(value: 'Consulting', child: Text('Consulting')),
                                  DropdownMenuItem(value: 'Technology & Office', child: Text('Technology & Office')),
                                ],
                                onChanged: (value) {
                                  setState(() => selectedCategory = value);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // مدينة
                        Row(
                          children: [
                            const Icon(Icons.location_city, color: Colors.lightBlue),
                            const SizedBox(width: 8),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  labelText: 'City',
                                  border: OutlineInputBorder(),
                                ),
                                value: selectedCity,
                                items: const [
                                  DropdownMenuItem(value: 'Gaza', child: Text('Gaza')),
                                  DropdownMenuItem(value: 'Rafah', child: Text('Rafah')),
                                  DropdownMenuItem(value: 'Khan Younis', child: Text('Khan Younis')),
                                  DropdownMenuItem(value: 'Central Gaza', child: Text('Central Gaza')),
                                ],
                                onChanged: (value) {
                                  setState(() => selectedCity = value);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // ميزانية
                        Row(
                          children: [
                            const Icon(Icons.attach_money, color: Colors.lightBlue),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Budget Range'),
                                  RangeSlider(
                                    values: budgetRange,
                                    min: 0,
                                    max: 10000,
                                    divisions: 20,
                                    labels: RangeLabels(
                                      '\$${budgetRange.start.round()}',
                                      '\$${budgetRange.end.round()}',
                                    ),
                                    onChanged: (values) {
                                      setState(() => budgetRange = values);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // --- قائمة المناقصات ---
                Expanded(
                  child: filteredTenders.isEmpty
                      ? const Center(child: Text('No tenders match your filters'))
                      : ListView.builder(
                          itemCount: filteredTenders.length,
                          itemBuilder: (context, index) =>
                              TenderCard(tender: filteredTenders[index]),
                        ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
