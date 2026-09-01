import 'package:flutter/material.dart';

/// Anbaram brand colour palette.
///
/// Light cream & brown, warm and approachable — fits a
/// charity / government-trust tone.
class AppColors {
  AppColors._();

  // ─── Core brand ───────────────────────────────────────
  static const Color background = Color(0xFFFAF3E9);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF6B4226);
  static const Color secondary = Color(0xFFA9754F);
  static const Color accent = Color(0xFFD97B3F);

  // ─── Status ───────────────────────────────────────────
  static const Color success = Color(0xFF7A8B5E);
  static const Color warning = Color(0xFFD9A441);
  static const Color critical = Color(0xFFB25444);

  // ─── Text ─────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF3A2A1D);
  static const Color textSecondary = Color(0xFF7A6A5D);

  // ─── Derived / UI chrome ──────────────────────────────
  static const Color divider = Color(0xFFE8DFD3);
  static const Color inputBorder = Color(0xFFD4C8BA);
  static const Color inputFocusBorder = Color(0xFF6B4226);
  static const Color shimmerBase = Color(0xFFEDE5DA);
  static const Color shimmerHighlight = Color(0xFFF5EFE6);
  static const Color cardShadow = Color(0x14000000); // 8 % black
  static const Color overlay = Color(0x33000000); // 20 % black
}
