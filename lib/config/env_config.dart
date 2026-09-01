import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Typed access to values from the `.env` file.
class EnvConfig {
  EnvConfig._();

  static String get googleMapsApiKey =>
      dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';

  static Future<void> load() async {
    await dotenv.load(fileName: '.env');
  }
}
