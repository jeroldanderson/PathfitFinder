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
  bool loading = false;
  String? error;

  List<Listing> get all => List.unmodifiable(_repository.listings);

  Future<void> load() async {
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();
    try {
      await _repository.fetchAll();
    } catch (_) {
      error = 'Unable to load listings right now.';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

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

  Future<void> save(Listing value) async {
    final existing = find(value.id);
    loading = true;
    error = null;
    notifyListeners();
    try {
      if (existing == null) {
        await _repository.createListing(value);
      } else {
        await _repository.updateListing(value, previous: existing);
      }
      draft = null;
    } on StateError catch (e) {
      error = e.message;
      rethrow;
    } catch (_) {
      error = 'Could not save listing. Please try again.';
      rethrow;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> markSold(String id) async {
    loading = true;
    notifyListeners();
    try {
      await _repository.markAsSold(id);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> delete(String id) async {
    loading = true;
    notifyListeners();
    try {
      await _repository.softDelete(id);
      _saved.remove(id);
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}