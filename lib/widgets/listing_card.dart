import 'package:flutter/material.dart';

import '../controllers/marketplace_controller.dart';
import '../models/listing.dart';
import '../theme.dart';
import 'shared.dart';

class ListingCard extends StatelessWidget {
  const ListingCard({
    super.key,
    required this.listing,
    required this.controller,
    required this.onTap,
  });
  final Listing listing;
  final MarketplaceController controller;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 169 / 115,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Photo(listing.images.first),
              Positioned(
                right: 8,
                top: 8,
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                    ),
                    tooltip: controller.isSaved(listing.id)
                        ? 'Unsave uniform'
                        : 'Save uniform',
                    onPressed: () => controller.toggleSaved(listing.id),
                    icon: controller.isSaved(listing.id)
                        ? const Icon(Icons.favorite, size: 18, color: ink)
                        : const DesignIcon('6215a.svg', size: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 7),
        Text(
          listing.id == 'basketball' ? 'Basketball set' : listing.title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          '${listing.size} · ${listing.wornBy}-used · ${listing.condition}',
          style: const TextStyle(fontSize: 10, color: muted),
        ),
        const SizedBox(height: 3),
        Text(
          '₱${listing.price}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}
