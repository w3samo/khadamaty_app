import 'package:flutter/material.dart';
import '../models/tender_model.dart';
import '../widgets/tender_card.dart';

class ProviderTendersScreen extends StatefulWidget {
  const ProviderTendersScreen({super.key});

  @override
  State<ProviderTendersScreen> createState() => _ProviderTendersScreenState();
}

class _ProviderTendersScreenState extends State<ProviderTendersScreen> {
  List<Tender> tenders = [
    Tender(
      id: '1',
      title: 'Repair School Building',
      category: 'Construction',
      city: 'Gaza',
      budget: 15000,
      deadline: DateTime.now().add(const Duration(days: 5)),
      status: 'New',
    ),
    Tender(
      id: '2',
      title: 'Food Relief Package',
      category: 'Food Relief',
      city: 'Rafah',
      budget: 5000,
      deadline: DateTime.now().add(const Duration(days: 2)),
      status: 'Ending Soon',
    ),
    Tender(
      id: '3',
      title: 'Install Solar Panels',
      category: 'Energy',
      city: 'Central Gaza',
      budget: 20000,
      deadline: DateTime.now().add(const Duration(days: 7)),
      status: 'Applied',
    ),
  ];

  String searchQuery = '';
  String? selectedCategory;
  String? selectedCity;
  RangeValues budgetRange = const RangeValues(0, 25000);

  List<Tender> get filteredTenders {
    return tenders.where((t) {
      final matchesSearch = t.title.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == null || t.category == selectedCategory;
      final matchesCity = selectedCity == null || t.city == selectedCity;
      final matchesBudget = t.budget >= budgetRange.start && t.budget <= budgetRange.end;
      return matchesSearch && matchesCategory && matchesCity && matchesBudget;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Provider Tenders'),
        backgroundColor: Colors.lightBlue[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search
            TextField(
              decoration: InputDecoration(
                hintText: 'Search by project name',
                prefixIcon: Icon(Icons.search, color: Colors.lightBlue[400]),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
            const SizedBox(height: 12),
            // Filters: Category + City
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                    hint: const Text('Category'),
                    value: selectedCategory,
                    items: const [
                      DropdownMenuItem(value: 'Construction', child: Text('Construction')),
                      DropdownMenuItem(value: 'Food Relief', child: Text('Food Relief')),
                      DropdownMenuItem(value: 'Health', child: Text('Health')),
                      DropdownMenuItem(value: 'WASH', child: Text('WASH')),
                      DropdownMenuItem(value: 'Logistics', child: Text('Logistics')),
                      DropdownMenuItem(value: 'Energy', child: Text('Energy')),
                      DropdownMenuItem(value: 'Consulting', child: Text('Consulting')),
                      DropdownMenuItem(value: 'Technology', child: Text('Technology & Office')),
                    ],
                    onChanged: (value) => setState(() => selectedCategory = value),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                    hint: const Text('City'),
                    value: selectedCity,
                    items: const [
                      DropdownMenuItem(value: 'Gaza', child: Text('Gaza')),
                      DropdownMenuItem(value: 'Rafah', child: Text('Rafah')),
                      DropdownMenuItem(value: 'Khan Younis', child: Text('Khan Younis')),
                      DropdownMenuItem(value: 'Central Gaza', child: Text('Central Gaza')),
                    ],
                    onChanged: (value) => setState(() => selectedCity = value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Budget Range
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Budget Range'),
                RangeSlider(
                  values: budgetRange,
                  min: 0,
                  max: 25000,
                  divisions: 50,
                  labels: RangeLabels(
                    budgetRange.start.round().toString(),
                    budgetRange.end.round().toString(),
                  ),
                  onChanged: (values) => setState(() => budgetRange = values),
                  activeColor: Colors.lightBlue[400],
                  inactiveColor: Colors.lightBlue[100],
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Tender Cards
            Expanded(
              child: filteredTenders.isEmpty
                  ? const Center(child: Text('No tenders match your filters'))
                  : ListView.builder(
                      itemCount: filteredTenders.length,
                      itemBuilder: (context, index) => TenderCard(tender: filteredTenders[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
