import 'package:flutter/material.dart';
import '../models/notification_item.dart';
import '../theme/app_theme.dart';

class NotificationsScreen extends StatelessWidget {
  final List<NotificationItem> notifications;
  final Function(NotificationItem) onNotificationTap;
  final VoidCallback onMarkAllRead;
  final VoidCallback onBack;

  const NotificationsScreen({
    super.key,
    required this.notifications,
    required this.onNotificationTap,
    required this.onMarkAllRead,
    required this.onBack,
  });

  IconData _getIcon(NotificationType type) {
    switch (type) {
      case NotificationType.views:
        return Icons.visibility_outlined;
      case NotificationType.message:
        return Icons.chat_bubble_outline;
      case NotificationType.published:
        return Icons.check_circle_outline;
      case NotificationType.priceDrop:
        return Icons.trending_down;
      case NotificationType.offer:
        return Icons.local_offer_outlined;
    }
  }

  Color _getIconColor(NotificationType type) {
    switch (type) {
      case NotificationType.views:
        return AppTheme.primaryBlue;
      case NotificationType.message:
        return AppTheme.accentBlue;
      case NotificationType.published:
        return AppTheme.successGreen;
      case NotificationType.priceDrop:
        return AppTheme.dangerRed;
      case NotificationType.offer:
        return AppTheme.warningOrange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: onMarkAllRead,
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.notifications_off_outlined, size: 64, color: AppTheme.textMuted),
                  SizedBox(height: 16),
                  Text(
                    'No notifications',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return InkWell(
                  onTap: () => onNotificationTap(notif),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: notif.isRead ? Colors.white : const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: notif.isRead ? const Color(0xFFF1F5F9) : const Color(0xFFBFDBFE),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _getIconColor(notif.type).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getIcon(notif.type),
                            color: _getIconColor(notif.type),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notif.title,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: notif.isRead ? FontWeight.w600 : FontWeight.bold,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notif.message,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                notif.time,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppTheme.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!notif.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppTheme.primaryBlue,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
