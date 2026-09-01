import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:anbaram_admin/models/official.dart';
import 'package:anbaram_admin/services/mock/mock_auth_service.dart';
import 'package:anbaram_admin/services/storage_service.dart';

// ─── State ──────────────────────────────────────────────

class AuthState {
  final Official? official;
  final bool isLoading;
  final String? error;

  const AuthState({this.official, this.isLoading = false, this.error});

  bool get isAuthenticated => official != null;

  AuthState copyWith({
    Official? official,
    bool? isLoading,
    String? error,
    bool clearOfficial = false,
    bool clearError = false,
  }) =>
      AuthState(
        official: clearOfficial ? null : (official ?? this.official),
        isLoading: isLoading ?? this.isLoading,
        error: clearError ? null : (error ?? this.error),
      );
}

// ─── Notifier ───────────────────────────────────────────

class AuthNotifier extends StateNotifier<AuthState> {
  final StorageService _storage;
  final MockAuthService _authService;

  AuthNotifier({
    StorageService? storage,
    MockAuthService? authService,
  })  : _storage = storage ?? StorageService(),
        _authService = authService ?? MockAuthService(),
        super(const AuthState());

  /// Check for a persisted session (called once from the splash screen).
  Future<bool> tryRestoreSession() async {
    final token = await _storage.getToken();
    if (token == null) return false;

    final data = await _storage.getOfficialData();
    if (data == null) return false;

    try {
      final official = Official.fromJson(data);
      state = AuthState(official: official);
      return true;
    } catch (_) {
      await _storage.clearAll();
      return false;
    }
  }

  /// Attempt login with [email] and [password].
  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final official = await _authService.login(email, password);
      await _storage.saveToken('mock_jwt_${official.id}');
      await _storage.saveOfficialData(official.toJson());
      state = AuthState(official: official);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    }
  }

  /// Sign out and clear persisted data.
  Future<void> logout() async {
    await _storage.clearAll();
    state = const AuthState();
  }
}

// ─── Provider ───────────────────────────────────────────

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);
