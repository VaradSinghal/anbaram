import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:anbaram_admin/providers/auth_provider.dart';
import 'package:anbaram_admin/theme/app_colors.dart';
import 'package:anbaram_admin/theme/app_theme.dart';

/// Anbaram-branded login screen.
///
/// Uses mock auth (admin@anbaram.gov.in / anbaram2024).
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;

  late final AnimationController _animCtrl;
  late final Animation<Offset> _brandSlide;
  late final Animation<double> _brandOpacity;
  late final Animation<Offset> _cardSlide;
  late final Animation<double> _cardOpacity;

  @override
  void initState() {
    super.initState();

    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // ── Branding fades in from above ────────────────────
    _brandSlide = Tween(
      begin: const Offset(0, -0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animCtrl,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));
    _brandOpacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animCtrl,
      curve: const Interval(0.0, 0.4),
    ));

    // ── Card slides up from below ───────────────────────
    _cardSlide = Tween(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animCtrl,
      curve: const Interval(0.2, 0.7, curve: Curves.easeOutCubic),
    ));
    _cardOpacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animCtrl,
      curve: const Interval(0.2, 0.6),
    ));

    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(authProvider.notifier).login(
          _emailCtrl.text.trim(),
          _passwordCtrl.text,
        );

    if (success && mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Decorative curved header ──────────────────
          _buildDecorativeHeader(size),

          // ── Scrollable content ────────────────────────
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: SizedBox(
                height: size.height -
                    MediaQuery.paddingOf(context).top -
                    MediaQuery.paddingOf(context).bottom,
                child: Column(
                  children: [
                    const Spacer(flex: 2),

                    // ── Branding ────────────────────────
                    SlideTransition(
                      position: _brandSlide,
                      child: FadeTransition(
                        opacity: _brandOpacity,
                        child: _buildBranding(),
                      ),
                    ),

                    const Spacer(flex: 1),

                    // ── Login card ──────────────────────
                    SlideTransition(
                      position: _cardSlide,
                      child: FadeTransition(
                        opacity: _cardOpacity,
                        child: _buildLoginCard(authState),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Demo hint ───────────────────────
                    FadeTransition(
                      opacity: _cardOpacity,
                      child: _buildDemoHint(),
                    ),

                    const Spacer(flex: 2),

                    // ── Version ─────────────────────────
                    FadeTransition(
                      opacity: _cardOpacity,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          'v1.0.0 • Anbaram Official',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppColors.textSecondary.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════
  // Sub-widgets
  // ═══════════════════════════════════════════════════════

  Widget _buildDecorativeHeader(Size size) {
    return Positioned(
      top: -size.height * 0.12,
      left: -size.width * 0.2,
      right: -size.width * 0.2,
      child: Container(
        height: size.height * 0.38,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary.withValues(alpha: 0.04),
        ),
      ),
    );
  }

  Widget _buildBranding() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo icon (Hero shared with splash)
        Hero(
          tag: 'anbaram-logo',
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(
              Icons.volunteer_activism,
              color: AppColors.background,
              size: 32,
            ),
          ),
        ),
        const SizedBox(height: 16),

        Text(
          'Anbaram',
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            letterSpacing: 0.5,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          'அன்பரம்',
          style: GoogleFonts.notoSansTamil(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.secondary,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Official Admin Portal',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
            letterSpacing: 1.8,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginCard(AuthState authState) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppTheme.borderRadius,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.06),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────
            Text(
              'Welcome Back',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Sign in to continue managing centres',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: 28),

            // ── Email ───────────────────────────────────
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                prefixIcon: Icon(Icons.mail_outline_rounded),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Email is required';
                if (!v.contains('@')) return 'Enter a valid email';
                return null;
              },
            ),

            const SizedBox(height: 18),

            // ── Password ────────────────────────────────
            TextFormField(
              controller: _passwordCtrl,
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _handleLogin(),
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Password is required';
                return null;
              },
            ),

            // ── Error message ───────────────────────────
            if (authState.error != null) ...[
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.critical.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      size: 18,
                      color: AppColors.critical,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        authState.error!,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppColors.critical,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 28),

            // ── Sign In button ──────────────────────────
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: authState.isLoading ? null : _handleLogin,
                child: authState.isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Sign In',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoHint() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 16,
            color: AppColors.accent.withValues(alpha: 0.8),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              'admin@anbaram.gov.in  •  anbaram2024',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.accent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
