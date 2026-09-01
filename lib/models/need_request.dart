import 'package:flutter/material.dart';
import 'package:anbaram_admin/theme/app_colors.dart';

enum UrgencyLevel { high, medium, low }

/// A request for specific items by an area or centre.
class NeedRequest {
  final String id;
  final String itemName;
  final int quantity;
  final String requestingArea;
  final UrgencyLevel urgency;
  
  // The closest centre that has this item available
  final String closestCentreId;
  final String closestCentreName;
  final double distanceKm;

  const NeedRequest({
    required this.id,
    required this.itemName,
    required this.quantity,
    required this.requestingArea,
    required this.urgency,
    required this.closestCentreId,
    required this.closestCentreName,
    required this.distanceKm,
  });

  Color get urgencyColor {
    switch (urgency) {
      case UrgencyLevel.high:
        return AppColors.critical;
      case UrgencyLevel.medium:
        return AppColors.warning;
      case UrgencyLevel.low:
        return AppColors.success;
    }
  }

  String get urgencyLabel {
    switch (urgency) {
      case UrgencyLevel.high:
        return 'High Urgency';
      case UrgencyLevel.medium:
        return 'Medium Urgency';
      case UrgencyLevel.low:
        return 'Low Urgency';
    }
  }
}
