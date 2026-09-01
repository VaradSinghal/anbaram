import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:anbaram_admin/config/app_constants.dart';
import 'package:anbaram_admin/models/centre.dart';
import 'package:anbaram_admin/providers/centres_provider.dart';
import 'package:anbaram_admin/theme/app_colors.dart';
import 'package:anbaram_admin/widgets/status_chip.dart';

class MapDashboardScreen extends ConsumerStatefulWidget {
  const MapDashboardScreen({super.key});

  @override
  ConsumerState<MapDashboardScreen> createState() => _MapDashboardScreenState();
}

class _MapDashboardScreenState extends ConsumerState<MapDashboardScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  bool _markersLoaded = false;

  // Coordinates for Tamil Nadu center
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(11.1271, 78.6569),
    zoom: 6.5,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Load markers when centres are available
    final dashboard = ref.watch(dashboardProvider);
    if (!_markersLoaded && dashboard.centres.isNotEmpty) {
      _markersLoaded = true;
      _loadCustomMarkers(dashboard.centres);
    }
  }

  Future<BitmapDescriptor> _createCustomMarker(Color color) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = color;
    const double radius = 24.0;

    // Draw outer glow/ring
    canvas.drawCircle(const Offset(radius, radius), radius, Paint()..color = color.withValues(alpha: 0.2));
    
    // Draw white border
    canvas.drawCircle(const Offset(radius, radius), radius - 4, Paint()..color = Colors.white);
    
    // Draw solid inner core
    canvas.drawCircle(const Offset(radius, radius), radius - 8, paint);

    final img = await pictureRecorder.endRecording().toImage((radius * 2).toInt(), (radius * 2).toInt());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.bytes(data!.buffer.asUint8List());
  }

  Future<void> _loadCustomMarkers(List<Centre> centres) async {
    final Set<Marker> markers = {};
    for (final centre in centres) {
      final color = switch (centre.stockStatus) {
        StockStatus.healthy => AppColors.success,
        StockStatus.low => AppColors.warning,
        StockStatus.critical => AppColors.critical,
      };

      final icon = await _createCustomMarker(color);

      markers.add(
        Marker(
          markerId: MarkerId(centre.id),
          position: LatLng(centre.latitude, centre.longitude),
          icon: icon,
          onTap: () => _showCentreDetails(centre),
        ),
      );
    }
    
    if (mounted) {
      setState(() {
        _markers = markers;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dashboard = ref.watch(dashboardProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/home'),
        ),
        title: Text(
          'Map Dashboard',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      body: dashboard.isLoading || _markers.isEmpty
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary))
          : GoogleMap(
              initialCameraPosition: _initialPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              markers: _markers,
            ),
    );
  }

  void _showCentreDetails(Centre centre) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _CentreDetailsSheet(centre: centre),
    );
  }
}

class _CentreDetailsSheet extends StatelessWidget {
  final Centre centre;

  const _CentreDetailsSheet({required this.centre});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      centre.name,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${centre.address}, ${centre.district}',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              StatusChip(status: centre.stockStatus),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatBlock('Total Items', centre.totalItems.toString()),
              _buildStatBlock('Pending Needs', centre.pendingNeeds.toString()),
              _buildStatBlock('Donations (Mo)', centre.donationsThisMonth.toString()),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(Icons.person_outline, size: 20, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              Text(
                centre.contactName,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.phone_outlined, size: 20, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              Text(
                centre.contactPhone,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the bottom sheet
                context.push('/centre/${centre.id}');
              },
              child: Text(
                'View Full Details',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBlock(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
