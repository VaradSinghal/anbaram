import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anbaram_admin/services/mock/mock_analytics_service.dart';

class AnalyticsState {
  final Map<String, dynamic>? data;
  final bool isLoading;
  final String? error;

  const AnalyticsState({
    this.data,
    this.isLoading = false,
    this.error,
  });

  AnalyticsState copyWith({
    Map<String, dynamic>? data,
    bool? isLoading,
    String? error,
  }) {
    return AnalyticsState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AnalyticsNotifier extends StateNotifier<AnalyticsState> {
  final MockAnalyticsService _service;

  AnalyticsNotifier({MockAnalyticsService? service})
      : _service = service ?? MockAnalyticsService(),
        super(const AnalyticsState()) {
    loadAnalytics();
  }

  Future<void> loadAnalytics() async {
    state = state.copyWith(isLoading: true);
    try {
      final data = await _service.getAnalyticsOverview();
      state = state.copyWith(data: data, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}

final analyticsProvider = StateNotifierProvider<AnalyticsNotifier, AnalyticsState>(
  (ref) => AnalyticsNotifier(),
);
