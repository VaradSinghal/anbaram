import 'package:flutter/material.dart';
import 'package:anbaram_admin/theme/app_colors.dart';

/// A single entry in a centre's activity log.
class ActivityLogEntry {
  final String id;
  final String centreId;
  final String centreName;
  final String officialName;
  final String actionType;
  final String description;
  final DateTime timestamp;

  const ActivityLogEntry({
    required this.id,
    required this.centreId,
    required this.centreName,
    required this.officialName,
    required this.actionType,
    required this.description,
    required this.timestamp,
  });

  IconData get icon {
    switch (actionType) {
      case 'stock_update':
        return Icons.edit_outlined;
      case 'donation_confirmed':
        return Icons.check_circle_outline;
      case 'item_added':
        return Icons.add_circle_outline;
      case 'stock_alert':
        return Icons.warning_amber_rounded;
      default:
        return Icons.info_outline;
    }
  }

  Color get iconColor {
    switch (actionType) {
      case 'stock_update':
        return AppColors.secondary;
      case 'donation_confirmed':
        return AppColors.success;
      case 'item_added':
        return AppColors.accent;
      case 'stock_alert':
        return AppColors.critical;
      default:
        return AppColors.textSecondary;
    }
  }

  /// Human-readable relative time ("5m ago", "2h ago", etc.).
  String get timeAgo {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }
}
