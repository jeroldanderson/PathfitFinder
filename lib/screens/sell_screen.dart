import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controllers/listing_editor_controller.dart';
import '../controllers/marketplace_controller.dart';
import '../models/listing.dart';
import '../theme.dart';
import '../widgets/shared.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key, required this.market, this.existing});
  final MarketplaceController market;
  final Listing? existing;
  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final _form = GlobalKey<FormState>();
  late final ListingEditorController _editor;
  bool get _editing => widget.existing != null;
  @override
  void initState() {
    super.initState();
    _editor = ListingEditorController(
      initial: widget.existing ?? widget.market.draft,
    );
  }

  @override
  void dispose() {
    _editor.dispose();
    super.dispose();
  }

  void _save() {
    final formValid = _form.currentState!.validate();
    final photosValid = _editor.validatePhotos();
    if (!formValid || !photosValid) return;
    widget.market.save(_editor.buildListing());
    showNotice(
      context,
      _editing
          ? 'Preview listing updated for this session.'
          : 'Listing added to the preview for this session.',
    );
    Navigator.pop(context);
  }

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete this listing?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.existing!.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const Text(
              'This removes your preview listing. If it found a new home, mark it as sold instead to keep it in your history.',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep listing'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Delete Listing',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      widget.market.delete(widget.existing!.id);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: _editor,
    builder: (context, _) => Scaffold(
      appBar: AppBar(
        title: Text(_editing ? 'Edit listing' : 'Sell a uniform'),
        actions: [
          TextButton(
            onPressed: _editing
                ? _delete
                : () {
                    widget.market.saveDraft(_editor.buildListing());
                    showNotice(
                      context,
                      'Draft saved for this preview session.',
                    );
                  },
            child: Text(
              _editing ? 'Delete Listing' : 'Save draft',
              style: const TextStyle(fontSize: 11),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: PageBody(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _editing
                      ? 'Update your uniform.'
                      : 'Ready for its next class.',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _editing
                      ? 'Keep the details right for your next buyer.'
                      : 'Make space. Help a fellow Thomasian.',
                  style: const TextStyle(fontSize: 13, color: muted),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 110,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...List.generate(
                        _editor.images.length,
                        (i) => Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: SizedBox(
                            width: 106,
                            child: Stack(
                              children: [
                                Photo(
                                  _editor.images[i],
                                  width: 106,
                                  height: 104,
                                ),
                                if (i == 0)
                                  Positioned(
                                    left: 7,
                                    bottom: 10,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Text(
                                        'Cover',
                                        style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                Positioned(
                                  top: 2,
                                  right: 2,
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: IconButton.filled(
                                      tooltip: 'Remove photo',
                                      onPressed: () => _editor.removePhoto(i),
                                      style: IconButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: ink,
                                        padding: EdgeInsets.zero,
                                      ),
                                      icon: const Icon(Icons.close, size: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (_editor.images.length < 6)
                        SizedBox(
                          width: 118,
                          height: 104,
                          child: OutlinedButton(
                            onPressed: _editor.picking
                                ? null
                                : () => _editor.pick(),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DesignIcon('b3ede.svg'),
                                SizedBox(height: 12),
                                Text(
                                  'Add photo',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _editor.picking
                            ? null
                            : () => _editor.pick(camera: true),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DesignIcon('835c5.svg', size: 20),
                            SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                'Take photo',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _editor.picking
                            ? null
                            : () => _editor.pick(),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DesignIcon('29627.svg', size: 20),
                            SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                'From gallery',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (_editor.picking) const LinearProgressIndicator(),
                if (_editor.error != null)
                  Text(
                    _editor.error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                if (_editor.images.isEmpty)
                  TextButton(
                    onPressed: _editor.addSamplePhotos,
                    child: const Text(
                      'Use sample uniform photos for preview',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                const SizedBox(height: 16),
                Field(
                  'Price',
                  child: TextFormField(
                    key: const Key('listing-price'),
                    initialValue: _editor.price,
                    onChanged: (v) => _editor.price = v,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: ListingEditorController.validatePrice,
                    decoration: const InputDecoration(
                      prefixText: '₱ ',
                      hintText: '350',
                    ),
                  ),
                ),
                Field(
                  'Uniform type',
                  child: _dropdown(_editor.sport, const [
                    'Fitness',
                    'Arnis',
                    'Badminton',
                    'Pickle Ball',
                    'Spike Ball',
                    'Swimming',
                    'Table Tennis',
                    'Taekwondo',
                    'Track and Field',
                    'Folk Dance',
                    'Social Dance',
                    'Philippine Games',
                    'Adapted PE',
                    'Basketball',
                    'Beach Volleyball',
                    'Football',
                    'Futsal',
                    'Handball',
                    'Korfball',
                    'Sepak Takraw',
                    'Softball',
                    'Volleyball'
                  ], (v) => _editor.sport = v),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Field(
                        'Size',
                        child: _dropdown(_editor.size, const [
                          'XS',
                          'S',
                          'M',
                          'L',
                          'XL',
                          '2XL',
                        ], (v) => _editor.size = v),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Field(
                        'Condition',
                        child: _dropdown(_editor.condition, const [
                          'Like new',
                          'Good',
                          'Well-used',
                        ], (v) => _editor.condition = v),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Field(
                        'Previously worn by',
                        child: _dropdown(_editor.wornBy, const [
                          'Male',
                          'Female',
                        ], (v) => _editor.wornBy = v),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Field(
                        'Jersey number (optional)',
                        child: TextFormField(
                          initialValue: _editor.number,
                          onChanged: (v) => _editor.number = v,
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            hintText: '12',
                            counterText: '',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Field(
                  'What’s included',
                  child: _dropdown(_editor.included, const [
                    'Complete set',
                    'Separates',
                  ], (v) => _editor.included = v),
                ),
                Field(
                  'Tell its story',
                  child: TextFormField(
                    key: const Key('listing-description'),
                    initialValue: _editor.description,
                    onChanged: (v) => _editor.description = v,
                    maxLength: 300,
                    minLines: 3,
                    maxLines: 5,
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Describe the uniform and its condition.'
                        : null,
                    decoration: const InputDecoration(
                      hintText: 'How was it used? Mention any marks or wear.',
                    ),
                  ),
                ),
                const Text(
                  'Preview only. Listings and drafts last for this session.',
                  style: TextStyle(fontSize: 11, color: muted),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  _editing ? 'Save Changes' : 'Publish preview listing',
                  onPressed: _save,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
  Widget _dropdown(
    String value,
    List<String> options,
    ValueChanged<String> changed,
  ) => DropdownButtonFormField<String>(
    initialValue: value,
    isExpanded: true,
    icon: const DesignIcon('88006.svg', size: 18),
    style: const TextStyle(fontFamily: 'Inter', fontSize: 13, color: ink),
    items: options
        .map(
          (v) => DropdownMenuItem(
            value: v,
            child: Text(v, overflow: TextOverflow.ellipsis),
          ),
        )
        .toList(),
    onChanged: (v) {
      if (v != null) changed(v);
    },
  );
}
