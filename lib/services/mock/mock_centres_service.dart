import 'package:anbaram_admin/config/app_constants.dart';
import 'package:anbaram_admin/models/centre.dart';

/// 18 seeded centres across Tamil Nadu districts.
class MockCentresService {
  Future<List<Centre>> getCentres() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.unmodifiable(_centres);
  }

  static final List<Centre> _centres = [
    const Centre(
      id: 'ctr-001', name: 'T. Nagar Community Centre',
      address: '23, Pondy Bazaar, T. Nagar', district: 'Chennai',
      latitude: 13.0418, longitude: 80.2341,
      stockStatus: StockStatus.healthy, contactName: 'Anand Kumar',
      contactPhone: '+91 98765 43210', totalItems: 245,
      donationsThisMonth: 32, needsFulfilled: 18, pendingNeeds: 5,
    ),
    const Centre(
      id: 'ctr-002', name: 'Adyar Relief Hub',
      address: '8, Gandhi Nagar, Adyar', district: 'Chennai',
      latitude: 13.0067, longitude: 80.2572,
      stockStatus: StockStatus.critical, contactName: 'Meena Ravi',
      contactPhone: '+91 98765 43211', totalItems: 42,
      donationsThisMonth: 8, needsFulfilled: 3, pendingNeeds: 12,
    ),
    const Centre(
      id: 'ctr-003', name: 'Gandhipuram Collection Point',
      address: '112, DB Road, RS Puram', district: 'Coimbatore',
      latitude: 11.0168, longitude: 76.9558,
      stockStatus: StockStatus.healthy, contactName: 'Suresh Babu',
      contactPhone: '+91 98765 43212', totalItems: 189,
      donationsThisMonth: 22, needsFulfilled: 15, pendingNeeds: 3,
    ),
    const Centre(
      id: 'ctr-004', name: 'Peelamedu Service Centre',
      address: '45, Avinashi Road', district: 'Coimbatore',
      latitude: 11.0254, longitude: 77.0209,
      stockStatus: StockStatus.low, contactName: 'Kavitha Sundaram',
      contactPhone: '+91 98765 43213', totalItems: 98,
      donationsThisMonth: 11, needsFulfilled: 7, pendingNeeds: 8,
    ),
    const Centre(
      id: 'ctr-005', name: 'Meenakshi Nagar Centre',
      address: '67, Bypass Road, Villapuram', district: 'Madurai',
      latitude: 9.9252, longitude: 78.1198,
      stockStatus: StockStatus.critical, contactName: 'Vel Murugan',
      contactPhone: '+91 98765 43214', totalItems: 31,
      donationsThisMonth: 5, needsFulfilled: 2, pendingNeeds: 15,
    ),
    const Centre(
      id: 'ctr-006', name: 'Anna Nagar Warehouse',
      address: '15, Main Road, Anna Nagar', district: 'Madurai',
      latitude: 9.9400, longitude: 78.1150,
      stockStatus: StockStatus.healthy, contactName: 'Lakshmi Devi',
      contactPhone: '+91 98765 43215', totalItems: 312,
      donationsThisMonth: 45, needsFulfilled: 28, pendingNeeds: 4,
    ),
    const Centre(
      id: 'ctr-007', name: 'Salem Town Hall Store',
      address: 'Cherry Road, Town Hall Area', district: 'Salem',
      latitude: 11.6643, longitude: 78.1460,
      stockStatus: StockStatus.low, contactName: 'Gopi Krishnan',
      contactPhone: '+91 98765 43216', totalItems: 87,
      donationsThisMonth: 9, needsFulfilled: 6, pendingNeeds: 7,
    ),
    const Centre(
      id: 'ctr-008', name: 'Trichy Junction Centre',
      address: '3, Royal Road, Cantonment', district: 'Tiruchirappalli',
      latitude: 10.7905, longitude: 78.7047,
      stockStatus: StockStatus.healthy, contactName: 'Ramesh Iyer',
      contactPhone: '+91 98765 43217', totalItems: 201,
      donationsThisMonth: 27, needsFulfilled: 20, pendingNeeds: 2,
    ),
    const Centre(
      id: 'ctr-009', name: 'Srirangam Distribution Hub',
      address: 'Temple Street, Srirangam', district: 'Tiruchirappalli',
      latitude: 10.8627, longitude: 78.6920,
      stockStatus: StockStatus.low, contactName: 'Bhavani Shankar',
      contactPhone: '+91 98765 43218', totalItems: 76,
      donationsThisMonth: 14, needsFulfilled: 9, pendingNeeds: 6,
    ),
    const Centre(
      id: 'ctr-010', name: 'Vellore Fort Centre',
      address: '22, Fort Road, Vellore Fort', district: 'Vellore',
      latitude: 12.9165, longitude: 79.1325,
      stockStatus: StockStatus.healthy, contactName: 'Pradeep Raj',
      contactPhone: '+91 98765 43219', totalItems: 156,
      donationsThisMonth: 19, needsFulfilled: 12, pendingNeeds: 4,
    ),
    const Centre(
      id: 'ctr-011', name: 'Erode Textile Hub',
      address: 'Brough Road, Erode', district: 'Erode',
      latitude: 11.3410, longitude: 77.7172,
      stockStatus: StockStatus.critical, contactName: 'Senthil Nathan',
      contactPhone: '+91 98765 43220', totalItems: 28,
      donationsThisMonth: 3, needsFulfilled: 1, pendingNeeds: 11,
    ),
    const Centre(
      id: 'ctr-012', name: 'Nellai Service Point',
      address: '9, High Ground Road', district: 'Tirunelveli',
      latitude: 8.7139, longitude: 77.7567,
      stockStatus: StockStatus.healthy, contactName: 'Mary Stella',
      contactPhone: '+91 98765 43221', totalItems: 178,
      donationsThisMonth: 24, needsFulfilled: 16, pendingNeeds: 3,
    ),
    const Centre(
      id: 'ctr-013', name: 'Thoothukudi Harbour Centre',
      address: '56, Beach Road', district: 'Thoothukudi',
      latitude: 8.7642, longitude: 78.1348,
      stockStatus: StockStatus.low, contactName: 'Abdul Rahman',
      contactPhone: '+91 98765 43222', totalItems: 92,
      donationsThisMonth: 13, needsFulfilled: 8, pendingNeeds: 9,
    ),
    const Centre(
      id: 'ctr-014', name: 'Thanjavur Palace Ground',
      address: 'Palace Road, Thanjavur', district: 'Thanjavur',
      latitude: 10.7870, longitude: 79.1378,
      stockStatus: StockStatus.healthy, contactName: 'Saravanan K',
      contactPhone: '+91 98765 43223', totalItems: 210,
      donationsThisMonth: 30, needsFulfilled: 22, pendingNeeds: 2,
    ),
    const Centre(
      id: 'ctr-015', name: 'Dindigul Market Centre',
      address: 'Palani Road, Dindigul', district: 'Dindigul',
      latitude: 10.3624, longitude: 77.9695,
      stockStatus: StockStatus.low, contactName: 'Karthik Velan',
      contactPhone: '+91 98765 43224', totalItems: 64,
      donationsThisMonth: 7, needsFulfilled: 4, pendingNeeds: 10,
    ),
    const Centre(
      id: 'ctr-016', name: 'Kanchipuram Silk City Hub',
      address: 'Gandhi Road, Kanchipuram', district: 'Kanchipuram',
      latitude: 12.8342, longitude: 79.7036,
      stockStatus: StockStatus.healthy, contactName: 'Deepa Mohan',
      contactPhone: '+91 98765 43225', totalItems: 143,
      donationsThisMonth: 17, needsFulfilled: 11, pendingNeeds: 5,
    ),
    const Centre(
      id: 'ctr-017', name: 'Cuddalore Coastal Centre',
      address: 'South Arcot Road', district: 'Cuddalore',
      latitude: 11.7480, longitude: 79.7714,
      stockStatus: StockStatus.critical, contactName: 'Rajan Pillai',
      contactPhone: '+91 98765 43226', totalItems: 35,
      donationsThisMonth: 4, needsFulfilled: 2, pendingNeeds: 14,
    ),
    const Centre(
      id: 'ctr-018', name: 'Tirupur Knit City Store',
      address: '78, Kumaran Road', district: 'Tirupur',
      latitude: 11.1085, longitude: 77.3411,
      stockStatus: StockStatus.healthy, contactName: 'Vanitha Devi',
      contactPhone: '+91 98765 43227', totalItems: 267,
      donationsThisMonth: 38, needsFulfilled: 25, pendingNeeds: 3,
    ),
  ];
}
