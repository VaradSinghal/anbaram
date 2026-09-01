import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Thin wrapper around [FlutterSecureStorage] for JWT + official data.
class StorageService {
  static const _keyToken = 'auth_token';
  static const _keyOfficial = 'official_data';

  final FlutterSecureStorage _storage;

  StorageService({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
            );

  // ─── Token ──────────────────────────────────────────
  Future<String?> getToken() => _storage.read(key: _keyToken);

  Future<void> saveToken(String token) =>
      _storage.write(key: _keyToken, value: token);

  // ─── Official data (serialised JSON) ────────────────
  Future<Map<String, dynamic>?> getOfficialData() async {
    final raw = await _storage.read(key: _keyOfficial);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<void> saveOfficialData(Map<String, dynamic> data) =>
      _storage.write(key: _keyOfficial, value: jsonEncode(data));

  // ─── Clear all ──────────────────────────────────────
  Future<void> clearAll() => _storage.deleteAll();
}
