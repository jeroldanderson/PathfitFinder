import 'listing.dart';

class ChatMessage {
  const ChatMessage(
    this.text, {
    this.id = '',
    this.mine = false,
    this.imagePath,
    this.sentAt,
    this.isRead = false,
  });

  final String id;
  final String text;
  final bool mine;
  final String? imagePath;
  final DateTime? sentAt;
  final bool isRead;
}

class ConversationSummary {
  const ConversationSummary({
    required this.id,
    required this.listing,
    required this.otherPartyName,
    required this.otherPartyVerified,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.hasUnread,
  });

  final String id;
  final Listing listing;
  final String otherPartyName;
  final bool otherPartyVerified;
  final String lastMessage;
  final DateTime lastMessageAt;
  final bool hasUnread;
}