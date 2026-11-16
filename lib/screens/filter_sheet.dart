import 'package:flutter/material.dart';

import '../controllers/marketplace_controller.dart';
import '../models/listing.dart';
import '../theme.dart';
import '../widgets/shared.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key, required this.controller});
  final MarketplaceController controller;
  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late String sport, wornBy, size, number, condition, included, sort;
  @override
  void initState() {
    super.initState();
    _set(widget.controller.filter);
  }

  void _set(ListingFilter f) {
    sport = f.sport;
    wornBy = f.wornBy;
    size = f.size;
    number = f.number;
    condition = f.condition;
    included = f.included;
    sort = f.sort;
  }

  ListingFilter get _filter => ListingFilter(
    sport: sport,
    wornBy: wornBy,
    size: size,
    number: number,
    condition: condition,
    included: included,
    sort: sort,
  );
  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Container(
            width: 50,
            height: 4,
            decoration: BoxDecoration(
              color: line,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Find your fit',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Close filters',
                        onPressed: () => Navigator.pop(context),
                        icon: const DesignIcon('d0c64.svg', size: 20),
                      ),
                    ],
                  ),
                  const Text(
                    'Only the uniforms that work for you.',
                    style: TextStyle(fontSize: 12, color: muted),
                  ),
                  const SizedBox(height: 24),
                  ChoiceGroup(
                    'Sport type',
                    const ['All sports', 'Basketball', 'Volleyball', 'Fitness'],
                    sport,
                    (v) => setState(() => sport = v),
                  ),
                  ChoiceGroup(
                    'Previously worn by',
                    const ['Any', 'Male', 'Female'],
                    wornBy,
                    (v) => setState(() => wornBy = v),
                  ),
                  ChoiceGroup(
                    'Size',
                    const ['Any', 'XS', 'S', 'M', 'L', 'XL', '2XL'],
                    size,
                    (v) => setState(() => size = v),
                  ),
                  ChoiceGroup(
                    'Jersey number',
                    const ['Any', 'With number', 'Without number'],
                    number,
                    (v) => setState(() => number = v),
                  ),
                  ChoiceGroup(
                    'Condition',
                    const ['Any', 'Like new', 'Good', 'Well-used'],
                    condition,
                    (v) => setState(() => condition = v),
                  ),
                  ChoiceGroup(
                    'What’s included',
                    const ['Any', 'Complete set', 'Separates'],
                    included,
                    (v) => setState(() => included = v),
                  ),
                  ChoiceGroup(
                    'Sort by price',
                    const ['Newest', 'Low to high', 'High to low'],
                    sort,
                    (v) => setState(() => sort = v),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                TextButton(
                  onPressed: () => setState(() => _set(const ListingFilter())),
                  child: const Text('Reset'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
                    'Show ${widget.controller.results(using: _filter).length} uniforms',
                    onPressed: () {
                      widget.controller.applyFilter(_filter);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
