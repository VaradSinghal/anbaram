import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:anbaram_admin/screens/splash_screen.dart';
import 'package:anbaram_admin/screens/login_screen.dart';
import 'package:anbaram_admin/screens/home/state_admin_home.dart';
import 'package:anbaram_admin/screens/map/map_dashboard_screen.dart';
import 'package:anbaram_admin/screens/map/centre_detail_screen.dart';
import 'package:anbaram_admin/screens/needs/needs_overview_screen.dart';
import 'package:anbaram_admin/screens/settings/settings_screen.dart';
import 'package:anbaram_admin/screens/analytics/analytics_screen.dart';

/// Single [GoRouter] instance — created once, never recreated.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
          transitionsBuilder: (context, animation, _, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginScreen(),
          transitionsBuilder: (context, animation, _, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(milliseconds: 600),
        ),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const StateAdminHome(),
          transitionsBuilder: (context, animation, _, child) {
            final slide = Tween<Offset>(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ));
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: slide, child: child),
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: '/map',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const MapDashboardScreen(),
          transitionsBuilder: (context, animation, _, child) {
            final slide = Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ));
            return SlideTransition(position: slide, child: child);
          },
          transitionDuration: const Duration(milliseconds: 350),
        ),
      ),
      GoRoute(
        path: '/centre/:id',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: CentreDetailScreen(centreId: state.pathParameters['id']!),
          transitionsBuilder: (context, animation, _, child) {
            final slide = Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ));
            return SlideTransition(position: slide, child: child);
          },
          transitionDuration: const Duration(milliseconds: 350),
        ),
      ),
      GoRoute(
        path: '/needs',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const NeedsOverviewScreen(),
          transitionsBuilder: (context, animation, _, child) {
            final slide = Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ));
            return SlideTransition(position: slide, child: child);
          },
          transitionDuration: const Duration(milliseconds: 350),
        ),
      ),
      GoRoute(
        path: '/settings',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SettingsScreen(),
          transitionsBuilder: (context, animation, _, child) {
            final slide = Tween<Offset>(
              begin: const Offset(0, 0.1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ));
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: slide, child: child),
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
        ),
      ),
      GoRoute(
        path: '/analytics',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AnalyticsScreen(),
          transitionsBuilder: (context, animation, _, child) {
            final slide = Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ));
            return SlideTransition(position: slide, child: child);
          },
          transitionDuration: const Duration(milliseconds: 350),
        ),
      ),
    ],
  );
});
