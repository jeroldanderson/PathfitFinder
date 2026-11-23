import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../controllers/chat_controller.dart';
import '../controllers/marketplace_controller.dart';
import '../dataconnect_generated/generated.dart';
import '../services/firebase_auth_service.dart';
import '../services/media_service.dart';
import '../theme.dart';
import '../widgets/shared.dart';
import 'admin_verification_screen.dart';
import 'auth_screen.dart';
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
  final _media = MediaService();
  bool _sold = false;
  bool _uploadingAvatar = false;
  String? _userId;
  String? _fullName;
  String? _collegeOrFaculty;
  String? _avatarUrl;
  String _verificationStatus = 'PENDING';
  String _role = 'STUDENT';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _confirmDelete(String listingId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete listing?'),
        content: const Text(
          'This will remove your uniform listing from the marketplace.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      await widget.market.delete(listingId);
      if (mounted) {
        showNotice(context, 'Listing deleted.');
      }
    }
  }

  Future<void> _loadProfile() async {
    final email = FirebaseAuth.instance.currentUser?.email?.trim().toLowerCase();
    if (email == null || email.isEmpty) return;
    try {
      final res = await ExampleConnector.instance
          .getUserByEmail(email: email)
          .execute();
      if (mounted && res.data.users.isNotEmpty) {
        final user = res.data.users.first;
        setState(() {
          _userId = user.id;
          _fullName = user.fullName;
          _collegeOrFaculty = user.collegeOrFaculty;
          _avatarUrl = user.avatarUrl;
          _verificationStatus = user.verificationStatus.stringValue;
          _role = user.role.stringValue;
        });
      }
    } catch (_) {
      // Ignore if offline
    }
  }

  Future<void> _editProfileDetails(String currentName) async {
    if (_userId == null) return;
    final nameCtrl = TextEditingController(text: currentName);
    final collegeCtrl = TextEditingController(text: _collegeOrFaculty ?? '');

    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          20,
          24,
          MediaQuery.viewInsetsOf(ctx).bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit profile details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            const Text(
              'Help fellow Thomasians recognize you during campus meetups.',
              style: TextStyle(fontSize: 12, color: muted),
            ),
            const SizedBox(height: 18),
            const Text(
              'Display name',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                hintText: 'Your display name',
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'College or Faculty (optional)',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: collegeCtrl,
              decoration: const InputDecoration(
                hintText: 'e.g. College of Information and Computing Sciences',
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              'Save profile',
              onPressed: () => Navigator.pop(ctx, true),
            ),
          ],
        ),
      ),
    );

    if (saved != true || !mounted) return;
    final newName = nameCtrl.text.trim();
    if (newName.isEmpty) {
      showNotice(context, 'Display name cannot be empty.');
      return;
    }
    final newCollege = collegeCtrl.text.trim();

    try {
      await ExampleConnector.instance
          .updateUserProfile(id: _userId!, fullName: newName)
          .collegeOrFaculty(newCollege)
          .execute();
      await FirebaseAuth.instance.currentUser?.updateDisplayName(newName);
      if (mounted) {
        setState(() {
          _fullName = newName;
          _collegeOrFaculty = newCollege;
        });
        showNotice(context, 'Profile details updated.');
      }
      await widget.market.load();
    } catch (_) {
      if (mounted) {
        showNotice(context, 'Could not save profile changes. Try again.');
      }
    }
  }

  Future<void> _pickAndSaveAvatar() async {
    if (_uploadingAvatar || _userId == null) return;
    setState(() => _uploadingAvatar = true);
    try {
      final picked = await _media.pick();
      if (picked == null) return;

      final file = File(picked.path);
      final compressedBytes = await FlutterImageCompress.compressWithFile(
        file.absolute.path,
        quality: 65,
        minWidth: 512,
        minHeight: 512,
      );
      final bytes = compressedBytes ?? await file.readAsBytes();
      final dataUri = 'data:image/jpeg;base64,${base64Encode(bytes)}';

      await ExampleConnector.instance
          .updateUserAvatar(id: _userId!, avatarUrl: dataUri)
          .execute();

      if (mounted) {
        setState(() => _avatarUrl = dataUri);
        showNotice(context, 'Profile picture updated.');
      }
      await widget.market.load();
    } catch (_) {
      if (mounted) {
        showNotice(context, 'Could not update profile picture. Try again.');
      }
    } finally {
      if (mounted) setState(() => _uploadingAvatar = false);
    }
  }

  Widget _buildAvatar(String displayName) {
    final initial = displayName.trim().isNotEmpty
        ? displayName.trim()[0].toUpperCase()
        : 'T';
    final hasPhoto = _avatarUrl != null && _avatarUrl!.trim().isNotEmpty;

    return GestureDetector(
      onTap: _userId == null ? null : _pickAndSaveAvatar,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (hasPhoto)
            Photo(_avatarUrl!, width: 64, height: 64, radius: 22)
          else
            Container(
              width: 64,
              height: 64,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: cream,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Text(
                initial,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: ink,
                ),
              ),
            ),
          if (_userId != null)
            Positioned(
              right: -4,
              bottom: -4,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: _uploadingAvatar ? surface : yellow,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: _uploadingAvatar
                    ? const Padding(
                        padding: EdgeInsets.all(4),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(
                        Icons.camera_alt_outlined,
                        size: 13,
                        color: ink,
                      ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVerificationBadge() {
    final isVerified = _verificationStatus == 'VERIFIED';
    final isRejected = _verificationStatus == 'REJECTED';
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isVerified ? cream : surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isVerified
                ? Icons.verified_outlined
                : isRejected
                    ? Icons.cancel_outlined
                    : Icons.hourglass_top_rounded,
            size: 14,
            color: isRejected ? Colors.red : ink,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              isVerified
                  ? 'Verified Thomasian'
                  : isRejected
                      ? 'Verification Rejected'
                      : 'Verification Pending — UST ID under review',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isRejected ? Colors.red : ink,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final all = widget.market.all.where((l) => l.owned).toList();
    final listings = all.where((l) => l.sold == _sold).toList();

    final currentUser = FirebaseAuth.instance.currentUser;
    final email = currentUser?.email?.trim().toLowerCase() ?? '';
    final isAdmin =
        currentUser != null &&
        (_role == 'ADMIN' || kAdminEmails.contains(email));

    final displayName =
        (_fullName != null && _fullName!.trim().isNotEmpty)
        ? _fullName!
        : (currentUser?.displayName != null &&
              currentUser!.displayName!.trim().isNotEmpty)
        ? currentUser.displayName!
        : (currentUser?.email?.split('@').first ?? 'Thomasian Member');
    final subtitleText = currentUser?.email ?? 'UST Marketplace';
    final collegeText = (_collegeOrFaculty ?? '').trim();

    return PageBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'My profile',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
              if (_userId != null)
                TextButton.icon(
                  onPressed: () => _editProfileDetails(displayName),
                  icon: const Icon(Icons.edit_outlined, size: 16),
                  label: const Text('Edit profile'),
                ),
            ],
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              _buildAvatar(displayName),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitleText,
                      style: const TextStyle(fontSize: 11, color: muted),
                    ),
                    if (collegeText.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        collegeText,
                        style: const TextStyle(fontSize: 11, color: ink),
                      ),
                    ],
                    if (currentUser != null) _buildVerificationBadge(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            currentUser != null
                ? 'Tap your photo to update it anytime (optional).'
                : 'Sample profile · You are exploring the marketplace.',
            style: const TextStyle(fontSize: 11, color: muted),
          ),
          if (isAdmin) ...[
            const SizedBox(height: 18),
            InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => const AdminVerificationScreen(),
                  ),
                );
                await _loadProfile();
                await widget.market.load();
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: cream,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: yellow),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.admin_panel_settings_outlined, color: ink),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Admin · Review Pending Verifications',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Inspect uploaded UST IDs & approve student accounts',
                            style: TextStyle(fontSize: 11, color: muted),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: ink),
                  ],
                ),
              ),
            ),
          ],
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
                        Stack(
                          children: [
                            Photo(l.images.first, width: 88, height: 88),
                            if (!l.sold)
                              Positioned(
                                top: 4,
                                right: 4,
                                child: Material(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  shape: const CircleBorder(),
                                  child: InkWell(
                                    customBorder: const CircleBorder(),
                                    onTap: widget.market.loading
                                        ? null
                                        : () => _confirmDelete(l.id),
                                    child: const Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Icon(
                                        Icons.delete_outline,
                                        size: 16,
                                        color: ink,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
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
                            loading: widget.market.loading,
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
            onPressed: () async {
              if (currentUser != null) {
                await FirebaseAuth.instance.signOut();
              }
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute<void>(
                    builder: (_) =>
                        AuthScreen(authService: FirebaseAuthService()),
                  ),
                  (route) => false,
                );
              }
            },
            child: Text(
              currentUser != null ? 'Log out' : 'Back to sign up / log in',
            ),
          ),
        ],
      ),
    );
  }
}