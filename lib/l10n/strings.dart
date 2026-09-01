import 'package:flutter/material.dart';

/// Lightweight localisation helper — no code-gen dependency.
///
/// Usage: `final s = S.of(context);`  then `s.appTitle`, `s.settings`, etc.
class S {
  final bool _ta;
  const S._(this._ta);

  static S of(BuildContext context) {
    final code = Localizations.localeOf(context).languageCode;
    return S._(code == 'ta');
  }

  // ─── App ──────────────────────────────────────────────
  String get appTitle => _ta ? 'அன்பரம்' : 'Anbaram';
  String get appTagline => _ta ? 'இரக்கம் செயலில்' : 'Compassion in Action';
  String get officialPortal =>
      _ta ? 'அதிகாரி நிர்வாக போர்டல்' : 'Official Admin Portal';

  // ─── Home ─────────────────────────────────────────────
  String greeting(String name) {
    final h = DateTime.now().hour;
    final tod = h < 12
        ? (_ta ? 'காலை' : 'morning')
        : h < 17
            ? (_ta ? 'மதியம்' : 'afternoon')
            : (_ta ? 'மாலை' : 'evening');
    return _ta ? 'நல்ல $tod, $name!' : 'Good $tod, $name!';
  }

  String get todaysDonations =>
      _ta ? 'இன்றைய நன்கொடைகள்' : "Today's Donations";
  String get criticalCentres => _ta ? 'அவசர மையங்கள்' : 'Critical Centres';
  String get pendingNeeds =>
      _ta ? 'நிலுவையில் உள்ள தேவைகள்' : 'Pending Needs';
  String get mapDashboard => _ta ? 'வரைபட டாஷ்போர்ட்' : 'Map Dashboard';
  String get needsOverview => _ta ? 'தேவைகள் கண்ணோட்டம்' : 'Needs Overview';
  String get recentActivity => _ta ? 'சமீபத்திய செயல்பாடு' : 'Recent Activity';
  String get viewAll => _ta ? 'அனைத்தையும் காண' : 'View All';
  String get quickActions => _ta ? 'விரைவு செயல்கள்' : 'Quick Actions';
  String get mapDashboardDesc => _ta
      ? 'தமிழ்நாடு முழுவதும் அனைத்து மையங்களையும் காண்க'
      : 'View all centres across Tamil Nadu';
  String get needsOverviewDesc => _ta
      ? 'மாநிலம் முழுவதும் நிலுவையிலுள்ள தேவைகளை மதிப்பாய்வு செய்யுங்கள்'
      : 'Review pending need requests statewide';

  // ─── Settings ─────────────────────────────────────────
  String get settings => _ta ? 'அமைப்புகள்' : 'Settings';
  String get profile => _ta ? 'சுயவிவரம்' : 'Profile';
  String get language => _ta ? 'மொழி' : 'Language';
  String get english => 'English';
  String get tamil => 'தமிழ் (Tamil)';
  String get signOut => _ta ? 'வெளியேறு' : 'Sign Out';
  String get signOutConfirm =>
      _ta ? 'வெளியேற விரும்புகிறீர்களா?' : 'Sign out of Anbaram?';
  String get cancel => _ta ? 'ரத்து' : 'Cancel';
  String get appVersion => _ta ? 'பதிப்பு' : 'Version';

  // ─── Status ───────────────────────────────────────────
  String get wellStocked => _ta ? 'நிறைந்த இருப்பு' : 'Well Stocked';
  String get lowStock => _ta ? 'குறைந்த இருப்பு' : 'Low Stock';
  String get criticalStock => _ta ? 'அவசரம்' : 'Critical';

  // ─── Roles ────────────────────────────────────────────
  String get stateAdmin => _ta ? 'மாநில நிர்வாகி' : 'State Admin';
  String get districtOfficer => _ta ? 'மாவட்ட அதிகாரி' : 'District Officer';
  String get centreManager => _ta ? 'மைய மேலாளர்' : 'Centre Manager';

  // ─── General ──────────────────────────────────────────
  String get loading => _ta ? 'ஏற்றுகிறது...' : 'Loading...';
  String get comingSoon => _ta ? 'விரைவில் வருகிறது' : 'Coming Soon';
  String get noData => _ta ? 'தரவு இல்லை' : 'No data available';
  String get totalCentres => _ta ? 'மொத்த மையங்கள்' : 'Total Centres';
  String get centres => _ta ? 'மையங்கள்' : 'Centres';
  String get needs => _ta ? 'தேவைகள்' : 'Needs';
}
