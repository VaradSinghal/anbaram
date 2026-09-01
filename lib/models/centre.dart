import 'package:anbaram_admin/config/app_constants.dart';

/// A collection centre managed by officials.
class Centre {
  final String id;
  final String name;
  final String address;
  final String district;
  final double latitude;
  final double longitude;
  final StockStatus stockStatus;
  final String contactName;
  final String contactPhone;
  final int totalItems;
  final int donationsThisMonth;
  final int needsFulfilled;
  final int pendingNeeds;

  const Centre({
    required this.id,
    required this.name,
    required this.address,
    required this.district,
    required this.latitude,
    required this.longitude,
    required this.stockStatus,
    required this.contactName,
    required this.contactPhone,
    required this.totalItems,
    this.donationsThisMonth = 0,
    this.needsFulfilled = 0,
    this.pendingNeeds = 0,
  });
}
