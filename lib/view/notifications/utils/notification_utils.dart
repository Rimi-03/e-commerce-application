import 'package:ecommerce_app/view/notifications/models/notification_type.dart';
import 'package:flutter/material.dart';

class NotificationUtils {
  static IconData getNotifications(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return Icons.shopping_bag_outlined;
      case NotificationType.delivery:
        return Icons.local_shipping_outlined;
      case NotificationType.promo:
        return Icons.local_offer_outlined;
      case NotificationType.payment:
        return Icons.payment_outlined;
    }
  }

  static Color getIconBackground(BuildContext context, NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return Theme.of(context).colorScheme.primary.withAlpha(26);
      case NotificationType.delivery:
        return Colors.green[100]!;
      case NotificationType.promo:
        return Colors.orange[100]!;
      case NotificationType.payment:
        return Colors.red[100]!;
    }
  }

  static Color getIconColor(BuildContext context, NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return Theme.of(context).colorScheme.primary;
      case NotificationType.delivery:
        return Colors.green;
      case NotificationType.promo:
        return Colors.orange;
      case NotificationType.payment:
        return Colors.red;
    }
  }
}