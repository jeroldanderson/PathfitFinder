import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controllers/chat_controller.dart';
import '../controllers/marketplace_controller.dart';
import '../theme.dart';
import '../widgets/shared.dart';
import 'chat_screen.dart';
import 'sell_screen.dart';

class ListingDetailsScreen extends StatefulWidget {
  const ListingDetailsScreen({
    super.key,
    required this.id,
    required this.market,
    required this.chat,
    this.sellerView = false,
  });
  final String id;
  final MarketplaceController market;
  final ChatController chat;
  final bool sellerView;
  @override
  State<ListingDetailsScreen> createState() => _ListingDetailsScreenState();
}

class _ListingDetailsScreenState extends State<ListingDetailsScreen> {
  int _photo = 0;
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: widget.market,
    builder: (context, _) {
      final listing = widget.market.find(widget.id);
      if (listing == null) {
        return Scaffold(
          appBar: AppBar(title: const Text('Listing removed')),
          body: const Center(
            child: Text('This listing is no longer available.'),
          ),
        );
      }
      final photo = _photo.clamp(0, listing.images.length - 1);
      return Scaffold(
        appBar: AppBar(
          title: const Text('The uniform edit'),
          actions: [
            IconButton(
              tooltip: 'Copy listing details',
              icon: const DesignIcon('10eb9.svg', size: 21),
              onPressed: () async {
                await Clipboard.setData(
                  ClipboardData(
                    text:
                        '${listing.title} · ₱${listing.price} · PathFitFinder preview',
                  ),
                );
                if (context.mounted) {
                  showNotice(context, 'Listing details copied.');
                }
              },
            ),
            const SizedBox(width: 12),
          ],
        ),
        body: SafeArea(
          child: PageBody(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 354 / 262,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Photo(listing.images[photo], radius: 17),
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: ink,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Text(
                            '${photo + 1} / ${listing.images.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ...List.generate(
                      listing.images.length,
                      (i) => InkWell(
                        onTap: () => setState(() => _photo = i),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: photo == i ? yellow : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Photo(
                            listing.images[i],
                            width: 48,
                            height: 41,
                            radius: 6,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: cream,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${listing.sold ? 'Sold' : listing.condition} · ${listing.included}',
                        style: const TextStyle(fontSize: 9),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  listing.title,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '₱${listing.price}',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Text(
                      'Posted 2 hours ago',
                      style: TextStyle(fontSize: 10, color: muted),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      _spec('SIZE', _sizeName(listing.size)),
                      _spec('WORN BY', listing.wornBy),
                      _spec(
                        'NUMBER',
                        listing.number.isEmpty ? 'None' : listing.number,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  listing.description,
                  style: const TextStyle(color: muted, fontSize: 13),
                ),
                const SizedBox(height: 18),
                const Divider(),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Photo(
                      'assets/figma/b7f5c.png',
                      width: 44,
                      height: 44,
                      radius: 22,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Mika Reyes',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 12),
                              DesignIcon('2a77e.svg', size: 16),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            'UST student · College of Science',
                            style: TextStyle(fontSize: 11, color: muted),
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
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
            child: listing.sold
                ? const Text(
                    'This uniform has found a new home.',
                    textAlign: TextAlign.center,
                  )
                : widget.sellerView
                ? Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (_) => SellScreen(
                                market: widget.market,
                                existing: listing,
                              ),
                            ),
                          ),
                          child: const Text('Edit Listing'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: PrimaryButton(
                          'Mark as Sold',
                          onPressed: () => widget.market.markSold(listing.id),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      IconButton(
                        tooltip: 'Save uniform',
                        onPressed: () => widget.market.toggleSaved(listing.id),
                        icon: widget.market.isSaved(listing.id)
                            ? const Icon(Icons.favorite)
                            : const DesignIcon('c4699.svg'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: PrimaryButton(
                          'Message seller',
                          icon: const DesignIcon('3ea02.svg', size: 20),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (_) => ChatScreen(
                                listing: listing,
                                controller: widget.chat,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      );
    },
  );
  Widget _spec(String label, String value) => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, color: muted)),
        const SizedBox(height: 10),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
  String _sizeName(String size) => switch (size) {
    'S' => 'Small',
    'M' => 'Medium',
    'L' => 'Large',
    _ => size,
  };
}
