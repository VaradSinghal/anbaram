import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:anbaram_admin/config/app_constants.dart';
import 'package:anbaram_admin/theme/app_colors.dart';

/// Accessible status chip — coloured background + dot + label.
///
/// Never uses colour alone; always pairs with a text label
/// for accessibility compliance.
class StatusChip extends StatelessWidget {
  final StockStatus status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      StockStatus.healthy => (AppColors.success, 'Well Stocked'),
      StockStatus.low => (AppColors.warning, 'Low Stock'),
      StockStatus.critical => (AppColors.critical, 'Critical'),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
