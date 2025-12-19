import 'package:ecommerce_app/view/notifications/models/notification_type.dart';

class NotificationRepository {
  List<NotificationItem> getNotifications() {
    // This is a placeholder implementation.
    return [
      NotificationItem(
        title: 'Order Confirmed',
        message:
            'Your order #12345 has been confirmed and is now being processed.',
        time: '2 hours ago',
        type: NotificationType.order,
        isRead: true,
      ),
      NotificationItem(
        title: 'Special Offer',
        message:
            'Get 20% off on all shoes this weekend.',
        time: '1 hours ago',
        type: NotificationType.promo,
        isRead: true,
      ),
      NotificationItem(
        title: 'Out for Delivery',
        message:
            'Your order #12345 is out for delivery.',
        time: '3 hours ago',
        type: NotificationType.delivery,
        isRead: true,
      ),
      NotificationItem(
        title: 'payment Successful',
        message:
            'Payment for order #12345 has been successfully processed.',
        time: '2 minutes ago',
        type: NotificationType.payment,
        isRead: true,
      ),
    ];
  }
}
