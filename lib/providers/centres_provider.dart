import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:anbaram_admin/config/app_constants.dart';
import 'package:anbaram_admin/models/activity_log_entry.dart';
import 'package:anbaram_admin/models/centre.dart';
import 'package:anbaram_admin/services/mock/mock_activity_service.dart';
import 'package:anbaram_admin/services/mock/mock_centres_service.dart';

// ─── State ──────────────────────────────────────────────

class DashboardState {
  final List<Centre> centres;
  final List<ActivityLogEntry> recentActivity;
  final bool isLoading;
  final String? error;

  const DashboardState({
    this.centres = const [],
    this.recentActivity = const [],
    this.isLoading = false,
    this.error,
  });

  // ── Computed summary stats ────────────────────────────
  int get todaysDonations =>
      centres.fold(0, (sum, c) => sum + c.donationsThisMonth);

  int get criticalCentres =>
      centres.where((c) => c.stockStatus == StockStatus.critical).length;

  int get pendingNeeds =>
      centres.fold(0, (sum, c) => sum + c.pendingNeeds);

  int get totalCentres => centres.length;

  int get healthyCentres =>
      centres.where((c) => c.stockStatus == StockStatus.healthy).length;

  int get lowCentres =>
      centres.where((c) => c.stockStatus == StockStatus.low).length;

  DashboardState copyWith({
    List<Centre>? centres,
    List<ActivityLogEntry>? recentActivity,
    bool? isLoading,
    String? error,
  }) =>
      DashboardState(
        centres: centres ?? this.centres,
        recentActivity: recentActivity ?? this.recentActivity,
        isLoading: isLoading ?? this.isLoading,
        error: error,
      );
}

// ─── Notifier ───────────────────────────────────────────

class DashboardNotifier extends StateNotifier<DashboardState> {
  final MockCentresService _centresService;
  final MockActivityService _activityService;

  DashboardNotifier({
    MockCentresService? centresService,
    MockActivityService? activityService,
  })  : _centresService = centresService ?? MockCentresService(),
        _activityService = activityService ?? MockActivityService(),
        super(const DashboardState());

  Future<void> loadDashboard() async {
    state = state.copyWith(isLoading: true);
    try {
      final results = await Future.wait([
        _centresService.getCentres(),
        _activityService.getRecentActivity(),
      ]);
      state = DashboardState(
        centres: results[0] as List<Centre>,
        recentActivity: results[1] as List<ActivityLogEntry>,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

// ─── Provider ───────────────────────────────────────────

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>(
  (ref) => DashboardNotifier(),
);
