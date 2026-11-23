import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/rescue_map_view.dart';
import '../../../core/widgets/custom_button.dart';

class ETARouteMapScreen extends StatelessWidget {
  const ETARouteMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ETA & Route Map',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: RescueMapView(
              height: double.infinity,
              locationTitle: 'NH-7 Badrinath Road',
              locationSubtitle: 'Real-time GPS Tracking via Alaknanda Valley',
              showMechanic: true,
              showRoute: true,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(isDark ? 50 : 15),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Live ETA',
                            style: TextStyle(fontSize: 12, color: AppColors.mountainSlate, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            '18 min',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.success),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Distance',
                            style: TextStyle(fontSize: 12, color: AppColors.mountainSlate, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '6.4 km',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: isDark ? Colors.white : AppColors.alpineNavy),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Terrain',
                            style: TextStyle(fontSize: 12, color: AppColors.mountainSlate, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'NH-7 Valley',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkSurface : AppColors.lightBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.terrain, color: AppColors.alertMedium, size: 20),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Hairpin Curves Ahead • Speed Limit 30 km/h • Moderate Gradient',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  CustomButton(
                    text: 'Close Route View',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
