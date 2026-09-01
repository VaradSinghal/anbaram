// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appTitle => 'அன்பரம்';

  @override
  String get appTagline => 'இரக்கம் செயலில்';

  @override
  String get officialPortal => 'அதிகாரி நிர்வாக போர்டல்';

  @override
  String get loginWelcome => 'மீண்டும் வரவேற்கிறோம்';

  @override
  String get loginSubtitle => 'மையங்களை நிர்வகிக்க உள்நுழையவும்';

  @override
  String get loginEmail => 'மின்னஞ்சல் முகவரி';

  @override
  String get loginPassword => 'கடவுச்சொல்';

  @override
  String get loginSignIn => 'உள்நுழை';

  @override
  String get loginInvalidCredentials =>
      'தவறான மின்னஞ்சல் அல்லது கடவுச்சொல். மீண்டும் முயற்சிக்கவும்.';

  @override
  String get loginDemoCredentials => 'டெமோ: admin@anbaram.gov.in / anbaram2024';

  @override
  String homeGreeting(String timeOfDay, String name) {
    return 'நல்ல $timeOfDay, $name!';
  }

  @override
  String get todaysDonations => 'இன்றைய நன்கொடைகள்';

  @override
  String get criticalCentres => 'அவசர மையங்கள்';

  @override
  String get pendingNeeds => 'நிலுவையில் உள்ள தேவைகள்';

  @override
  String get mapDashboard => 'வரைபட டாஷ்போர்ட்';

  @override
  String get needsOverview => 'தேவைகள் கண்ணோட்டம்';

  @override
  String get recentActivity => 'சமீபத்திய செயல்பாடு';

  @override
  String get viewAll => 'அனைத்தையும் காண';

  @override
  String get stateAdmin => 'மாநில நிர்வாகி';

  @override
  String get districtOfficer => 'மாவட்ட அதிகாரி';

  @override
  String get centreManager => 'மைய மேலாளர்';

  @override
  String get wellStocked => 'நிறைந்த இருப்பு';

  @override
  String get lowStock => 'குறைந்த இருப்பு';

  @override
  String get criticalStock => 'அவசரம்';

  @override
  String get loading => 'ஏற்றுகிறது...';

  @override
  String get retry => 'மீண்டும் முயற்சி';

  @override
  String get somethingWentWrong => 'ஏதோ தவறு ஏற்பட்டது';

  @override
  String get offlineMessage =>
      'நீங்கள் ஆஃப்லைனில் உள்ளீர்கள் — இணைப்பு திரும்பும்போது மாற்றங்கள் ஒத்திசைக்கப்படும்';

  @override
  String get noData => 'தரவு இல்லை';

  @override
  String get signOut => 'வெளியேறு';

  @override
  String get settings => 'அமைப்புகள்';
}
