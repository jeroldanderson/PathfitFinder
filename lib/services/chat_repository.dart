import '../models/chat_message.dart';

/// In-memory preview conversations. Replace with a backend repository later.
class ChatRepository {
  final Map<String, List<ChatMessage>> _conversations = {
    'basketball': [
      const ChatMessage('Hi! Yes, the basketball set is still available 😊'),
      const ChatMessage(
        'Hi, ate! Would ₱320 work? I can meet at the España gate after my 2 PM class.',
        mine: true,
      ),
      const ChatMessage(
        'Deal! ₱320 it is. See you by the España gate at 2:15? I’ll bring the complete set.',
      ),
      const ChatMessage('Perfect. Thank you! See you 🐯', mine: true),
    ],
  };
  List<ChatMessage> messages(String listingId) =>
      List.unmodifiable(_conversations[listingId] ?? []);
  void add(String listingId, ChatMessage message) =>
      _conversations.putIfAbsent(listingId, () => []).add(message);
}
