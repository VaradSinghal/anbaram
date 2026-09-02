import 'package:flutter/material.dart';
import 'package:anbaram_admin/theme/app_colors.dart';

enum TrackingStatus {
  received,
  sorting,
  inTransit,
  distributed
}

extension TrackingStatusExtension on TrackingStatus {
  String get label {
    switch (this) {
      case TrackingStatus.received:
        return 'Received';
      case TrackingStatus.sorting:
        return 'Sorting & Packing';
      case TrackingStatus.inTransit:
        return 'In Transit';
      case TrackingStatus.distributed:
        return 'Distributed';
    }
  }

  Color get color {
    switch (this) {
      case TrackingStatus.received:
        return AppColors.secondary;
      case TrackingStatus.sorting:
        return AppColors.accent;
      case TrackingStatus.inTransit:
        return AppColors.warning;
      case TrackingStatus.distributed:
        return AppColors.success;
    }
  }

  IconData get icon {
    switch (this) {
      case TrackingStatus.received:
        return Icons.inventory_2_outlined;
      case TrackingStatus.sorting:
        return Icons.category_outlined;
      case TrackingStatus.inTransit:
        return Icons.local_shipping_outlined;
      case TrackingStatus.distributed:
        return Icons.check_circle_outline;
    }
  }
}

class TrackingEvent {
  final DateTime timestamp;
  final TrackingStatus status;
  final String description;
  final String location;

  const TrackingEvent({
    required this.timestamp,
    required this.status,
    required this.description,
    required this.location,
  });
}

class TrackedItem {
  final String id;
  final String itemName;
  final int quantity;
  final String originCentreName;
  final String destinationArea;
  final List<TrackingEvent> history;

  const TrackedItem({
    required this.id,
    required this.itemName,
    required this.quantity,
    required this.originCentreName,
    required this.destinationArea,
    required this.history,
  });

  TrackingStatus get currentStatus => history.isNotEmpty ? history.first.status : TrackingStatus.received;
  
  TrackingEvent? get lastEvent => history.isNotEmpty ? history.first : null;
}
