import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../dataconnect_generated/generated.dart';
import '../models/chat_message.dart';
import '../models/listing.dart';
import 'notification_service.dart';

class ChatRepository {
  ChatRepository({
    ExampleConnector? connector,
    fb_auth.FirebaseAuth? auth,
    NotificationService? notifications,
  })  : _connector = connector ?? ExampleConnector.instance,
        _auth = auth ?? fb_auth.FirebaseAuth.instance,
        _notifications = notifications ?? NotificationService();

  final ExampleConnector _connector;
  final fb_auth.FirebaseAuth _auth;
  final NotificationService _notifications;

  final Map<String, List<ChatMessage>> _messagesByListing = {};
  final Map<String, String> _conversationIdByListing = {};
  final Map<String, String> _otherPartyNameByListing = {};
  final Map<String, String> _otherPartyIdByListing = {};
  final Map<String, String> _listingTitleByListing = {};
  final List<ConversationSummary> conversations = [];

  String? _cachedUserId;
  String? _cachedEmail;

  Future<String?> _getCurrentUserId() async {
    final email = _auth.currentUser?.email?.trim().toLowerCase();
    if (email == null || email.isEmpty) return null;
    if (_cachedUserId != null && _cachedEmail == email) return _cachedUserId;
    final res = await _connector.getUserByEmail(email: email).execute();
    if (res.data.users.isEmpty) return null;
    _cachedEmail = email;
    _cachedUserId = res.data.users.first.id;
    return _cachedUserId;
  }

  List<ChatMessage> messages(String listingId) =>
      List.unmodifiable(_messagesByListing[listingId] ?? const []);

  String otherPartyName(String listingId) =>
      _otherPartyNameByListing[listingId] ?? 'Thomasian Seller';

  /// Loads all conversations for the signed-in user sorted by lastMessageAt.
  Future<List<ConversationSummary>> fetchConversations() async {
    final userId = await _getCurrentUserId();
    if (userId == null) return const [];

    final res = await _connector
        .getUserConversations(userId: userId)
        .execute();

    conversations.clear();
    for (final row in res.data.conversations) {
      final isBuyer = row.buyer.id == userId;
      final otherId = isBuyer ? row.seller.id : row.buyer.id;
      final otherName = isBuyer ? row.seller.fullName : row.buyer.fullName;
      final otherVerified = isBuyer
          ? row.seller.verificationStatus.stringValue == 'VERIFIED'
          : true;

      final coverUrl = row.listing.coverImages.isNotEmpty
          ? row.listing.coverImages.first.imageUrl
          : 'assets/figma/8b601.png';

      final listing = Listing(
        id: row.listing.id,
        title: row.listing.title,
        price: row.listing.price.round(),
        sport: 'PATHFIT',
        size: _formatSize(row.listing.size.stringValue),
        wornBy: 'Any',
        condition: _formatCondition(row.listing.condition.stringValue),
        images: [coverUrl],
        sellerName: row.seller.fullName,
        sellerVerified:
            row.seller.verificationStatus.stringValue == 'VERIFIED',
        owned: !isBuyer,
        sold: row.listing.status.stringValue == 'SOLD',
        deleted: row.listing.deletedAt != null,
      );

      final lastMsg = row.messages.isNotEmpty ? row.messages.first : null;
      final hasUnread = lastMsg != null &&
          !lastMsg.isRead &&
          lastMsg.sender.id != userId;

      _conversationIdByListing[listing.id] = row.id;
      _otherPartyIdByListing[listing.id] = otherId;
      _otherPartyNameByListing[listing.id] = otherName;
      _listingTitleByListing[listing.id] = listing.title;

      conversations.add(
        ConversationSummary(
          id: row.id,
          listing: listing,
          otherPartyName: otherName,
          otherPartyVerified: otherVerified,
          lastMessage: lastMsg?.content ?? 'No messages yet',
          lastMessageAt: row.lastMessageAt.toDateTime(),
          hasUnread: hasUnread,
        ),
      );
    }
    return List.unmodifiable(conversations);
  }

  /// Fetches messages for [listingId] and marks unread incoming messages as read.
  Future<void> loadThread(String listingId) async {
    final userId = await _getCurrentUserId();
    if (userId == null) return;

    var conversationId = _conversationIdByListing[listingId];
    if (conversationId == null) {
      await fetchConversations();
      conversationId = _conversationIdByListing[listingId];
    }
    if (conversationId == null) return;

    final res = await _connector
        .getConversationMessages(conversationId: conversationId)
        .execute();

    final loaded = <ChatMessage>[];
    for (final m in res.data.messages) {
      final isMine = m.sender.id == userId;
      final isImage = m.content.startsWith('[IMAGE]');
      loaded.add(
        ChatMessage(
          isImage ? '' : m.content,
          id: m.id,
          mine: isMine,
          imagePath: isImage ? m.content.substring(7) : null,
          sentAt: m.sentAt.toDateTime(),
          isRead: m.isRead,
        ),
      );

      if (!isMine && !m.isRead) {
        await _connector.markMessageRead(id: m.id).execute();
      }
    }
    _messagesByListing[listingId] = loaded;
  }

  /// Sends a text message (or uploaded image URL), creating the Conversation if needed.
  Future<void> sendMessage({
    required String listingId,
    required String content,
  }) async {
    final userId = await _getCurrentUserId();
    if (userId == null) {
      throw StateError('Sign in to send messages.');
    }

    var conversationId = _conversationIdByListing[listingId];
    if (conversationId == null) {
      await fetchConversations();
      conversationId = _conversationIdByListing[listingId];
    }

    if (conversationId == null) {
      final listingsRes = await _connector.getAllListings().execute();
      final match = listingsRes.data.listings.where((l) => l.id == listingId);
      if (match.isEmpty) {
        throw StateError('Listing not found.');
      }
      final sellerId = match.first.seller.id;
      if (userId == sellerId) {
        throw StateError('You cannot message yourself on your own listing.');
      }
      final created = await _connector
          .createConversation(
            listingId: listingId,
            buyerId: userId,
            sellerId: sellerId,
          )
          .execute();
      conversationId = created.data.conversation_insert.id;
      _conversationIdByListing[listingId] = conversationId;
      _otherPartyIdByListing[listingId] = sellerId;
      _otherPartyNameByListing[listingId] = match.first.seller.fullName;
      _listingTitleByListing[listingId] = match.first.title;
    }

    await _connector
        .sendMessage(
          conversationId: conversationId,
          senderId: userId,
          content: content,
        )
        .execute();

    await _connector
        .updateConversationTimestamp(id: conversationId)
        .execute();

    // Trigger in-app NEW_MESSAGE notification for the recipient
    final recipientId = _otherPartyIdByListing[listingId];
    if (recipientId != null && recipientId != userId) {
      final senderName = _auth.currentUser?.displayName?.trim().isNotEmpty == true
          ? _auth.currentUser!.displayName!.trim()
          : 'A fellow Thomasian';
      final titleText = _listingTitleByListing[listingId] ?? 'PATHFIT uniform';
      final preview = content.startsWith('[IMAGE]') ? 'Sent a photo' : content;
      try {
        await _notifications.createNotification(
          recipientUserId: recipientId,
          type: NotificationType.NEW_MESSAGE,
          title: 'New message from $senderName',
          body: '$titleText: $preview',
          referenceId: listingId,
        );
      } catch (_) {
        // Non-blocking notification failure
      }
    }

    await loadThread(listingId);
  }

  Future<String> uploadChatImage(String localPath) async {
    final file = File(localPath);
    final compressedBytes = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      quality: 65,
      minWidth: 720,
      minHeight: 720,
    );
    final bytes = compressedBytes ?? await file.readAsBytes();
    return 'data:image/jpeg;base64,${base64Encode(bytes)}';
  }
}

String _formatSize(String raw) => switch (raw) {
  'SIZE_2XL' => '2XL',
  'SIZE_3XL' => '3XL',
  _ => raw,
};

String _formatCondition(String raw) => switch (raw) {
  'BRAND_NEW' => 'Brand new',
  'LIKE_NEW' => 'Like new',
  'GENTLY_USED' => 'Good',
  'USED_WITH_FLAWS' => 'Well-used',
  _ => raw,
};