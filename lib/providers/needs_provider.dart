import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anbaram_admin/models/need_request.dart';
import 'package:anbaram_admin/services/mock/mock_needs_service.dart';

class NeedsState {
  final List<NeedRequest> needs;
  final bool isLoading;
  final String? error;

  const NeedsState({
    this.needs = const [],
    this.isLoading = false,
    this.error,
  });

  NeedsState copyWith({
    List<NeedRequest>? needs,
    bool? isLoading,
    String? error,
  }) {
    return NeedsState(
      needs: needs ?? this.needs,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class NeedsNotifier extends StateNotifier<NeedsState> {
  final MockNeedsService _service;

  NeedsNotifier({MockNeedsService? service})
      : _service = service ?? MockNeedsService(),
        super(const NeedsState()) {
    loadNeeds();
  }

  Future<void> loadNeeds() async {
    state = state.copyWith(isLoading: true);
    try {
      final needs = await _service.getPendingNeeds();
      state = state.copyWith(needs: needs, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  void fulfillNeed(String id) {
    // In a real app, this would make an API call to transfer inventory.
    // For MVP, we just remove the need from the local list.
    state = state.copyWith(
      needs: state.needs.where((n) => n.id != id).toList(),
    );
  }
}

final needsProvider = StateNotifierProvider<NeedsNotifier, NeedsState>(
  (ref) => NeedsNotifier(),
);
