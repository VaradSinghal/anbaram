import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:anbaram_admin/providers/auth_provider.dart';
import 'package:anbaram_admin/theme/app_colors.dart';

/// Animated splash screen — Anbaram logo reveal.
///
/// Checks for an existing session and routes to `/home` or `/login`.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  // Staggered animations
  late final Animation<double> _ringScale;
  late final Animation<double> _ringOpacity;
  late final Animation<double> _iconScale;
  late final Animation<double> _iconOpacity;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _titleOpacity;
  late final Animation<double> _tamilOpacity;
  late final Animation<double> _taglineOpacity;
  late final Animation<double> _portalOpacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );

    // ── Background ring (0 → 30 %) ──────────────────────
    _ringScale = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOutCubic),
    ));
    _ringOpacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.2),
    ));

    // ── Logo icon (5 → 35 %) ────────────────────────────
    _iconScale = Tween(begin: 0.4, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.05, 0.35, curve: Curves.easeOutBack),
    ));
    _iconOpacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.05, 0.25),
    ));

    // ── "Anbaram" title (25 → 50 %) ─────────────────────
    _titleSlide = Tween(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.25, 0.50, curve: Curves.easeOut),
    ));
    _titleOpacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.25, 0.45),
    ));

    // ── "அன்பரம்" (40 → 60 %) ───────────────────────────
    _tamilOpacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.40, 0.60),
    ));

    // ── Tagline (55 → 75 %) ─────────────────────────────
    _taglineOpacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.55, 0.75),
    ));

    // ── "Official Admin Portal" (70 → 90 %) ─────────────
    _portalOpacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.70, 0.90),
    ));

    _controller.forward();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    final stopwatch = Stopwatch()..start();

    // Start auth check while animation plays.
    final hasSession =
        await ref.read(authProvider.notifier).tryRestoreSession();

    // Ensure the animation has at least 2.5 s to play.
    final elapsed = stopwatch.elapsedMilliseconds;
    if (elapsed < 2500) {
      await Future.delayed(Duration(milliseconds: 2500 - elapsed));
    }

    if (!mounted) return;
    context.go(hasSession ? '/home' : '/login');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Glowing ring + icon ───────────────────
                _buildLogo(),
                const SizedBox(height: 28),

                // ── "Anbaram" ─────────────────────────────
                SlideTransition(
                  position: _titleSlide,
                  child: FadeTransition(
                    opacity: _titleOpacity,
                    child: Text(
                      'Anbaram',
                      style: GoogleFonts.poppins(
                        fontSize: 38,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                // ── "அன்பரம்" ─────────────────────────────
                FadeTransition(
                  opacity: _tamilOpacity,
                  child: Text(
                    'அன்பரம்',
                    style: GoogleFonts.notoSansTamil(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ── Tagline ──────────────────────────────
                FadeTransition(
                  opacity: _taglineOpacity,
                  child: Text(
                    'Compassion in Action',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 48),

                // ── "Official Admin Portal" ──────────────
                FadeTransition(
                  opacity: _portalOpacity,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Official Admin Portal',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      width: 140,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Outer glow ring ──────────────────────────
          FadeTransition(
            opacity: _ringOpacity,
            child: ScaleTransition(
              scale: _ringScale,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    width: 2,
                  ),
                ),
              ),
            ),
          ),

          // ── Inner glow ──────────────────────────────
          FadeTransition(
            opacity: _ringOpacity,
            child: ScaleTransition(
              scale: _ringScale,
              child: Container(
                width: 115,
                height: 115,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.06),
                ),
              ),
            ),
          ),

          // ── Icon circle ─────────────────────────────
          FadeTransition(
            opacity: _iconOpacity,
            child: ScaleTransition(
              scale: _iconScale,
              child: Hero(
                tag: 'anbaram-logo',
                child: Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.volunteer_activism,
                    color: AppColors.background,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
