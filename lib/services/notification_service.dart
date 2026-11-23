import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../dataconnect_generated/generated.dart';
import '../models/app_notification.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handled natively by the OS notification tray while the app is backgrounded.
}

class NotificationService {
  NotificationService({
    ExampleConnector? connector,
    fb_auth.FirebaseAuth? auth,
    FirebaseMessaging? messaging,
  })  : _connector = connector ?? ExampleConnector.instance,
        _auth = auth ?? fb_auth.FirebaseAuth.instance,
        _messaging = messaging ?? FirebaseMessaging.instance;

  final ExampleConnector _connector;
  final fb_auth.FirebaseAuth _auth;
  final FirebaseMessaging _messaging;

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

  /// Requests FCM push permissions and registers foreground listeners.
  Future<void> initializePushNotifications({
    void Function(RemoteMessage message)? onForegroundMessage,
  }) async {
    try {
      await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      final token = await _messaging.getToken();
      if (kDebugMode && token != null) {
        debugPrint('FCM Device Token: $token');
      }
      FirebaseMessaging.onMessage.listen((message) {
        onForegroundMessage?.call(message);
      });
    } catch (e) {
      if (kDebugMode) {
        debugPrint('FCM initialization skipped: $e');
      }
    }
  }

  Future<List<AppNotification>> fetchNotifications() async {
    final userId = await _getCurrentUserId();
    if (userId == null) return const [];

    final res = await _connector
        .getUserNotifications(userId: userId)
        .execute();

    return res.data.notifications
        .map(
          (n) => AppNotification(
            id: n.id,
            type: n.type.stringValue,
            title: n.title,
            body: n.body,
            referenceId: n.referenceId,
            isRead: n.isRead,
            createdAt: n.createdAt.toDateTime(),
          ),
        )
        .toList();
  }

  Future<void> createNotification({
    required String recipientUserId,
    required NotificationType type,
    required String title,
    String? body,
    String? referenceId,
  }) async {
    var mutation = _connector.createNotification(
      userId: recipientUserId,
      type: type,
      title: title,
    );
    if (body != null && body.isNotEmpty) {
      mutation = mutation.body(body);
    }
    if (referenceId != null && referenceId.isNotEmpty) {
      mutation = mutation.referenceId(referenceId);
    }
    await mutation.execute();
  }

  Future<void> markAsRead(String notificationId) async {
    await _connector.markNotificationRead(id: notificationId).execute();
  }
}