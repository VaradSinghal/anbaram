import 'package:anbaram_admin/config/app_constants.dart';

/// A government official who uses the Anbaram admin app.
class Official {
  final String id;
  final String name;
  final String email;
  final OfficialRole role;

  /// Non-null for [OfficialRole.districtOfficer].
  final String? assignedDistrict;

  /// Non-null for [OfficialRole.centreManager].
  final String? assignedCentreId;

  const Official({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.assignedDistrict,
    this.assignedCentreId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'role': role.name,
        'assigned_district': assignedDistrict,
        'assigned_centre_id': assignedCentreId,
      };

  factory Official.fromJson(Map<String, dynamic> json) => Official(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        role: OfficialRole.values.firstWhere((r) => r.name == json['role']),
        assignedDistrict: json['assigned_district'] as String?,
        assignedCentreId: json['assigned_centre_id'] as String?,
      );
}
