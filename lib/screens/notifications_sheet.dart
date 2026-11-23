import 'package:flutter/material.dart';

import '../controllers/notification_controller.dart';
import '../models/app_notification.dart';
import '../theme.dart';

class NotificationsSheet extends StatelessWidget {
  const NotificationsSheet({
    super.key,
    required this.controller,
    this.onTapNotification,
  });

  final NotificationController controller;
  final ValueChanged<AppNotification>? onTapNotification;

  IconData _iconFor(String type) => switch (type) {
    'NEW_MESSAGE' => Icons.chat_bubble_outline,
    'VERIFICATION_UPDATE' => Icons.verified_outlined,
    'PRICE_DROP' => Icons.local_offer_outlined,
    'LISTING_SOLD' => Icons.sell_outlined,
    _ => Icons.notifications_none,
  };

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: controller,
    builder: (context, _) {
      final items = controller.items;
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                color: line,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 16, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (controller.unreadCount > 0)
                    TextButton(
                      onPressed: controller.markAllRead,
                      child: const Text(
                        'Mark all read',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
            const Divider(height: 1),
            if (items.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 56, horizontal: 24),
                child: Center(
                  child: Text(
                    'No notifications yet. Updates on messages, listings, and verification appear here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: muted, fontSize: 13),
                  ),
                ),
              )
            else
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final item = items[i];
                    return ListTile(
                      tileColor: item.isRead ? Colors.white : cream,
                      leading: CircleAvatar(
                        backgroundColor: item.isRead ? surface : yellow,
                        foregroundColor: ink,
                        child: Icon(_iconFor(item.type), size: 20),
                      ),
                      title: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: item.isRead
                              ? FontWeight.w500
                              : FontWeight.w700,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item.body != null && item.body!.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              item.body!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12, color: muted),
                            ),
                          ],
                          const SizedBox(height: 4),
                          Text(
                            _timeAgo(item.createdAt),
                            style: const TextStyle(fontSize: 10, color: muted),
                          ),
                        ],
                      ),
                      onTap: () async {
                        await controller.markRead(item.id);
                        if (context.mounted) {
                          Navigator.pop(context);
                          onTapNotification?.call(item);
                        }
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      );
    },
  );
}