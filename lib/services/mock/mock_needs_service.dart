import 'package:anbaram_admin/models/need_request.dart';

/// Seeded need requests across different areas.
class MockNeedsService {
  Future<List<NeedRequest>> getPendingNeeds() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return List.unmodifiable(_needs);
  }

  static const List<NeedRequest> _needs = [
    NeedRequest(
      id: 'need-101',
      itemName: 'Blankets',
      quantity: 150,
      requestingArea: 'Adyar Flood Relief Camp',
      urgency: UrgencyLevel.high,
      closestCentreId: 'ctr-001',
      closestCentreName: 'T. Nagar Community Centre',
      distanceKm: 4.2,
    ),
    NeedRequest(
      id: 'need-102',
      itemName: 'Drinking Water (1L)',
      quantity: 500,
      requestingArea: 'Villapuram Temporary Shelter',
      urgency: UrgencyLevel.high,
      closestCentreId: 'ctr-006',
      closestCentreName: 'Anna Nagar Warehouse',
      distanceKm: 2.8,
    ),
    NeedRequest(
      id: 'need-103',
      itemName: 'First Aid Kits',
      quantity: 25,
      requestingArea: 'Erode GH Outskirts',
      urgency: UrgencyLevel.medium,
      closestCentreId: 'ctr-018',
      closestCentreName: 'Tirupur Knit City Store',
      distanceKm: 22.5,
    ),
    NeedRequest(
      id: 'need-104',
      itemName: 'Baby Formula',
      quantity: 40,
      requestingArea: 'Cuddalore Coastal Village',
      urgency: UrgencyLevel.high,
      closestCentreId: 'ctr-014',
      closestCentreName: 'Thanjavur Palace Ground',
      distanceKm: 65.0,
    ),
    NeedRequest(
      id: 'need-105',
      itemName: 'Rice (5kg Bags)',
      quantity: 100,
      requestingArea: 'Thoothukudi Harbour Slum',
      urgency: UrgencyLevel.medium,
      closestCentreId: 'ctr-012',
      closestCentreName: 'Nellai Service Point',
      distanceKm: 45.3,
    ),
    NeedRequest(
      id: 'need-106',
      itemName: 'Mosquito Nets',
      quantity: 200,
      requestingArea: 'Salem Town Hall Periphery',
      urgency: UrgencyLevel.low,
      closestCentreId: 'ctr-007',
      closestCentreName: 'Salem Town Hall Store',
      distanceKm: 1.2,
    ),
    NeedRequest(
      id: 'need-107',
      itemName: 'Torch Lights & Batteries',
      quantity: 50,
      requestingArea: 'Kanchipuram Silk City Outskirts',
      urgency: UrgencyLevel.low,
      closestCentreId: 'ctr-010',
      closestCentreName: 'Vellore Fort Centre',
      distanceKm: 55.0,
    ),
  ];
}
