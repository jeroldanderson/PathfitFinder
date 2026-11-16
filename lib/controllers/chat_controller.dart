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
  bool _disposed = false;
  bool picking = false;
  List<ChatMessage> messages(String listingId) =>
      _repository.messages(listingId);
  void send(String listingId, String text) {
    if (text.trim().isEmpty) return;
    _repository.add(listingId, ChatMessage(text.trim(), mine: true));
    notifyListeners();
  }

  Future<String?> attach(String listingId) async {
    if (picking) return null;
    picking = true;
    notifyListeners();
    try {
      final image = await _media.pick();
      if (!_disposed && image != null) {
        _repository.add(
          listingId,
          ChatMessage('', mine: true, imagePath: image.path),
        );
      }
      return null;
    } catch (_) {
      return 'Unable to select a photo. Check photo permissions and try again.';
    } finally {
      picking = false;
      if (!_disposed) notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
