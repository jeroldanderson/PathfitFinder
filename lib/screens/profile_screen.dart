import 'package:flutter/material.dart';

import '../controllers/chat_controller.dart';
import '../controllers/marketplace_controller.dart';
import '../theme.dart';
import '../widgets/shared.dart';
import 'listing_details_screen.dart';
import 'sell_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.market, required this.chat});
  final MarketplaceController market;
  final ChatController chat;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _sold = false;
  @override
  Widget build(BuildContext context) {
    final all = widget.market.all.where((l) => l.owned).toList();
    final listings = all.where((l) => l.sold == _sold).toList();
    return PageBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 26),
          const Row(
            children: [
              Photo(
                'assets/figma/b7f5c.png',
                width: 64,
                height: 64,
                radius: 22,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mika Reyes',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'UST student · College of Science',
                      style: TextStyle(fontSize: 11, color: muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Sample profile · You are exploring the marketplace preview.',
            style: TextStyle(fontSize: 11, color: muted),
          ),
          const SizedBox(height: 22),
          const Text(
            'My listings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          const Text(
            'Your uniforms, ready for their next class.',
            style: TextStyle(fontSize: 11, color: muted),
          ),
          const SizedBox(height: 12),
          Row(
            children: [false, true]
                .map(
                  (sold) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: sold ? 0 : 12),
                      child: ChoiceChip(
                        showCheckmark: false,
                        selected: _sold == sold,
                        label: Center(
                          child: Text(
                            '${sold ? 'Sold' : 'Active'} · ${all.where((l) => l.sold == sold).length}',
                          ),
                        ),
                        selectedColor: ink,
                        backgroundColor: surface,
                        side: BorderSide.none,
                        labelStyle: TextStyle(
                          fontSize: 12,
                          color: _sold == sold ? Colors.white : ink,
                        ),
                        shape: const StadiumBorder(),
                        onSelected: (_) => setState(() => _sold = sold),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          if (listings.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text('No listings here yet.'),
            ),
          ...listings.map(
            (l) => Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: line),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => ListingDetailsScreen(
                          id: l.id,
                          market: widget.market,
                          chat: widget.chat,
                          sellerView: true,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Photo(l.images.first, width: 88, height: 88),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l.title,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${l.size} · ${l.wornBy}-used · ${l.condition}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: muted,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '₱${l.price}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!l.sold) ...[
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: surface,
                              minimumSize: const Size(0, 44),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (_) => SellScreen(
                                  market: widget.market,
                                  existing: l,
                                ),
                              ),
                            ),
                            child: const Text('Edit'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PrimaryButton(
                            'Mark as Sold',
                            onPressed: () => widget.market.markSold(l.id),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Back to sign up / log in'),
          ),
        ],
      ),
    );
  }
}
