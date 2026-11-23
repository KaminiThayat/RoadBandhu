import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/rescue_map_view.dart';
import '../../../core/localization/app_localizations.dart';

class SafeRoutePlannerScreen extends StatefulWidget {
  const SafeRoutePlannerScreen({super.key});

  @override
  State<SafeRoutePlannerScreen> createState() => _SafeRoutePlannerScreenState();
}

class _SafeRoutePlannerScreenState extends State<SafeRoutePlannerScreen> {
  final _fromController = TextEditingController(text: 'Rishikesh, Uttarakhand');
  final _toController = TextEditingController(text: 'Badrinath, Uttarakhand');

  int _selectedRoute = 0; // 0: Safest, 1: Faster, 2: Alternate
  bool _avoidRoadblocks = true;
  bool _avoidLandslide = true;
  bool _weatherSafe = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('safe_route_planner'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Route inputs card
            Container(
              padding: const EdgeInsets.all(20),
              color: isDark ? AppColors.darkCard : Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          const Icon(Icons.circle, color: AppColors.success, size: 14),
                          Container(width: 2, height: 36, color: AppColors.mountainSlate.withAlpha(80)),
                          const Icon(Icons.location_on, color: AppColors.primary, size: 16),
                        ],
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          children: [
                            TextField(
                              controller: _fromController,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : AppColors.lightTextPrimary,
                              ),
                              decoration: const InputDecoration(
                                labelText: 'From / कहाँ से',
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _toController,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : AppColors.lightTextPrimary,
                              ),
                              decoration: const InputDecoration(
                                labelText: 'To / कहाँ तक',
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Map preview with mountain route
            RescueMapView(
              height: 200,
              locationTitle: 'Rishikesh → Badrinath (NH-7 Highway)',
              locationSubtitle: 'Live landslide geofence detour active',
              showMechanic: true,
              showRoute: true,
            ),

            // Route Options & Avoidances
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Route Options / मार्ग विकल्प',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 12),

                  _buildRouteOption(
                    index: 0,
                    title: 'Safest Route (Recommended)',
                    hindiTitle: 'सबसे सुरक्षित (अनुशंसित)',
                    time: '10 h 20 min',
                    distance: '298 km',
                    tag: 'No Landslides',
                    tagColor: AppColors.success,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 10),
                  _buildRouteOption(
                    index: 1,
                    title: 'Faster Route',
                    hindiTitle: 'तेज़ गति',
                    time: '9 h 45 min',
                    distance: '282 km',
                    tag: 'Moderate Caution',
                    tagColor: AppColors.alertMedium,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 10),
                  _buildRouteOption(
                    index: 2,
                    title: 'Alternate Route (via Devprayag)',
                    hindiTitle: 'वैकल्पिक (मार्ग बंद होने पर)',
                    time: '11 h 30 min',
                    distance: '315 km',
                    tag: 'Long Distance',
                    tagColor: AppColors.mountainSlate,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 20),

                  // Toggles
                  const Text(
                    'Safety Detour Preferences',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    value: _avoidRoadblocks,
                    activeColor: AppColors.primary,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Avoid Road Blocks / सड़क अवरोध से बचें', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    onChanged: (v) => setState(() => _avoidRoadblocks = v),
                  ),
                  SwitchListTile(
                    value: _avoidLandslide,
                    activeColor: AppColors.primary,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Avoid Landslide Zones / भूस्खलन क्षेत्र से बचें', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    onChanged: (v) => setState(() => _avoidLandslide = v),
                  ),
                  SwitchListTile(
                    value: _weatherSafe,
                    activeColor: AppColors.primary,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Weather Safe Route / मौसम के अनुसार सुरक्षित मार्ग', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    onChanged: (v) => setState(() => _weatherSafe = v),
                  ),
                  const SizedBox(height: 24),

                  CustomButton(
                    text: '${context.tr('plan_navigation')} →',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Safe Route Navigation started with live landslide alerts!'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteOption({
    required int index,
    required String title,
    required String hindiTitle,
    required String time,
    required String distance,
    required String tag,
    required Color tagColor,
    required bool isDark,
  }) {
    final isSelected = _selectedRoute == index;

    return InkWell(
      onTap: () => setState(() => _selectedRoute = index),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.darkSurface : const Color(0xFFFEF2F2))
              : (isDark ? AppColors.darkCard : Colors.white),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primary : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Radio<int>(
              value: index,
              groupValue: _selectedRoute,
              activeColor: AppColors.primary,
              onChanged: (v) => setState(() => _selectedRoute = v!),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : AppColors.lightTextPrimary,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: tagColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: tagColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    hindiTitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$time • $distance',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
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
