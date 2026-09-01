import 'package:anbaram_admin/config/app_constants.dart';
import 'package:anbaram_admin/models/official.dart';

/// Mock authentication that returns seeded officials.
///
/// Swap this with a real API service once the backend is live.
class MockAuthService {
  /// Simulated credentials → official mapping.
  static final Map<String, Official> _users = {
    'admin@anbaram.gov.in': const Official(
      id: 'off-001',
      name: 'Rajesh Kumar',
      email: 'admin@anbaram.gov.in',
      role: OfficialRole.stateAdmin,
    ),
    'district@anbaram.gov.in': const Official(
      id: 'off-002',
      name: 'Priya Subramaniam',
      email: 'district@anbaram.gov.in',
      role: OfficialRole.districtOfficer,
      assignedDistrict: 'Chennai',
    ),
    'centre@anbaram.gov.in': const Official(
      id: 'off-003',
      name: 'Muthu Lakshmi',
      email: 'centre@anbaram.gov.in',
      role: OfficialRole.centreManager,
      assignedCentreId: 'ctr-001',
    ),
  };

  static const _validPassword = 'anbaram2024';

  /// Returns the authenticated [Official] or throws.
  Future<Official> login(String email, String password) async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 1200));

    final official = _users[email.trim().toLowerCase()];
    if (official == null || password != _validPassword) {
      throw Exception('Invalid email or password');
    }
    return official;
  }
}
