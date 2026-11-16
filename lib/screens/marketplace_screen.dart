import 'package:flutter/material.dart';

import '../controllers/chat_controller.dart';
import '../controllers/marketplace_controller.dart';
import '../models/listing.dart';
import '../theme.dart';
import '../widgets/listing_card.dart';
import '../widgets/shared.dart';
import 'chat_screen.dart';
import 'filter_sheet.dart';
import 'listing_details_screen.dart';
import 'sell_screen.dart';
import 'profile_screen.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});
  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  final _market = MarketplaceController();
  final _chat = ChatController();
  final _search = TextEditingController();
  late final Listing _conversationListing;
  int _tab = 0;
  @override
  void initState() {
    super.initState();
    _conversationListing = _market.find('basketball')!;
  }

  @override
  void dispose() {
    _market.dispose();
    _chat.dispose();
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
        child: Container(
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
                    onTap: () => i == 2 ? _sell() : setState(() => _tab = i),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
        ),
      ),
    ),
  );
  Widget _browse() => PageBody(
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
            Tooltip(
              message: 'Marketplace preview',
              child: Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: cream,
                  shape: BoxShape.circle,
                ),
                child: const DesignIcon('7787a.svg', size: 20),
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
            children: ['All uniforms', 'Basketball', 'Volleyball'].map((label) {
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

  Widget _saved() => PageBody(
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
  );
  Widget _inbox() => PageBody(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Campus conversations',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        const Text(
          'Preview messages stay on this device for this session.',
          style: TextStyle(fontSize: 12, color: muted),
        ),
        const SizedBox(height: 24),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Photo(
            'assets/figma/b7f5c.png',
            width: 48,
            height: 48,
            radius: 24,
          ),
          title: const Text(
            'Mika Reyes',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: const Text('Basketball PATHFIT set'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) =>
                  ChatScreen(listing: _conversationListing, controller: _chat),
            ),
          ),
        ),
      ],
    ),
  );
}
