import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/app_notification.dart';
import '../services/notification_service.dart';

class NotificationController extends ChangeNotifier {
  NotificationController({NotificationService? service})
    : _service = service ?? NotificationService();

  final NotificationService _service;
  final List<AppNotification> _items = [];
  Timer? _pollTimer;
  bool loading = false;
  bool _disposed = false;

  List<AppNotification> get items => List.unmodifiable(_items);
  int get unreadCount => _items.where((n) => !n.isRead).length;

  Future<void> start({VoidCallback? onPushReceived}) async {
    await _service.initializePushNotifications(
      onForegroundMessage: (_) {
        load();
        onPushReceived?.call();
      },
    );
    await load();

    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      if (!_disposed) load();
    });
  }

  Future<void> load() async {
    if (loading) return;
    loading = true;
    try {
      final fetched = await _service.fetchNotifications();
      if (!_disposed) {
        _items
          ..clear()
          ..addAll(fetched);
        notifyListeners();
      }
    } catch (_) {
      // Fail silently on background refresh
    } finally {
      loading = false;
    }
  }

  Future<void> markRead(String id) async {
    final idx = _items.indexWhere((n) => n.id == id);
    if (idx >= 0 && !_items[idx].isRead) {
      _items[idx] = _items[idx].copyWith(isRead: true);
      notifyListeners();
    }
    await _service.markAsRead(id);
  }

  Future<void> markAllRead() async {
    final unread = _items.where((n) => !n.isRead).toList();
    for (final item in unread) {
      await markRead(item.id);
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _pollTimer?.cancel();
    super.dispose();
  }
}