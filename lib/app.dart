import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:anbaram_admin/providers/locale_provider.dart';
import 'package:anbaram_admin/router/app_router.dart';
import 'package:anbaram_admin/theme/app_theme.dart';

/// Root widget — `MaterialApp.router` with Anbaram theming,
/// locale management, and localisation delegates.
class AnbaramApp extends ConsumerWidget {
  const AnbaramApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'Anbaram Official',
      debugShowCheckedModeBanner: false,

      // ── Theme ──────────────────────────────────────────
      theme: AppTheme.light,

      // ── Navigation ─────────────────────────────────────
      routerConfig: router,

      // ── Locale (controlled by localeProvider) ──────────
      locale: locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ta'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
