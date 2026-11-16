class Listing {
  const Listing({
    required this.id,
    required this.title,
    required this.price,
    required this.sport,
    required this.size,
    required this.wornBy,
    required this.condition,
    required this.images,
    this.number = '',
    this.included = 'Complete set',
    this.description = '',
    this.owned = false,
    this.sold = false,
  });
  final String id,
      title,
      sport,
      size,
      wornBy,
      condition,
      number,
      included,
      description;
  final int price;
  final List<String> images;
  final bool owned, sold;
  Listing copyWith({
    String? title,
    int? price,
    String? sport,
    String? size,
    String? wornBy,
    String? condition,
    String? number,
    String? included,
    String? description,
    List<String>? images,
    bool? sold,
  }) => Listing(
    id: id,
    title: title ?? this.title,
    price: price ?? this.price,
    sport: sport ?? this.sport,
    size: size ?? this.size,
    wornBy: wornBy ?? this.wornBy,
    condition: condition ?? this.condition,
    number: number ?? this.number,
    included: included ?? this.included,
    description: description ?? this.description,
    images: images ?? this.images,
    owned: owned,
    sold: sold ?? this.sold,
  );
}

class ListingFilter {
  const ListingFilter({
    this.sport = 'All sports',
    this.wornBy = 'Any',
    this.size = 'Any',
    this.number = 'Any',
    this.condition = 'Any',
    this.included = 'Any',
    this.sort = 'Newest',
  });
  final String sport, wornBy, size, number, condition, included, sort;
  bool matches(Listing l) =>
      !l.sold &&
      (sport == 'All sports' || l.sport == sport) &&
      (wornBy == 'Any' || l.wornBy == wornBy) &&
      (size == 'Any' || l.size == size) &&
      (number == 'Any' ||
          (number == 'With number' ? l.number.isNotEmpty : l.number.isEmpty)) &&
      (condition == 'Any' || l.condition == condition) &&
      (included == 'Any' || l.included == included);
}
