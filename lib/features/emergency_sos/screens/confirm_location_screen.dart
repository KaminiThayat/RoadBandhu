import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/rescue_map_view.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/localization/app_localizations.dart';
import 'nearby_help_screen.dart';

class ConfirmLocationScreen extends StatefulWidget {
  final String serviceType;

  const ConfirmLocationScreen({
    super.key,
    this.serviceType = 'Emergency Roadside Assistance',
  });

  @override
  State<ConfirmLocationScreen> createState() => _ConfirmLocationScreenState();
}

class _ConfirmLocationScreenState extends State<ConfirmLocationScreen> {
  final String _locationName = 'Chamoli - Badrinath Road (NH-7)';
  final String _subLocation = 'Near Pipalkoti, Chamoli District, Uttarakhand';
  final String _coordinates = 'Lat: 30.4412° N, Long: 79.5768° E';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('confirm_location'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          // Interactive Map Area (Takes top portion)
          Expanded(
            child: RescueMapView(
              height: double.infinity,
              locationTitle: _locationName,
              locationSubtitle: _coordinates,
              showMechanic: false,
              showRoute: false,
            ),
          ),

          // Bottom Confirmation Card
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFFDCFCE7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.gps_fixed, color: AppColors.success, size: 20),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        context.tr('gps_accurate'),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.success,
                        ),
                      ),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.edit_location_alt, size: 16, color: AppColors.primary),
                        label: Text(
                          context.tr('change_location'),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Text(
                    _locationName,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _subLocation,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _coordinates,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mountainSlate,
                    ),
                  ),
                  const SizedBox(height: 20),

                  CustomButton(
                    text: '${context.tr('confirm_and_continue')} →',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NearbyHelpScreen(
                            serviceType: widget.serviceType,
                            location: _locationName,
                          ),
                        ),
                      );
                    },
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
