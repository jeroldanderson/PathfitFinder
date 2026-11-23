import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/chat_message.dart';
import '../services/chat_repository.dart';
import '../services/media_service.dart';

class ChatController extends ChangeNotifier {
  ChatController({ChatRepository? repository, MediaService? media})
    : _repository = repository ?? ChatRepository(),
      _media = media ?? MediaService();

  final ChatRepository _repository;
  final MediaService _media;
  Timer? _pollTimer;
  bool _disposed = false;
  bool picking = false;
  bool loading = false;

  List<ConversationSummary> get conversations =>
      List.unmodifiable(_repository.conversations);

  List<ChatMessage> messages(String listingId) =>
      _repository.messages(listingId);

  String otherPartyName(String listingId) =>
      _repository.otherPartyName(listingId);

  Future<void> loadInbox() async {
    loading = true;
    notifyListeners();
    try {
      await _repository.fetchConversations();
    } finally {
      loading = false;
      if (!_disposed) notifyListeners();
    }
  }

  Future<void> openThread(String listingId) async {
    await _repository.loadThread(listingId);
    if (!_disposed) notifyListeners();

    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 4), (_) async {
      if (_disposed) return;
      try {
        await _repository.loadThread(listingId);
        if (!_disposed) notifyListeners();
      } catch (_) {}
    });
  }

  void closeThread() {
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  Future<void> send(String listingId, String text) async {
    if (text.trim().isEmpty) return;
    await _repository.sendMessage(
      listingId: listingId,
      content: text.trim(),
    );
    if (!_disposed) notifyListeners();
  }

  Future<String?> attach(String listingId) async {
    if (picking) return null;
    picking = true;
    notifyListeners();
    try {
      final image = await _media.pick();
      if (!_disposed && image != null) {
        final url = await _repository.uploadChatImage(image.path);
        await _repository.sendMessage(
          listingId: listingId,
          content: '[IMAGE]$url',
        );
      }
      return null;
    } catch (_) {
      return 'Unable to send photo. Check permissions and try again.';
    } finally {
      picking = false;
      if (!_disposed) notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _pollTimer?.cancel();
    super.dispose();
  }
}