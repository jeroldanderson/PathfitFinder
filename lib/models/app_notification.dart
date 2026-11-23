class AppNotification {
  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    this.body,
    this.referenceId,
    required this.isRead,
    required this.createdAt,
  });

  final String id;
  final String type; // NEW_MESSAGE, VERIFICATION_UPDATE, PRICE_DROP, LISTING_SOLD
  final String title;
  final String? body;
  final String? referenceId;
  final bool isRead;
  final DateTime createdAt;

  AppNotification copyWith({bool? isRead}) => AppNotification(
    id: id,
    type: type,
    title: title,
    body: body,
    referenceId: referenceId,
    isRead: isRead ?? this.isRead,
    createdAt: createdAt,
  );
}