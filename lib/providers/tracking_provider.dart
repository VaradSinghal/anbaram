import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anbaram_admin/models/tracked_item.dart';
import 'package:anbaram_admin/services/mock/mock_tracking_service.dart';

class TrackingState {
  final List<TrackedItem> items;
  final bool isLoading;
  final String? error;

  const TrackingState({
    this.items = const [],
    this.isLoading = false,
    this.error,
  });

  TrackingState copyWith({
    List<TrackedItem>? items,
    bool? isLoading,
    String? error,
  }) {
    return TrackingState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class TrackingNotifier extends StateNotifier<TrackingState> {
  final MockTrackingService _service;

  TrackingNotifier({MockTrackingService? service})
      : _service = service ?? MockTrackingService(),
        super(const TrackingState()) {
    loadItems();
  }

  Future<void> loadItems() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final items = await _service.getTrackedItems();
      state = state.copyWith(items: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  void addTrackingEvent(String itemId, TrackingStatus newStatus, String description, String location) {
    final newEvent = TrackingEvent(
      timestamp: DateTime.now(),
      status: newStatus,
      description: description,
      location: location,
    );

    final updatedItems = state.items.map((item) {
      if (item.id == itemId) {
        // Insert new event at the beginning of the history (most recent first)
        final updatedHistory = [newEvent, ...item.history];
        return TrackedItem(
          id: item.id,
          itemName: item.itemName,
          quantity: item.quantity,
          originCentreName: item.originCentreName,
          destinationArea: item.destinationArea,
          history: updatedHistory,
        );
      }
      return item;
    }).toList();

    state = state.copyWith(items: updatedItems);
  }
}

final trackingProvider = StateNotifierProvider<TrackingNotifier, TrackingState>(
  (ref) => TrackingNotifier(),
);
