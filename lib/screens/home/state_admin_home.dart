import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:anbaram_admin/l10n/strings.dart';
import 'package:anbaram_admin/models/activity_log_entry.dart';
import 'package:anbaram_admin/providers/auth_provider.dart';
import 'package:anbaram_admin/providers/centres_provider.dart';
import 'package:anbaram_admin/theme/app_colors.dart';
import 'package:anbaram_admin/theme/app_theme.dart';
import 'package:anbaram_admin/widgets/stat_card.dart';

/// State Admin Home — summary dashboard with stats, quick actions,
/// and recent activity feed.
class StateAdminHome extends ConsumerStatefulWidget {
  const StateAdminHome({super.key});

  @override
  ConsumerState<StateAdminHome> createState() => _StateAdminHomeState();
}

class _StateAdminHomeState extends ConsumerState<StateAdminHome> {
  @override
  void initState() {
    super.initState();
    // Load dashboard data on first build.
    Future.microtask(
      () => ref.read(dashboardProvider.notifier).loadDashboard(),
    );
  }

  Future<void> _refresh() async {
    await ref.read(dashboardProvider.notifier).loadDashboard();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final auth = ref.watch(authProvider);
    final dashboard = ref.watch(dashboardProvider);
    final official = auth.official;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(s),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: _refresh,
        child: dashboard.isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.primary))
            : ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                children: [
                  // ── Greeting ─────────────────────────
                  _buildGreeting(s, official?.name ?? 'Admin'),
                  const SizedBox(height: 24),

                  // ── Stat cards ───────────────────────
                  _buildStatCards(s, dashboard),
                  const SizedBox(height: 28),

                  // ── Quick actions ────────────────────
                  _buildSectionHeader(s.quickActions),
                  const SizedBox(height: 12),
                  _buildQuickAction(
                    icon: Icons.map_outlined,
                    title: s.mapDashboard,
                    subtitle: s.mapDashboardDesc,
                    onTap: () => context.go('/map'),
                  ),
                  const SizedBox(height: 12),
                  _buildQuickAction(
                    icon: Icons.assignment_outlined,
                    title: s.needsOverview,
                    subtitle: s.needsOverviewDesc,
                    onTap: () => context.go('/needs'),
                  ),
                  const SizedBox(height: 12),
                  _buildQuickAction(
                    icon: Icons.bar_chart_rounded,
                    title: 'Analytics & Insights',
                    subtitle: 'View overall impact and statistics',
                    onTap: () => context.go('/analytics'),
                  ),
                  const SizedBox(height: 28),

                  // ── Recent activity ──────────────────
                  _buildSectionHeader(
                    s.recentActivity,
                    trailing: s.viewAll,
                  ),
                  const SizedBox(height: 12),
                  ...dashboard.recentActivity
                      .take(6)
                      .map(_buildActivityTile),
                ],
              ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════
  // Sub-widgets
  // ═══════════════════════════════════════════════════════

  PreferredSizeWidget _buildAppBar(S s) {
    return AppBar(
      title: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.volunteer_activism,
              color: AppColors.background,
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            s.appTitle,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          tooltip: 'Notifications',
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          tooltip: s.settings,
          onPressed: () => context.go('/settings'),
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  Widget _buildGreeting(S s, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.greeting(name),
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            s.stateAdmin,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCards(S s, DashboardState dashboard) {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            icon: Icons.card_giftcard_rounded,
            color: AppColors.accent,
            count: dashboard.todaysDonations,
            label: s.todaysDonations,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatCard(
            icon: Icons.warning_amber_rounded,
            color: AppColors.critical,
            count: dashboard.criticalCentres,
            label: s.criticalCentres,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatCard(
            icon: Icons.pending_actions_rounded,
            color: AppColors.warning,
            count: dashboard.pendingNeeds,
            label: s.pendingNeeds,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, {String? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (trailing != null)
          Text(
            trailing,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.accent,
            ),
          ),
      ],
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColors.surface,
      borderRadius: AppTheme.borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppTheme.borderRadius,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: AppTheme.borderRadius,
            boxShadow: AppTheme.cardShadow,
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityTile(ActivityLogEntry entry) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppTheme.borderRadius,
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Icon ──────────────────────────────────
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: entry.iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(entry.icon, color: entry.iconColor, size: 18),
            ),
            const SizedBox(width: 12),

            // ── Content ───────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.description,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${entry.centreName} · ${entry.timeAgo}',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
