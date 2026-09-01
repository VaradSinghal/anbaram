/// Role hierarchy for officials.
enum OfficialRole {
  stateAdmin('State Admin', 'மாநில நிர்வாகி'),
  districtOfficer('District Officer', 'மாவட்ட அதிகாரி'),
  centreManager('Centre Manager', 'மைய மேலாளர்');

  const OfficialRole(this.displayName, this.displayNameTa);
  final String displayName;
  final String displayNameTa;
}

/// Stock health for a centre or individual inventory item.
enum StockStatus {
  healthy('Well Stocked', 'நிறைந்த இருப்பு'),
  low('Low Stock', 'குறைந்த இருப்பு'),
  critical('Critical', 'அவசரம்');

  const StockStatus(this.displayName, this.displayNameTa);
  final String displayName;
  final String displayNameTa;
}

/// Lifecycle of a donation.
enum DonationStatus {
  pledged,
  confirmed,
  cancelled,
}

/// Urgency level for a need request.
enum NeedUrgency {
  normal,
  high,
  critical,
}
