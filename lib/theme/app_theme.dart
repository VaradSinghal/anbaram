import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

/// Anbaram app theme — warm cream & brown palette with
/// 12 px corner radii, soft shadows, and Material 3.
class AppTheme {
  AppTheme._();

  // ─── Corner radius token ──────────────────────────────
  static const double radius = 12.0;
  static final BorderRadius borderRadius = BorderRadius.circular(radius);

  // ─── Shadow token ─────────────────────────────────────
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: AppColors.cardShadow,
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  // ─── ColorScheme ──────────────────────────────────────
  static ColorScheme get _colorScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: Colors.white,
        primaryContainer: Color(0xFFE8D5C4),
        onPrimaryContainer: AppColors.primary,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        secondaryContainer: Color(0xFFF0DFD0),
        onSecondaryContainer: AppColors.secondary,
        tertiary: AppColors.accent,
        onTertiary: Colors.white,
        error: AppColors.critical,
        onError: Colors.white,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        onSurfaceVariant: AppColors.textSecondary,
        outline: AppColors.inputBorder,
        outlineVariant: AppColors.divider,
        shadow: AppColors.cardShadow,
      );

  // ─── ThemeData ────────────────────────────────────────
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: _colorScheme,
        scaffoldBackgroundColor: AppColors.background,
        textTheme: AppTextStyles.textTheme,

        // ── App bar ──────────────────────────────────────
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          scrolledUnderElevation: 0.5,
          centerTitle: false,
          titleTextStyle: AppTextStyles.titleLarge,
          iconTheme: const IconThemeData(color: AppColors.primary),
        ),

        // ── Cards ────────────────────────────────────────
        cardTheme: CardThemeData(
          color: AppColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
          margin: EdgeInsets.zero,
        ),

        // ── Elevated buttons ─────────────────────────────
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            textStyle: AppTextStyles.buttonLarge,
            minimumSize: const Size(double.infinity, 52),
          ),
        ),

        // ── Outlined buttons ─────────────────────────────
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary, width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            textStyle: AppTextStyles.buttonMedium,
            minimumSize: const Size(double.infinity, 52),
          ),
        ),

        // ── Text buttons ────────────────────────────────
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.accent,
            textStyle: AppTextStyles.labelLarge,
          ),
        ),

        // ── Input decoration ─────────────────────────────
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surface,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(color: AppColors.inputBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(color: AppColors.inputBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide:
                const BorderSide(color: AppColors.inputFocusBorder, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(color: AppColors.critical),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(color: AppColors.critical, width: 2),
          ),
          labelStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary.withValues(alpha: 0.6),
          ),
          errorStyle: AppTextStyles.bodySmall.copyWith(
            color: AppColors.critical,
          ),
          prefixIconColor: AppColors.secondary,
        ),

        // ── Chips (for status indicators) ────────────────
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: BorderSide.none,
          labelStyle: AppTextStyles.labelMedium,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),

        // ── Bottom navigation ────────────────────────────
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),

        // ── Tab bar ──────────────────────────────────────
        tabBarTheme: TabBarThemeData(
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: AppTextStyles.labelLarge,
          unselectedLabelStyle: AppTextStyles.labelLarge,
        ),

        // ── Divider ──────────────────────────────────────
        dividerTheme: const DividerThemeData(
          color: AppColors.divider,
          thickness: 1,
          space: 1,
        ),

        // ── Dialog ───────────────────────────────────────
        dialogTheme: DialogThemeData(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          titleTextStyle: AppTextStyles.headlineMedium,
          contentTextStyle: AppTextStyles.bodyMedium,
        ),

        // ── Bottom sheet ─────────────────────────────────
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: AppColors.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          showDragHandle: true,
          dragHandleColor: AppColors.divider,
        ),

        // ── Snackbar ─────────────────────────────────────
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.textPrimary,
          contentTextStyle:
              AppTextStyles.bodyMedium.copyWith(color: Colors.white),
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          behavior: SnackBarBehavior.floating,
        ),

        // ── Floating action button ───────────────────────
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
        ),
      );
}
