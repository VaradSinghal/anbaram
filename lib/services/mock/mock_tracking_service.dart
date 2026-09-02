import 'package:anbaram_admin/models/tracked_item.dart';

class MockTrackingService {
  Future<List<TrackedItem>> getTrackedItems() async {
    await Future.delayed(const Duration(milliseconds: 600));

    final now = DateTime.now();

    return [
      TrackedItem(
        id: 'SHP-4109',
        itemName: 'Bottled Water',
        quantity: 1200,
        originCentreName: 'Chennai Central Hub',
        destinationArea: 'Velachery Relief Camp',
        history: [
          TrackingEvent(
            timestamp: now.subtract(const Duration(hours: 1)),
            status: TrackingStatus.inTransit,
            description: 'Dispatched via Truck TN-01-AB-1234. Driver: Murugan.',
            location: 'Chennai Central Hub',
          ),
          TrackingEvent(
            timestamp: now.subtract(const Duration(hours: 4)),
            status: TrackingStatus.sorting,
            description: 'Pallets assembled and loaded into transport.',
            location: 'Chennai Central Hub',
          ),
          TrackingEvent(
            timestamp: now.subtract(const Duration(days: 1)),
            status: TrackingStatus.received,
            description: 'Bulk donation received from corporate sponsor.',
            location: 'Chennai Central Hub',
          ),
        ],
      ),
      TrackedItem(
        id: 'SHP-4112',
        itemName: 'Medical Kits & First Aid',
        quantity: 250,
        originCentreName: 'Adyar Medical Reserve',
        destinationArea: 'Tambaram East',
        history: [
          TrackingEvent(
            timestamp: now.subtract(const Duration(minutes: 30)),
            status: TrackingStatus.sorting,
            description: 'Kits are being verified for expiration dates and repacked.',
            location: 'Adyar Medical Reserve',
          ),
          TrackingEvent(
            timestamp: now.subtract(const Duration(hours: 6)),
            status: TrackingStatus.received,
            description: 'Consignment received from NGO Partners.',
            location: 'Adyar Medical Reserve',
          ),
        ],
      ),
      TrackedItem(
        id: 'SHP-3990',
        itemName: 'Woolen Blankets',
        quantity: 500,
        originCentreName: 'Coimbatore Hub',
        destinationArea: 'Ooty Relief Shelters',
        history: [
          TrackingEvent(
            timestamp: now.subtract(const Duration(days: 2)),
            status: TrackingStatus.distributed,
            description: 'Successfully handed over to Shelter Coordinator.',
            location: 'Ooty Relief Shelters',
          ),
          TrackingEvent(
            timestamp: now.subtract(const Duration(days: 2, hours: 4)),
            status: TrackingStatus.inTransit,
            description: 'Arrived at destination check-post.',
            location: 'Ooty Checkpost',
          ),
          TrackingEvent(
            timestamp: now.subtract(const Duration(days: 3)),
            status: TrackingStatus.inTransit,
            description: 'Departed origin hub.',
            location: 'Coimbatore Hub',
          ),
          TrackingEvent(
            timestamp: now.subtract(const Duration(days: 4)),
            status: TrackingStatus.received,
            description: 'Donations collected from local drives.',
            location: 'Coimbatore Hub',
          ),
        ],
      ),
    ];
  }
}
