import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:anbaram_admin/providers/centres_provider.dart';
import 'package:anbaram_admin/theme/app_colors.dart';
import 'package:anbaram_admin/theme/app_theme.dart';
import 'package:anbaram_admin/widgets/status_chip.dart';

class CentreDetailScreen extends ConsumerWidget {
  final String centreId;

  const CentreDetailScreen({super.key, required this.centreId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Find the centre from the provider
    final dashboard = ref.watch(dashboardProvider);
    final centre = dashboard.centres.where((c) => c.id == centreId).firstOrNull;

    if (centre == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Centre Details')),
        body: const Center(child: Text('Centre not found')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Centre Details',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ── Header Card ─────────────────────────
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppTheme.borderRadius,
              boxShadow: AppTheme.cardShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        centre.name,
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    StatusChip(status: centre.stockStatus),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 18, color: AppColors.textSecondary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${centre.address}, ${centre.district}',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── Statistics ─────────────────────────
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Total Items', centre.totalItems.toString(), AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard('Pending Needs', centre.pendingNeeds.toString(), AppColors.warning),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard('Donations', centre.donationsThisMonth.toString(), AppColors.accent),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // ── Contact Info ───────────────────────
          Text(
            'Contact Information',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppTheme.borderRadius,
              boxShadow: AppTheme.cardShadow,
            ),
            child: Column(
              children: [
                _buildContactRow(Icons.person_outline, 'Manager', centre.contactName),
                const Divider(height: 24, color: AppColors.divider),
                _buildContactRow(Icons.phone_outlined, 'Phone', centre.contactPhone),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // ── Mock Inventory ─────────────────────
          Text(
            'Current Inventory',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _buildInventoryList(),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppTheme.borderRadius,
        boxShadow: AppTheme.cardShadow,
        border: Border(top: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInventoryList() {
    // Generate some mock inventory items based on the centre
    final mockItems = [
      {'name': 'Drinking Water (1L)', 'qty': 450, 'unit': 'bottles'},
      {'name': 'Rice (5kg)', 'qty': 120, 'unit': 'bags'},
      {'name': 'Blankets', 'qty': 85, 'unit': 'units'},
      {'name': 'First Aid Kits', 'qty': 30, 'unit': 'boxes'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppTheme.borderRadius,
        boxShadow: AppTheme.cardShadow,
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: mockItems.length,
        separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.divider),
        itemBuilder: (context, index) {
          final item = mockItems[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            leading: const Icon(Icons.inventory_2_outlined, color: AppColors.secondary),
            title: Text(
              item['name'] as String,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            trailing: Text(
              '${item['qty']} ${item['unit']}',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          );
        },
      ),
    );
  }
}
