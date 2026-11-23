import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../dataconnect_generated/generated.dart';
import '../models/listing.dart';
import 'notification_service.dart';

class MarketplaceRepository {
  MarketplaceRepository({
    ExampleConnector? connector,
    fb_auth.FirebaseAuth? auth,
    NotificationService? notifications,
  })  : _connector = connector ?? ExampleConnector.instance,
        _auth = auth ?? fb_auth.FirebaseAuth.instance,
        _notifications = notifications ?? NotificationService();

  final ExampleConnector _connector;
  final fb_auth.FirebaseAuth _auth;
  final NotificationService _notifications;

  final List<Listing> listings = [];
  String? _cachedUserId;
  String? _cachedUserEmail;

  Future<String> _requireCurrentUserId() async {
    final email = _auth.currentUser?.email?.trim().toLowerCase();
    if (email == null || email.isEmpty) {
      throw StateError('You must be logged in to manage listings.');
    }
    if (_cachedUserId != null && _cachedUserEmail == email) {
      return _cachedUserId!;
    }
    final res = await _connector.getUserByEmail(email: email).execute();
    if (res.data.users.isEmpty) {
      throw StateError('User profile not found in database.');
    }
    _cachedUserEmail = email;
    _cachedUserId = res.data.users.first.id;
    return _cachedUserId!;
  }

  /// Fetches all non-deleted listings from Data Connect and refreshes [listings].
  Future<List<Listing>> fetchAll() async {
    final currentEmail = _auth.currentUser?.email?.trim().toLowerCase();
    final res = await _connector.getAllListings().execute();

    listings
      ..clear()
      ..addAll(
        res.data.listings.map((row) {
          final imageUrls = row.images.map((img) => img.imageUrl).toList();
          final (decodedSport, cleanDescription) = _decodeSportAndDescription(
            row.description,
            row.uniformType,
          );
          return Listing(
            id: row.id,
            title: row.title,
            price: row.price.round(),
            sport: decodedSport,
            size: _sizeFromEnum(row.size),
            wornBy: _genderFromEnum(row.previousOwnerGender),
            condition: _conditionFromEnum(row.condition),
            images: imageUrls.isEmpty
                ? const ['assets/figma/8b601.png']
                : imageUrls,
            number: row.hasAssignedNumber ? 'Numbered' : '',
            included: _setTypeFromEnum(row.setType),
            description: cleanDescription,
            sellerName: row.seller.fullName,
            sellerCollege: row.seller.collegeOrFaculty ?? '',
            sellerAvatarUrl: row.seller.avatarUrl,
            sellerVerified:
                row.seller.verificationStatus.stringValue == 'VERIFIED',
            owned:
                currentEmail != null &&
                row.seller.email.trim().toLowerCase() == currentEmail,
            sold: row.status.stringValue == 'SOLD',
          );
        }),
      );
    return List.unmodifiable(listings);
  }

  /// Creates a new listing in Data Connect and uploads local photos to Storage.
  Future<Listing> createListing(Listing draft) async {
    final sellerId = await _requireCurrentUserId();

    final created = await _connector
        .createListing(
          sellerId: sellerId,
          title: draft.title,
          price: draft.price.toDouble(),
          uniformType: _sportToEnum(draft.sport),
          size: _sizeToEnum(draft.size),
          setType: _setTypeToEnum(draft.included),
          previousOwnerGender: _genderToEnum(draft.wornBy),
          hasAssignedNumber: draft.number.trim().isNotEmpty,
          condition: _conditionToEnum(draft.condition),
        )
        .description(_encodeDescription(draft.sport, draft.description))
        .execute();

    final listingId = created.data.listing_insert.id;
    final uploadedUrls = await _uploadAndAttachImages(
      listingId: listingId,
      paths: draft.images,
    );

    final email = _auth.currentUser!.email!.trim().toLowerCase();
    final userProfileRes = await _connector.getUserByEmail(email: email).execute();
    final currentProfile = userProfileRes.data.users.isNotEmpty
        ? userProfileRes.data.users.first
        : null;

    final saved = Listing(
      id: listingId,
      title: draft.title,
      price: draft.price,
      sport: draft.sport,
      size: draft.size,
      wornBy: draft.wornBy,
      condition: draft.condition,
      images: uploadedUrls.isEmpty ? draft.images : uploadedUrls,
      number: draft.number,
      included: draft.included,
      description: draft.description,
      sellerName: currentProfile?.fullName ??
          (_auth.currentUser?.displayName ?? 'Thomasian Member'),
      sellerCollege: currentProfile?.collegeOrFaculty ?? '',
      sellerAvatarUrl: currentProfile?.avatarUrl,
      sellerVerified:
          currentProfile?.verificationStatus.stringValue == 'VERIFIED',
      owned: true,
      sold: false,
    );
    listings.insert(0, saved);
    return saved;
  }

  /// Updates an existing listing, uploads any newly added photos, and logs edits in ListingHistory.
  Future<Listing> updateListing(Listing updated, {Listing? previous}) async {
    final userId = await _requireCurrentUserId();

    await _connector
        .updateListing(id: updated.id)
        .title(updated.title)
        .description(_encodeDescription(updated.sport, updated.description))
        .price(updated.price.toDouble())
        .uniformType(_sportToEnum(updated.sport))
        .size(_sizeToEnum(updated.size))
        .setType(_setTypeToEnum(updated.included))
        .previousOwnerGender(_genderToEnum(updated.wornBy))
        .hasAssignedNumber(updated.number.trim().isNotEmpty)
        .condition(_conditionToEnum(updated.condition))
        .status(updated.sold ? ListingStatus.SOLD : ListingStatus.AVAILABLE)
        .execute();

    final finalImages = <String>[];
    for (var i = 0; i < updated.images.length; i++) {
      final path = updated.images[i];
      if (path.startsWith('http://') ||
          path.startsWith('https://') ||
          path.startsWith('data:image/') ||
          path.startsWith('assets/')) {
        finalImages.add(path);
      } else {
        final url = await _compressAndUploadImage(
          listingId: updated.id,
          localPath: path,
          index: i,
        );
        finalImages.add(url);
        await _connector
            .createListingImage(
              listingId: updated.id,
              imageUrl: url,
              isPrimary: i == 0,
              displayOrder: i,
            )
            .execute();
      }
    }

    if (previous != null) {
      await _recordHistoryDiff(
        listingId: updated.id,
        userId: userId,
        previous: previous,
        updated: updated,
      );

      // Notify interested buyers if the seller lowered the price
      if (updated.price < previous.price) {
        await _notifyInterestedBuyers(
          sellerId: userId,
          listingId: updated.id,
          type: NotificationType.PRICE_DROP,
          title: 'Price drop on ${updated.title}',
          body: 'Now ₱${updated.price} (down from ₱${previous.price}).',
        );
      }
    }

    final saved = updated.copyWith(images: finalImages);
    final idx = listings.indexWhere((l) => l.id == saved.id);
    if (idx >= 0) {
      listings[idx] = saved;
    }
    return saved;
  }

  Future<void> markAsSold(String listingId) async {
    final userId = await _requireCurrentUserId();
    await _connector
        .updateListing(id: listingId)
        .status(ListingStatus.SOLD)
        .execute();

    await _connector
        .createListingHistory(
          listingId: listingId,
          changedById: userId,
          fieldName: 'status',
        )
        .oldValue('AVAILABLE')
        .newValue('SOLD')
        .execute();

    final idx = listings.indexWhere((l) => l.id == listingId);
    if (idx >= 0) {
      final soldListing = listings[idx].copyWith(sold: true);
      listings[idx] = soldListing;
      await _notifyInterestedBuyers(
        sellerId: userId,
        listingId: listingId,
        type: NotificationType.LISTING_SOLD,
        title: '${soldListing.title} was marked as sold',
        body: 'This uniform has found a new home.',
      );
    }
  }

  Future<void> softDelete(String listingId) async {
    await _connector.softDeleteListing(id: listingId).execute();
    listings.removeWhere((l) => l.id == listingId);
  }

  Future<void> _notifyInterestedBuyers({
    required String sellerId,
    required String listingId,
    required NotificationType type,
    required String title,
    required String body,
  }) async {
    try {
      final convRes = await _connector
          .getUserConversations(userId: sellerId)
          .execute();
      final buyerIds = convRes.data.conversations
          .where((c) => c.listing.id == listingId && c.buyer.id != sellerId)
          .map((c) => c.buyer.id)
          .toSet();
      for (final buyerId in buyerIds) {
        await _notifications.createNotification(
          recipientUserId: buyerId,
          type: type,
          title: title,
          body: body,
          referenceId: listingId,
        );
      }
    } catch (_) {
      // Non-blocking notification failure
    }
  }

  Future<List<String>> _uploadAndAttachImages({
    required String listingId,
    required List<String> paths,
  }) async {
    final urls = <String>[];
    for (var i = 0; i < paths.length; i++) {
      final path = paths[i];
      if (path.startsWith('assets/')) {
        urls.add(path);
        continue;
      }
      final url = await _compressAndUploadImage(
        listingId: listingId,
        localPath: path,
        index: i,
      );
      urls.add(url);
      await _connector
          .createListingImage(
            listingId: listingId,
            imageUrl: url,
            isPrimary: i == 0,
            displayOrder: i,
          )
          .execute();
    }
    return urls;
  }

  Future<String> _compressAndUploadImage({
  required String listingId,
  required String localPath,
  required int index,
}) async {
  final file = File(localPath);
  final compressedBytes = await FlutterImageCompress.compressWithFile(
    file.absolute.path,
    quality: 65,
    minWidth: 800,
    minHeight: 800,
  );
  final bytes = compressedBytes ?? await file.readAsBytes();
  return 'data:image/jpeg;base64,${base64Encode(bytes)}';
}

  Future<void> _recordHistoryDiff({
    required String listingId,
    required String userId,
    required Listing previous,
    required Listing updated,
  }) async {
    final diffs = <String, (String, String)>{
      if (previous.title != updated.title)
        'title': (previous.title, updated.title),
      if (previous.price != updated.price)
        'price': (previous.price.toString(), updated.price.toString()),
      if (previous.sport != updated.sport)
        'uniformType': (previous.sport, updated.sport),
      if (previous.size != updated.size)
        'size': (previous.size, updated.size),
      if (previous.condition != updated.condition)
        'condition': (previous.condition, updated.condition),
      if (previous.description != updated.description)
        'description': (previous.description, updated.description),
    };

    for (final entry in diffs.entries) {
      await _connector
          .createListingHistory(
            listingId: listingId,
            changedById: userId,
            fieldName: entry.key,
          )
          .oldValue(entry.value.$1)
          .newValue(entry.value.$2)
          .execute();
    }
  }

  // --- Enum mapping helpers ---
  String _encodeDescription(String sport, String rawDescription) {
    final clean = rawDescription.replaceFirst(RegExp(r'^\[[^\]]+\]\s*'), '');
    return '[$sport] $clean';
  }

  (String sport, String cleanDescription) _decodeSportAndDescription(
    String? rawDescription,
    EnumValue<UniformType> fallbackEnum,
  ) {
    final text = rawDescription ?? '';
    final match = RegExp(r'^\[([^\]]+)\]\s*(.*)$', dotAll: true).firstMatch(text);
    if (match != null) {
      return (match.group(1)!, match.group(2)!);
    }
    return (_sportFromEnum(fallbackEnum), text);
  }

  UniformType _sportToEnum(String sport) => switch (sport) {
    'Basketball' ||
    'Volleyball' ||
    'Beach Volleyball' ||
    'Football' ||
    'Futsal' ||
    'Handball' ||
    'Korfball' ||
    'Sepak Takraw' ||
    'Softball' => UniformType.TEAM_SPORTS,
    'Swimming' => UniformType.SWIMMING,
    'Arnis' => UniformType.ARNIS,
    'Taekwondo' || 'Martial Arts' => UniformType.MARTIAL_ARTS,
    'Folk Dance' || 'Social Dance' || 'Dance' => UniformType.DANCE,
    'Fitness' ||
    'Philippine Games' ||
    'Adapted PE' ||
    'Regular PathFit' => UniformType.REGULAR_PATHFIT,
    _ => UniformType.OTHER,
  };

  String _sportFromEnum(EnumValue<UniformType> value) => switch (value.stringValue) {
    'TEAM_SPORTS' => 'Basketball',
    'SWIMMING' => 'Swimming',
    'ARNIS' => 'Arnis',
    'MARTIAL_ARTS' => 'Martial Arts',
    'DANCE' => 'Dance',
    'REGULAR_PATHFIT' => 'Regular PathFit',
    _ => 'Other',
  };

  UniformSizeType _sizeToEnum(String size) => switch (size) {
    'XS' => UniformSizeType.XS,
    'S' => UniformSizeType.S,
    'M' => UniformSizeType.M,
    'L' => UniformSizeType.L,
    'XL' => UniformSizeType.XL,
    '2XL' => UniformSizeType.SIZE_2XL,
    '3XL' => UniformSizeType.SIZE_3XL,
    _ => UniformSizeType.M,
  };

  String _sizeFromEnum(EnumValue<UniformSizeType> value) => switch (value.stringValue) {
    'XS' => 'XS',
    'S' => 'S',
    'M' => 'M',
    'L' => 'L',
    'XL' => 'XL',
    'SIZE_2XL' => '2XL',
    'SIZE_3XL' => '3XL',
    _ => 'M',
  };

  UniformSetType _setTypeToEnum(String included) => switch (included) {
    'Complete set' => UniformSetType.COMPLETE_SET,
    'Top only' => UniformSetType.TOP_ONLY,
    'Bottom only' => UniformSetType.BOTTOM_ONLY,
    _ => UniformSetType.COMPLETE_SET,
  };

  String _setTypeFromEnum(EnumValue<UniformSetType> value) => switch (value.stringValue) {
    'COMPLETE_SET' => 'Complete set',
    'TOP_ONLY' => 'Top only',
    'BOTTOM_ONLY' => 'Bottom only',
    _ => 'Complete set',
  };

  OwnerGenderType _genderToEnum(String wornBy) =>
      wornBy == 'Female' ? OwnerGenderType.WOMAN_OWNED : OwnerGenderType.MAN_OWNED;

  String _genderFromEnum(EnumValue<OwnerGenderType> value) =>
      value.stringValue == 'WOMAN_OWNED' ? 'Female' : 'Male';

  ItemConditionType _conditionToEnum(String condition) => switch (condition) {
    'Brand new' => ItemConditionType.BRAND_NEW,
    'Like new' => ItemConditionType.LIKE_NEW,
    'Good' || 'Gently used' => ItemConditionType.GENTLY_USED,
    'Well-used' || 'Used with flaws' => ItemConditionType.USED_WITH_FLAWS,
    _ => ItemConditionType.GENTLY_USED,
  };

  String _conditionFromEnum(EnumValue<ItemConditionType> value) => switch (value.stringValue) {
    'BRAND_NEW' => 'Brand new',
    'LIKE_NEW' => 'Like new',
    'GENTLY_USED' => 'Good',
    'USED_WITH_FLAWS' => 'Well-used',
    _ => 'Good',
  };
}