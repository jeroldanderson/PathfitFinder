import 'dart:async';

import 'package:flutter/material.dart';

import '../controllers/chat_controller.dart';
import '../controllers/marketplace_controller.dart';
import '../controllers/notification_controller.dart';
import '../models/listing.dart';
import '../theme.dart';
import '../widgets/listing_card.dart';
import '../widgets/shared.dart';
import 'chat_screen.dart';
import 'filter_sheet.dart';
import 'listing_details_screen.dart';
import 'notifications_sheet.dart';
import 'profile_screen.dart';
import 'sell_screen.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});
  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  final _market = MarketplaceController();
  final _chat = ChatController();
  final _notifications = NotificationController();
  final _search = TextEditingController();
  Timer? _inboxPollTimer;
  int _tab = 0;

  @override
  void initState() {
    super.initState();
    _market.load();
    _chat.loadInbox();
    _notifications.start();
    _inboxPollTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      if (mounted) _chat.loadInbox();
    });
  }

  @override
  void dispose() {
    _inboxPollTimer?.cancel();
    _market.dispose();
    _chat.dispose();
    _notifications.dispose();
    _search.dispose();
    super.dispose();
  }

  void _details(Listing listing) => Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (_) =>
          ListingDetailsScreen(id: listing.id, market: _market, chat: _chat),
    ),
  );

  void _sell() => Navigator.push(
    context,
    MaterialPageRoute<void>(builder: (_) => SellScreen(market: _market)),
  );

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: _market,
    builder: (context, _) => Scaffold(
      body: SafeArea(
        child: switch (_tab) {
          0 => _browse(),
          1 => _saved(),
          3 => _inbox(),
          _ => ProfileScreen(market: _market, chat: _chat),
        },
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: ListenableBuilder(
          listenable: _chat,
          builder: (context, _) {
            final hasUnreadInbox = _chat.conversations.any((c) => c.hasUnread);
            return Container(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: line)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: List.generate(5, (i) {
                  const labels = ['Browse', 'Saved', 'Sell', 'Inbox', 'Profile'];
                  const icons = [
                    '77e7b.svg',
                    'a9e90.svg',
                    'b3ede.svg',
                    '5d4a9.svg',
                    '7674b.svg',
                  ];
                  return Expanded(
                    child: Semantics(
                      selected: i == _tab,
                      child: InkWell(
                        key: Key('nav-${labels[i]}'),
                        onTap: () {
                          if (i == 2) {
                            _sell();
                          } else {
                            setState(() => _tab = i);
                            if (i == 3) _chat.loadInbox();
                          }
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 42,
                                  height: 42,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: i == 2 ? yellow : Colors.transparent,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: DesignIcon(icons[i]),
                                ),
                                if (i == 3 && hasUnreadInbox)
                                  Positioned(
                                    right: 6,
                                    top: 6,
                                    child: Container(
                                      width: 9,
                                      height: 9,
                                      decoration: BoxDecoration(
                                        color: yellow,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Text(
                              labels[i],
                              style: TextStyle(
                                fontSize: 9,
                                color: _tab == i ? ink : muted,
                                fontWeight: _tab == i
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          },
        ),
      ),
    ),
  );

  Widget _browse() => RefreshIndicator(
    color: ink,
    backgroundColor: Colors.white,
    onRefresh: () async {
      await Future.wait([
        _market.load(),
        _chat.loadInbox(),
        _notifications.load(),
      ]);
    },
    child: PageBody(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'PathFitFinder',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
              ListenableBuilder(
                listenable: _notifications,
                builder: (context, _) => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      tooltip: 'Notifications',
                      onPressed: () => showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.sizeOf(context).height * .75,
                        ),
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(26),
                          ),
                        ),
                        builder: (_) => NotificationsSheet(
                          controller: _notifications,
                          onTapNotification: (n) {
                            if (n.type == 'NEW_MESSAGE') {
                              setState(() => _tab = 3);
                              _chat.loadInbox();
                            } else if (n.referenceId != null) {
                              final listing = _market.find(n.referenceId!);
                              if (listing != null) _details(listing);
                            }
                          },
                        ),
                      ),
                      icon: const Icon(Icons.notifications_outlined, color: ink),
                    ),
                    if (_notifications.unreadCount > 0)
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Container(
                          width: 9,
                          height: 9,
                          decoration: const BoxDecoration(
                            color: yellow,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Good finds. Fellow Thomasians.',
            style: TextStyle(fontSize: 13, color: muted),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  key: const Key('search'),
                  controller: _search,
                  onChanged: _market.search,
                  style: const TextStyle(fontSize: 12),
                  decoration: const InputDecoration(
                    hintText: 'Search PATHFIT uniforms',
                    hintStyle: TextStyle(fontSize: 12, color: muted),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(15),
                      child: DesignIcon('9393b.svg', size: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 50,
                height: 50,
                child: IconButton.filled(
                  tooltip: 'Open filters',
                  style: IconButton.styleFrom(
                    backgroundColor: ink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  onPressed: () => showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.sizeOf(context).height * .92,
                    ),
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(26),
                      ),
                    ),
                    builder: (_) => FilterSheet(controller: _market),
                  ),
                  icon: const DesignIcon('c8e9d.svg'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cream,
              borderRadius: BorderRadius.circular(17),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NEW SEMESTER, SAME SPIRIT',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: .6,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'A new home for your old uniform.',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 22),
                    ],
                  ),
                ),
                IconButton.filled(
                  tooltip: 'Sell a uniform',
                  onPressed: _sell,
                  style: IconButton.styleFrom(
                    backgroundColor: yellow,
                    foregroundColor: ink,
                  ),
                  icon: const Text(
                    '↗',
                    style: TextStyle(fontSize: 36, height: 1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['All uniforms', ...kPathFitSports].map((label) {
                final selected = label == 'All uniforms'
                    ? _market.filter.sport == 'All sports'
                    : _market.filter.sport == label;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(label),
                    selected: selected,
                    showCheckmark: false,
                    selectedColor: ink,
                    backgroundColor: surface,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : ink,
                      fontSize: 12,
                    ),
                    onSelected: (_) => _market.applyFilter(
                      ListingFilter(
                        sport: label == 'All uniforms' ? 'All sports' : label,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Fresh from the campus',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                ),
              ),
              TextButton(
                onPressed: () {
                  _search.clear();
                  _market.search('');
                  _market.applyFilter(const ListingFilter());
                },
                child: const Text(
                  'View all',
                  style: TextStyle(fontSize: 11, color: muted),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          _grid(_market.results()),
        ],
      ),
    ),
  );

  Widget _grid(List<Listing> listings) {
    if (listings.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Center(
          child: Text(
            'No uniforms found. Try a different filter.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final count = constraints.maxWidth > 480 ? 3 : 2;
        final width = (constraints.maxWidth - 16 * (count - 1)) / count;
        return Wrap(
          spacing: 16,
          runSpacing: 18,
          children: listings
              .map(
                (l) => SizedBox(
                  width: width,
                  child: ListingCard(
                    listing: l,
                    controller: _market,
                    onTap: () => _details(l),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget _saved() => RefreshIndicator(
    color: ink,
    backgroundColor: Colors.white,
    onRefresh: _market.load,
    child: PageBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Saved uniforms',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your next fit, kept in one place.',
            style: TextStyle(color: muted),
          ),
          const SizedBox(height: 24),
          if (_market.saved.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 60),
              child: Center(child: Text('Tap a heart to save a uniform.')),
            )
          else
            _grid(_market.saved),
        ],
      ),
    ),
  );

  Widget _inbox() => ListenableBuilder(
    listenable: _chat,
    builder: (context, _) => RefreshIndicator(
      color: ink,
      backgroundColor: Colors.white,
      onRefresh: _chat.loadInbox,
      child: PageBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Campus conversations',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              'Direct messages with fellow Thomasians.',
              style: TextStyle(fontSize: 12, color: muted),
            ),
            const SizedBox(height: 24),
            if (_chat.conversations.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(
                  child: Text(
                    'No conversations yet. Message a seller from any listing!',
                  ),
                ),
              )
            else
              ..._chat.conversations.map(
                (conv) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Photo(
                    conv.listing.images.first,
                    width: 48,
                    height: 48,
                    radius: 12,
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          conv.otherPartyName,
                          style: TextStyle(
                            fontWeight: conv.hasUnread
                                ? FontWeight.w700
                                : FontWeight.w600,
                          ),
                        ),
                      ),
                      if (conv.hasUnread)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: yellow,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  subtitle: Text(
                    conv.listing.deleted
                        ? 'Listing deleted · ${conv.listing.title}'
                        : '${conv.listing.title} · ${conv.lastMessage}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: conv.listing.deleted ? Colors.red.shade700 : muted,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => ChatScreen(
                          listing: conv.listing,
                          controller: _chat,
                        ),
                      ),
                    );
                    _chat.loadInbox();
                  },
                ),
              ),
          ],
        ),
      ),
    ),
  );
}