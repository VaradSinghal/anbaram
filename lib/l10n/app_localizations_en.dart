// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Anbaram';

  @override
  String get appTagline => 'Compassion in Action';

  @override
  String get officialPortal => 'Official Admin Portal';

  @override
  String get loginWelcome => 'Welcome Back';

  @override
  String get loginSubtitle => 'Sign in to continue managing centres';

  @override
  String get loginEmail => 'Email Address';

  @override
  String get loginPassword => 'Password';

  @override
  String get loginSignIn => 'Sign In';

  @override
  String get loginInvalidCredentials =>
      'Invalid email or password. Please try again.';

  @override
  String get loginDemoCredentials => 'Demo: admin@anbaram.gov.in / anbaram2024';

  @override
  String homeGreeting(String timeOfDay, String name) {
    return 'Good $timeOfDay, $name!';
  }

  @override
  String get todaysDonations => 'Today\'s Donations';

  @override
  String get criticalCentres => 'Critical Centres';

  @override
  String get pendingNeeds => 'Pending Needs';

  @override
  String get mapDashboard => 'Map Dashboard';

  @override
  String get needsOverview => 'Needs Overview';

  @override
  String get recentActivity => 'Recent Activity';

  @override
  String get viewAll => 'View All';

  @override
  String get stateAdmin => 'State Admin';

  @override
  String get districtOfficer => 'District Officer';

  @override
  String get centreManager => 'Centre Manager';

  @override
  String get wellStocked => 'Well Stocked';

  @override
  String get lowStock => 'Low Stock';

  @override
  String get criticalStock => 'Critical';

  @override
  String get loading => 'Loading...';

  @override
  String get retry => 'Retry';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get offlineMessage =>
      'You\'re offline — changes will sync when connection returns';

  @override
  String get noData => 'No data available';

  @override
  String get signOut => 'Sign Out';

  @override
  String get settings => 'Settings';
}
