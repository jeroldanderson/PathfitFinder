import 'package:flutter/foundation.dart';

import '../models/listing.dart';
import '../services/media_service.dart';

class ListingEditorController extends ChangeNotifier {
  ListingEditorController({Listing? initial, MediaService? media})
    : _initial = initial,
      _media = media ?? MediaService() {
    if (initial != null) {
      id = initial.id;
      price = initial.price.toString();
      sport = initial.sport;
      size = initial.size;
      condition = initial.condition;
      description = initial.description;
      wornBy = initial.wornBy;
      number = initial.number;
      included = initial.included;
      images.addAll(initial.images);
    }
  }
  final MediaService _media;
  final Listing? _initial;
  String? id;
  String price = '',
      sport = 'Basketball',
      size = 'M',
      condition = 'Like new',
      description = '',
      wornBy = 'Male',
      number = '',
      included = 'Complete set';
  final List<String> images = [];
  bool picking = false;
  String? error;
  bool _disposed = false;
  Future<void> pick({bool camera = false}) async {
    if (picking || images.length >= 6) return;
    picking = true;
    error = null;
    notifyListeners();
    try {
      final image = await _media.pick(camera: camera);
      if (!_disposed && image != null) images.add(image.path);
    } catch (_) {
      error =
          'Unable to open ${camera ? 'camera' : 'gallery'}. Check permissions or try another source.';
    } finally {
      picking = false;
      if (!_disposed) notifyListeners();
    }
  }

  void removePhoto(int index) {
    images.removeAt(index);
    notifyListeners();
  }

  void addSamplePhotos() {
    if (images.length < 6) images.add('assets/figma/8b601.png');
    if (images.length < 6) images.add('assets/figma/e3b2e.png');
    notifyListeners();
  }

  bool validatePhotos() {
    error = images.isEmpty ? 'Add at least one uniform photo.' : null;
    notifyListeners();
    return error == null;
  }

  Listing buildListing() => Listing(
    id: id ?? DateTime.now().microsecondsSinceEpoch.toString(),
    title:
        _initial != null &&
            _initial.sport == sport &&
            _initial.included == included
        ? _initial.title
        : '$sport${included == 'Complete set' ? ' PATHFIT set' : ' uniform'}',
    price: int.tryParse(price) ?? 0,
    sport: sport,
    size: size,
    wornBy: wornBy,
    condition: condition,
    number: number,
    included: included,
    description: description.trim(),
    images: List.unmodifiable(images),
    owned: true,
    sold: _initial?.sold ?? false,
  );
  static String? validatePrice(String? value) {
    final amount = int.tryParse(value ?? '');
    return amount == null || amount <= 0 || amount > 100000
        ? 'Enter a whole peso amount from 1 to 100,000.'
        : null;
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
