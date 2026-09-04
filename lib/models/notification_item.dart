enum NotificationType {
  views,
  message,
  published,
  priceDrop,
  offer,
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String time;
  final NotificationType type;
  bool isRead;
  final String? targetCarId;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isRead = false,
    this.targetCarId,
  });
}
