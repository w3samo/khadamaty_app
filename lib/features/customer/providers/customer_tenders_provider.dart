import 'package:flutter/material.dart';
import '../data/tender_repo.dart';
import '../data/tender_model.dart';

class CustomerTendersProvider with ChangeNotifier {
  List<TenderModel> tenders = TenderRepo.mockTenders;

  List<TenderModel> filterByCategory(String category) {
    return tenders.where((t) => t.category == category).toList();
  }

  TenderModel? getTenderById(int id) {
    try {
      return tenders.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }

  void selectWinningOffer(int tenderId, String provider) {
    final tender = getTenderById(tenderId);
    if (tender != null) {
      for (var offer in tender.offers) {
        offer['status'] = (offer['provider'] == provider) ? 'accepted' : 'rejected';
      }
      notifyListeners();
    }
  }
}
