import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controllers/chat_controller.dart';
import '../controllers/marketplace_controller.dart';
import '../dataconnect_generated/generated.dart';
import '../models/listing.dart';
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

  void _openFullScreenGallery(List<String> images, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => _FullScreenPhotoViewer(
          images: images,
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  Widget _sellerSection(Listing listing) {
    final hasAvatar =
        listing.sellerAvatarUrl != null &&
        listing.sellerAvatarUrl!.trim().isNotEmpty;
    final initial = listing.sellerName.trim().isNotEmpty
        ? listing.sellerName.trim()[0].toUpperCase()
        : 'T';
    final college = listing.sellerCollege.trim();

    return Row(
      children: [
        if (hasAvatar)
          Photo(listing.sellerAvatarUrl!, width: 44, height: 44, radius: 22)
        else
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: cream,
              shape: BoxShape.circle,
            ),
            child: Text(
              initial,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: ink,
              ),
            ),
          ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      listing.owned
                          ? '${listing.sellerName} (You)'
                          : listing.sellerName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  if (listing.sellerVerified) ...[
                    const SizedBox(width: 8),
                    const DesignIcon('2a77e.svg', size: 16),
                  ],
                ],
              ),
              if (college.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  college,
                  style: const TextStyle(fontSize: 11, color: muted),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _onMessageSeller(Listing listing) async {
    if (listing.owned) {
      showNotice(context, 'You cannot start a conversation with yourself.');
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      showNotice(
        context,
        "You're in preview mode only. Sign in with your @ust.edu.ph account to message sellers.",
      );
      return;
    }

    try {
      final res = await ExampleConnector.instance
          .getUserByEmail(email: user.email!.trim().toLowerCase())
          .execute();
      final status = res.data.users.isNotEmpty
          ? res.data.users.first.verificationStatus.stringValue
          : 'PENDING';
      if (status != 'VERIFIED') {
        if (!mounted) return;
        showNotice(
          context,
          status == 'REJECTED'
              ? 'Your UST ID submission was rejected. You cannot message sellers.'
              : 'Your UST ID or Registration Form is still under review. You can browse while waiting for approval.',
        );
        return;
      }

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (_) => ChatScreen(
            listing: listing,
            controller: widget.chat,
          ),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      showNotice(context, 'Could not verify account status. Try again.');
    }
  }

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
      final isOwner = widget.sellerView || listing.owned;

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
                        '${listing.title} · ₱${listing.price} · PathFitFinder',
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
                GestureDetector(
                  onTap: () => _openFullScreenGallery(listing.images, photo),
                  child: AspectRatio(
                    aspectRatio: 354 / 262,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Photo(listing.images[photo], radius: 17),
                        Positioned(
                          left: 14,
                          bottom: 14,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: ink.withValues(alpha: 0.78),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.zoom_out_map,
                                  color: Colors.white,
                                  size: 13,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Tap to view full photo',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 16,
                          bottom: 14,
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
                      'Campus listing',
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
                _sellerSection(listing),
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
                : isOwner
                ? Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: widget.market.loading
                              ? null
                              : () => Navigator.push(
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
                          loading: widget.market.loading,
                          onPressed: () async {
                            await widget.market.markSold(listing.id);
                            if (context.mounted) {
                              showNotice(context, 'Marked as sold.');
                            }
                          },
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
                          onPressed: () => _onMessageSeller(listing),
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

class _FullScreenPhotoViewer extends StatefulWidget {
  const _FullScreenPhotoViewer({
    required this.images,
    required this.initialIndex,
  });
  final List<String> images;
  final int initialIndex;

  @override
  State<_FullScreenPhotoViewer> createState() => _FullScreenPhotoViewerState();
}

class _FullScreenPhotoViewerState extends State<_FullScreenPhotoViewer> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          '${_currentIndex + 1} / ${widget.images.length}',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.images.length,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (context, index) => InteractiveViewer(
                  minScale: 1.0,
                  maxScale: 4.0,
                  child: Center(
                    child: Photo(
                      widget.images[index],
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                      radius: 0,
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text(
                'Pinch to zoom · Swipe to browse photos',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}