import 'package:flutter/foundation.dart';

import '../models/listing.dart';
import '../services/marketplace_repository.dart';

class MarketplaceController extends ChangeNotifier {
  MarketplaceController({MarketplaceRepository? repository})
    : _repository = repository ?? MarketplaceRepository();
  final MarketplaceRepository _repository;
  final Set<String> _saved = {};
  ListingFilter filter = const ListingFilter();
  String query = '';
  Listing? draft;
  List<Listing> get all => List.unmodifiable(_repository.listings);
  List<Listing> results({ListingFilter? using}) {
    final result = all
        .where(
          (l) =>
              (using ?? filter).matches(l) &&
              '${l.title} ${l.sport}'.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    switch ((using ?? filter).sort) {
      case 'Low to high':
        result.sort((a, b) => a.price.compareTo(b.price));
      case 'High to low':
        result.sort((a, b) => b.price.compareTo(a.price));
    }
    return result;
  }

  Listing? find(String id) {
    for (final l in all) {
      if (l.id == id) return l;
    }
    return null;
  }

  bool isSaved(String id) => _saved.contains(id);
  List<Listing> get saved =>
      all.where((l) => _saved.contains(l.id) && !l.sold).toList();
  void toggleSaved(String id) {
    if (!_saved.add(id)) _saved.remove(id);
    notifyListeners();
  }

  void search(String value) {
    query = value;
    notifyListeners();
  }

  void applyFilter(ListingFilter value) {
    filter = value;
    notifyListeners();
  }

  void saveDraft(Listing value) {
    draft = value;
    notifyListeners();
  }

  void save(Listing value) {
    final index = _repository.listings.indexWhere((l) => l.id == value.id);
    if (index < 0) {
      _repository.listings.insert(0, value);
    } else {
      _repository.listings[index] = value;
    }
    draft = null;
    notifyListeners();
  }

  void markSold(String id) {
    final l = find(id);
    if (l != null) save(l.copyWith(sold: true));
  }

  void delete(String id) {
    _repository.listings.removeWhere((l) => l.id == id);
    _saved.remove(id);
    notifyListeners();
  }
}
