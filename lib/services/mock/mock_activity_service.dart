import 'package:anbaram_admin/models/activity_log_entry.dart';

/// Seeded recent activity log entries.
class MockActivityService {
  Future<List<ActivityLogEntry>> getRecentActivity({int limit = 10}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _entries.take(limit).toList();
  }

  static final List<ActivityLogEntry> _entries = [
    ActivityLogEntry(
      id: 'act-001', centreId: 'ctr-001',
      centreName: 'T. Nagar Community Centre',
      officialName: 'Rajesh Kumar', actionType: 'stock_update',
      description: 'Updated Rice: 50 → 45 kg',
      timestamp: DateTime.now().subtract(const Duration(minutes: 12)),
    ),
    ActivityLogEntry(
      id: 'act-002', centreId: 'ctr-002',
      centreName: 'Adyar Relief Hub',
      officialName: 'Meena Ravi', actionType: 'stock_alert',
      description: 'Water bottles below threshold (8 remaining)',
      timestamp: DateTime.now().subtract(const Duration(minutes: 35)),
    ),
    ActivityLogEntry(
      id: 'act-003', centreId: 'ctr-006',
      centreName: 'Anna Nagar Warehouse',
      officialName: 'Lakshmi Devi', actionType: 'donation_confirmed',
      description: 'Confirmed donation from Venkat R. — 20 blankets',
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 10)),
    ),
    ActivityLogEntry(
      id: 'act-004', centreId: 'ctr-008',
      centreName: 'Trichy Junction Centre',
      officialName: 'Ramesh Iyer', actionType: 'item_added',
      description: 'Added new item: Cooking Oil (25 litres)',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    ActivityLogEntry(
      id: 'act-005', centreId: 'ctr-005',
      centreName: 'Meenakshi Nagar Centre',
      officialName: 'Vel Murugan', actionType: 'stock_alert',
      description: 'Rice critically low (3 kg remaining)',
      timestamp: DateTime.now().subtract(const Duration(hours: 3, minutes: 20)),
    ),
    ActivityLogEntry(
      id: 'act-006', centreId: 'ctr-014',
      centreName: 'Thanjavur Palace Ground',
      officialName: 'Saravanan K', actionType: 'donation_confirmed',
      description: 'Confirmed donation from Priya S. — 15 notebooks',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
    ),
    ActivityLogEntry(
      id: 'act-007', centreId: 'ctr-003',
      centreName: 'Gandhipuram Collection Point',
      officialName: 'Suresh Babu', actionType: 'stock_update',
      description: 'Updated Blankets: 120 → 135',
      timestamp: DateTime.now().subtract(const Duration(hours: 5, minutes: 45)),
    ),
    ActivityLogEntry(
      id: 'act-008', centreId: 'ctr-011',
      centreName: 'Erode Textile Hub',
      officialName: 'Senthil Nathan', actionType: 'stock_alert',
      description: 'Clothing stock critically low (5 items)',
      timestamp: DateTime.now().subtract(const Duration(hours: 7)),
    ),
    ActivityLogEntry(
      id: 'act-009', centreId: 'ctr-010',
      centreName: 'Vellore Fort Centre',
      officialName: 'Pradeep Raj', actionType: 'item_added',
      description: 'Added new item: First Aid Kits (30 units)',
      timestamp: DateTime.now().subtract(const Duration(hours: 9)),
    ),
    ActivityLogEntry(
      id: 'act-010', centreId: 'ctr-018',
      centreName: 'Tirupur Knit City Store',
      officialName: 'Vanitha Devi', actionType: 'donation_confirmed',
      description: 'Confirmed donation from Kumar T. — 50 T-shirts',
      timestamp: DateTime.now().subtract(const Duration(hours: 12)),
    ),
  ];
}
